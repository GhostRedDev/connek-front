import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

    // Fallback if null (shouldn't happen if businessId checked)
    final businessId = profile.businessId ?? 0;

    try {
      final response = await _apiService.get('/quotes/business/$businessId');

      if (response != null &&
          response['success'] == true &&
          response['data'] is List) {
        final List data = response['data'];
        return data.map((item) => _mapQuoteToBooking(item)).toList();
      }
    } catch (e) {
      print('API Error fetching business bookings: $e');
    }
    return [];
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
    final role = id.startsWith('BK') ? 'business' : 'client';
    final list = await fetchBookings(role: role);
    try {
      return list.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateBookingStatus(String id, BookingStatus status) async {
    // Stub
  }

  Future<void> rescheduleBooking(
    String id,
    DateTime newDate,
    String time,
  ) async {
    // Stub
  }

  BookingModel _mapQuoteToBooking(Map<String, dynamic> json) {
    final leads = json['leads'] ?? {};
    final request = leads['requests'] ?? {};
    final clientJson = request['client'] ?? {};
    final serviceJson = json['services'] ?? {};

    DateTime date =
        DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now();

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
      timeRange: 'Por definir',
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
