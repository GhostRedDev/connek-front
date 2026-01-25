import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/services/api_service.dart';
import '../../settings/providers/profile_provider.dart';
import '../models/booking_model.dart';

class BookingService {
  final ApiService _apiService;
  final Ref _ref;

  BookingService(this._apiService, this._ref);

  Future<List<BookingModel>> fetchBookings({required String role}) async {
    try {
      if (role == 'business') {
        return await _fetchBusinessBookings();
      } else {
        return await _fetchClientBookings();
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  Future<List<BookingModel>> _fetchBusinessBookings() async {
    final profile = await _ref.read(profileProvider.future);
    if (profile == null || profile.businessId == null) return [];

    final businessId = profile.businessId!;
    // Use LeadsService which has the logic
    // We need to access the provider or pass the service.
    // LeadsService is not injected, so we assume we can read it or replicate the fetch.
    // Simplest is to read the direct DB here or use LeadsService reference if we add it.

    try {
      final data = await Supabase.instance.client
          .from('leads')
          .select('*, requests(*, client(*)), services(*)')
          .eq('business_id', businessId)
          .neq('status', 'declined') // Hide declined
          .order('created_at', ascending: false);

      return (data as List).map((json) => _mapLeadToBooking(json)).toList();
    } catch (e) {
      print('DB Error fetching business bookings: $e');
      return [];
    }
  }

  Future<List<BookingModel>> _fetchClientBookings() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return [];

    final profile = await _ref.read(profileProvider.future);
    if (profile == null) return [];

    try {
      final response = await _apiService.get('/requests/client/${profile.id}');
      if (response != null &&
          response['success'] == true &&
          response['data'] is List) {
        final List data = response['data'];
        return data.map((item) => _mapRequestToBooking(item)).toList();
      }
    } catch (e) {
      print('API Error fetching client bookings: $e');
    }

    return [];
  }

  Future<BookingModel?> getBookingById(String id) async {
    // Basic implementation: Fetch all and find
    // Optimization: If cache exists in provider, use it.
    // For now, simple fetch.
    final role = (id.startsWith('BK') || id.startsWith('LD'))
        ? 'business'
        : 'client';
    final list = await fetchBookings(role: role);
    try {
      return list.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateBookingStatus(String id, BookingStatus status) async {
    final leadId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (leadId == null) return;

    String statusStr = 'pending';
    if (status == BookingStatus.cancelled) statusStr = 'cancelled';
    if (status == BookingStatus.completed) statusStr = 'completed';
    if (status == BookingStatus.confirmed) statusStr = 'accepted';

    await Supabase.instance.client
        .from('leads')
        .update({'status': statusStr})
        .eq('id', leadId);

    await Supabase.instance.client
        .from('leads')
        .update({'status': statusStr})
        .eq('id', leadId);

    // Invalidation moved to Controller
  }

  Future<void> rescheduleBooking(
    String id,
    DateTime newDate,
    String time,
  ) async {
    final leadId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (leadId == null) return;

    // Combine date and time string "HH:mm"
    // Assuming 'time' string is like "14:30 • 30 min" or just "14:30"
    // We parse basic HH:mm
    final timeParts = time.split(' ')[0].split(':');
    int hour = int.tryParse(timeParts[0]) ?? 0;
    int minute = int.tryParse(timeParts[1]) ?? 0;

    final finalDate = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      hour,
      minute,
    );

    await Supabase.instance.client
        .from('leads')
        .update({
          'proposed_booking_date': finalDate.toIso8601String(),
          'booking_made': true, // Auto confirm booking made
        })
        .eq('id', leadId);

    // Invalidation moved to Controller
  }

  Future<bool> createManualBooking({
    required int clientId,
    required int serviceId,
    required DateTime date,
  }) async {
    try {
      final profile = _ref.read(profileProvider).value;
      if (profile?.businessId == null) return false;

      // 1. Create Request
      final requestRes = await Supabase.instance.client
          .from('requests')
          .insert({
            'client_id': clientId,
            'description': 'Reserva Manual (Business)',
            'is_direct': true,
            'status': 'pending',
            // Add budget/title if needed
          })
          .select()
          .single();

      final requestId = requestRes['id'];

      // 2. Create Lead
      await Supabase.instance.client.from('leads').insert({
        'business_id': profile!.businessId,
        'lead_id': requestId, // Column name might be lead_id or request_id.
        // In features_migration.sql, leads usually references requests.
        // Checking Lead model, it maps 'requestId' to 'request_id'.
        // Checking `LeadsService` fetch, it joins `requests`.
        // Standard naming: `request_id` or `lead_id` referencing `requests(id)`.
        // I will assume `request_id` based on standard practice, but earlier code used `lead_id` for request?
        // Let's check `_mapRequestToBooking`. It calls `json['leads']`.
        // Lead model: `requestId: json['request_id']`. So column is `request_id`.
        'request_id': requestId,
        'service_id': serviceId,
        'status': 'accepted',
        'booking_made': true,
        'proposed_booking_date': date.toIso8601String(),
        'seen': true,
        'client_contacted': true,
        'proposal_sent': true,
        'proposal_accepted': true,
      });

      // Invalidation moved to Controller
      return true;
    } catch (e) {
      print('Error creating manual booking: $e');
      return false;
    }
  }

  BookingModel _mapLeadToBooking(Map<String, dynamic> json) {
    final request = json['requests'] ?? {};
    final clientJson = request['client'] ?? {};
    final serviceJson = json['services'] ?? {}; // If joined

    // Date Logic
    DateTime date = DateTime.now();
    final proposed = json['proposed_booking_date'];
    if (proposed != null) {
      date = DateTime.tryParse(proposed) ?? DateTime.now();
    } else {
      date = DateTime.tryParse(json['created_at']) ?? DateTime.now();
    }

    // Status
    final statusStr = json['status'] ?? 'pending';
    BookingStatus status = BookingStatus.pending;
    if (statusStr == 'accepted' || statusStr == 'converted')
      status = BookingStatus.confirmed;
    if (statusStr == 'completed') status = BookingStatus.completed;
    if (statusStr == 'cancelled' || statusStr == 'declined')
      status = BookingStatus.cancelled;

    // Check booking_made flag
    if (json['booking_made'] == true &&
        status != BookingStatus.completed &&
        status != BookingStatus.cancelled) {
      // Force confirmed visual if booking is marked made
      status = BookingStatus.confirmed;
    }

    // Image
    String clientImg = '';
    final rawImg = clientJson['photo_id'] ?? clientJson['profile_url'];
    if (rawImg != null && rawImg.toString().isNotEmpty) {
      if (!rawImg.toString().startsWith('http')) {
        clientImg =
            'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/client/$rawImg';
      } else {
        clientImg = rawImg;
      }
    }

    String serviceName = serviceJson['name'] ?? 'Servicio General';
    String serviceImg = 'https://via.placeholder.com/150';

    try {
      if (serviceJson['images'] != null) {
        final rawImgs = serviceJson['images'];
        List imgs = [];
        if (rawImgs is String) {
          imgs = jsonDecode(rawImgs);
        } else if (rawImgs is List) {
          imgs = rawImgs;
        }

        if (imgs.isNotEmpty) {
          String img = imgs.first;
          if (!img.startsWith('http')) {
            serviceImg =
                'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/$img';
          } else {
            serviceImg = img;
          }
        }
      }
    } catch (_) {}

    return BookingModel(
      id: 'LD${json['id']}', // LD prefix for Leads
      title: '${clientJson['first_name']} ${clientJson['last_name']}',
      type: 'Cita',
      status: status,
      date: date,
      timeRange: DateFormat('HH:mm').format(date),
      price: 0.0, // Need to fetch Quote if we want price, or service price
      client: BookingParticipant(
        id: (clientJson['id'] ?? 0).toString(),
        name: '${clientJson['first_name']} ${clientJson['last_name']}',
        role: 'Cliente',
        image: clientImg,
      ),
      agent: BookingParticipant(
        id: (json['business_id'] ?? 0).toString(),
        name: 'Tu Negocio',
        role: 'Proveedor',
        image: '',
      ),
      serviceName: serviceName,
      serviceImage: serviceImg,
    );
  }

  // Deprecated usage but kept for reference if needed
  BookingModel _mapQuoteToBooking(Map<String, dynamic> json) {
    final leads = json['leads'] ?? {};
    final request = leads['requests'] ?? {};
    final clientJson = request['client'] ?? {};
    final serviceJson = json['services'] ?? {};

    DateTime date = DateTime.now();
    final leadDate = leads['proposed_booking_date'];
    if (leadDate != null) {
      date = DateTime.tryParse(leadDate) ?? DateTime.now();
    } else {
      date = DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now();
    }

    // Status Mapping
    BookingStatus status = BookingStatus.pending;
    final statusStr = json['status']?.toString().toLowerCase() ?? 'pending';
    if (statusStr == 'accepted' || statusStr == 'confirmed')
      status = BookingStatus.confirmed;
    if (statusStr == 'completed') status = BookingStatus.completed;
    if (statusStr == 'cancelled') status = BookingStatus.cancelled;

    // Image Handling
    String serviceImg = 'https://via.placeholder.com/150';
    try {
      if (serviceJson['images'] != null) {
        final rawImgs = serviceJson['images'];
        List imgs = [];
        if (rawImgs is String) {
          imgs = jsonDecode(rawImgs);
        } else if (rawImgs is List) {
          imgs = rawImgs;
        }

        if (imgs.isNotEmpty) {
          String img = imgs.first;
          if (!img.startsWith('http')) {
            serviceImg =
                'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/$img';
          } else {
            serviceImg = img;
          }
        }
      }
    } catch (_) {}

    String clientImg = '';
    final profileUrl = clientJson['profile_url'] as String?;
    if (profileUrl != null && profileUrl.isNotEmpty) {
      if (!profileUrl.startsWith('http')) {
        clientImg =
            'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/client/$profileUrl';
      } else {
        clientImg = profileUrl;
      }
    }

    return BookingModel(
      id: 'BK${json['id']}',
      title: serviceJson['name'] ?? 'Servicio',
      type: 'Servicio',
      status: status,
      date: date,
      timeRange: DateFormat('HH:mm').format(date),
      price: ((json['amountCents'] ?? 0) / 100).toDouble(),
      client: BookingParticipant(
        id: (clientJson['id'] ?? 0).toString(),
        name:
            '${clientJson['first_name'] ?? 'Cliente'} ${clientJson['last_name'] ?? ''}',
        role: 'Cliente',
        image: clientImg,
      ),
      agent: BookingParticipant(
        id: (json['business_id'] ?? 0).toString(),
        name: 'Tu Negocio',
        role: 'Proveedor',
        image: '',
      ),
      serviceName: serviceJson['name'] ?? 'Servicio',
      serviceImage: serviceImg,
    );
  }

  BookingModel _mapRequestToBooking(Map<String, dynamic> json) {
    final clientJson = json['client'] ?? {};

    // Extract Business Info from Leads
    String businessName = 'Buscando...';
    String businessImage = '';
    String businessId = '0';

    if (json['leads'] != null &&
        json['leads'] is List &&
        (json['leads'] as List).isNotEmpty) {
      final List leads = json['leads'];
      // Prefer accepted lead, otherwise take first
      var targetLead = leads.firstWhere(
        (l) => l['status'] == 'accepted',
        orElse: () => leads.first,
      );

      final business = targetLead['business'] ?? {};
      businessName = business['name'] ?? 'Negocio';
      businessId = (business['id'] ?? 0).toString();

      // Handle Business Image
      final logoUrl = business['logo_url'] as String?;
      if (logoUrl != null && logoUrl.isNotEmpty) {
        if (!logoUrl.startsWith('http')) {
          businessImage =
              'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/$logoUrl';
        } else {
          businessImage = logoUrl;
        }
      }
    }

    return BookingModel(
      id: 'CL${json['id']}',
      title: json['title'] ?? 'Solicitud',
      type: 'Solicitud',
      status: BookingStatus.pending,
      date: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      timeRange: '10:00 - 11:00', // Mock or parse if available
      price: (json['amount'] ?? 0).toDouble(),
      client: BookingParticipant(
        id: (clientJson['id'] ?? 0).toString(),
        name: '${clientJson['first_name'] ?? 'Yo'}',
        role: 'Client',
        image: '', // Can map client image if needed
      ),
      agent: BookingParticipant(
        id: businessId,
        name: businessName,
        role: 'Agente asignado',
        image: businessImage,
      ),
      serviceName: json['service']?['name'] ?? 'Servicio',
      serviceImage: '',
    );
  }
}
