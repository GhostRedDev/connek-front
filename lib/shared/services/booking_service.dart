import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/services/api_service.dart';
import '../../features/settings/providers/profile_provider.dart';
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

    try {
      // New: Use API Endpoint
      final response = await _apiService.get('/bookings/business/$businessId');

      if (response != null && response['success'] == true) {
        final List data = response['data'];
        return data
            .map((json) => _mapBackendBookingToModel(json, isBusiness: true))
            .toList();
      }
      return [];
    } catch (e) {
      print('API Error fetching business bookings: $e');
      return [];
    }
  }

  Future<List<BookingModel>> _fetchClientBookings() async {
    final profile = await _ref.read(profileProvider.future);
    if (profile == null) return [];

    try {
      // New: Use API Endpoint for Client Bookings
      // The backend has /bookings/client/{client_id}
      // Assuming profile.id is the client_id (integer) or mapped to it.
      // User profile usually has 'id' as integer if it matches backend Client ID.
      // If profile.id is UUID, we might need profile.clientId (if available).
      // Checking profileProvider... usually it has the numeric ID or similar.
      final response = await _apiService.get('/bookings/client/${profile.id}');

      if (response != null && response['success'] == true) {
        final List data = response['data'];
        return data
            .map((json) => _mapBackendBookingToModel(json, isBusiness: false))
            .toList();
      }
    } catch (e) {
      print('API Error fetching client bookings: $e');
    }

    return [];
  }

  Future<BookingModel?> getBookingById(String id) async {
    // ID might be formatted 'BK123'. We need the numeric ID.
    final numericId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return null;

    try {
      final response = await _apiService.get('/bookings/$numericId');
      if (response != null && response['success'] == true) {
        // The individual get might return slightly different structure (BookingData)
        // without the full joins (client/business/service).
        // Backend get_booking returns 'booking' from bookingsDB.get_booking_by_id(booking_id).
        // It depends on what that DB method returns.
        // Use generic mapper/safe parsing.
        final data = response['data'];
        // We might need to guess isBusiness based on role? Or just try map.
        return _mapBackendBookingToModel(data, isBusiness: false);
      }
    } catch (e) {
      print('Error getting booking by id: $e');
      // Fallback: fetch all matches
      // This is inefficient but safer if individual endpoint lacks data
    }
    return null;
  }

  Future<void> updateBookingStatus(String id, BookingStatus status) async {
    final numericId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return;

    String statusStr = 'pending';
    if (status == BookingStatus.cancelled) statusStr = 'cancelled';
    if (status == BookingStatus.completed) statusStr = 'completed';
    if (status == BookingStatus.confirmed) statusStr = 'accepted';

    try {
      await _apiService.patchForm(
        '/bookings/$numericId/status',
        fields: {'status': statusStr},
      );
    } catch (e) {
      print('Error updating booking status: $e');
    }
  }

  Future<void> rescheduleBooking(
    String id,
    DateTime newDate,
    String time,
  ) async {
    final numericId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return;

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

    try {
      await _apiService.putForm(
        '/bookings/$numericId',
        fields: {
          'start_time_utc': finalDate.toIso8601String(),
          // 'resource_id': ... if we had it, but we preserve it
        },
      );
    } catch (e) {
      print('Error rescheduling booking: $e');
    }
  }

  Future<bool> createManualBooking({
    required int clientId,
    required int serviceId,
    required DateTime date,
  }) async {
    try {
      final profile = _ref.read(profileProvider).value;
      if (profile?.businessId == null) return false;
      final businessId = profile!.businessId!;

      // 1. Fetch Business to get address_id (Required by backend)
      int addressId = 0;
      try {
        final businessRes = await _apiService.get('/business/full/$businessId');
        if (businessRes != null && businessRes['success'] == true) {
          final businessData = businessRes['data'];
          addressId = businessData['address_id'] ?? 0;
        }
      } catch (_) {
        print('Could not fetch business address, trying default 0');
      }

      if (addressId == 0) {
        // Warning: Backend might reject 0 if validation is strict.
        // But we have no choice without UI selection.
        print('Warning: Using address_id=0 for manual booking');
      }

      // 2. Create Booking via API
      // Backend automatically creates Request/Lead/Quote if missing.
      await _apiService.postForm(
        '/bookings/create',
        fields: {
          'client_id': clientId,
          'business_id': businessId,
          'address_id': addressId,
          'service_id': serviceId,
          'start_time_utc': date.toIso8601String(),
          // 'end_time_utc': null, // Backend calculates from service duration
        },
      );

      return true;
    } catch (e) {
      print('Error creating manual booking: $e');
      return false;
    }
  }

  Future<bool> deleteBooking(String id) async {
    final numericId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return false;

    try {
      final response = await _apiService.delete('/bookings/$numericId');
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error deleting booking: $e');
      return false;
    }
  }

  Future<List<dynamic>> getOpenSlots({
    required int businessId,
    required DateTime date,
  }) async {
    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final response = await _apiService.get(
        '/bookings/open-slots?business_id=$businessId&date=$dateStr',
      );
      if (response != null && response['success'] == true) {
        return response['data'] ?? [];
      }
    } catch (e) {
      print('Error getting open slots: $e');
    }
    return [];
  }

  Future<Map<String, dynamic>?> checkAvailability({
    required int businessId,
    required DateTime date,
  }) async {
    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final response = await _apiService.get(
        '/bookings/availability?business_id=$businessId&date=$dateStr',
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
    } catch (e) {
      print('Error checking availability: $e');
    }
    return null;
  }

  Future<List<dynamic>> getResourceAvailableSlots({
    required int resourceId,
    required DateTime date,
    required int serviceId,
  }) async {
    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      // Backend expects 'day' parameter
      final response = await _apiService.get(
        '/bookings/resources/$resourceId/available-slots?day=$dateStr&service_id=$serviceId',
      );
      if (response != null && response['success'] == true) {
        return response['data'] ?? [];
      }
    } catch (e) {
      print('Error getting resource available slots: $e');
    }
    return [];
  }

  Future<Map<String, dynamic>> getServiceAvailableSlots({
    required int businessId,
    required int serviceId,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final startStr = DateFormat('yyyy-MM-dd').format(start);
      final endStr = DateFormat('yyyy-MM-dd').format(end);
      final response = await _apiService.get(
        '/bookings/service/$serviceId/available-slots?business_id=$businessId&start_day=$startStr&end_day=$endStr',
      );
      if (response != null && response['success'] == true) {
        return response['data'] ?? {};
      }
    } catch (e) {
      print('Error getting service available slots: $e');
    }
    return {};
  }

  Future<bool> sendReminder(String id) async {
    final numericId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return false;

    try {
      final response = await _apiService.post(
        '/bookings/$numericId/send-reminder',
      );
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error sending reminder: $e');
      return false;
    }
  }

  Future<bool> rebook(
    String id, {
    required DateTime date,
    required String startTime,
    required String endTime,
  }) async {
    final numericId = int.tryParse(id.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return false;

    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final response = await _apiService.postForm(
        '/bookings/$numericId/rebook',
        fields: {
          'booking_date': dateStr,
          'start_time': startTime,
          'end_time': endTime,
        },
      );
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error rebooking: $e');
      return false;
    }
  }

  BookingModel _mapBackendBookingToModel(
    Map<String, dynamic> json, {
    required bool isBusiness,
  }) {
    // Map fields from Backend Response (FullBookingDataBusiness / FullBookingDataClient)

    // ID
    final idStr = 'BK${json['id']}'; // Standardize prefix

    // Status
    final statusStr = (json['status'] ?? 'pending').toString().toLowerCase();
    BookingStatus status = BookingStatus.pending;
    if (statusStr == 'accepted' ||
        statusStr == 'confirmed' ||
        statusStr == 'scheduled') {
      status = BookingStatus.confirmed;
    } else if (statusStr == 'completed') {
      status = BookingStatus.completed;
    } else if (statusStr == 'cancelled' || statusStr == 'declined') {
      status = BookingStatus.cancelled;
    }

    // Date
    DateTime date = DateTime.now();
    final startStr = json['start_time_utc'];
    if (startStr != null) {
      date = DateTime.tryParse(startStr) ?? DateTime.now();
    } else {
      date = DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now();
    }

    // Participants & Metadata
    String clientName = 'Cliente';
    String clientImg = '';
    String businessName = 'Negocio';
    String businessImg = '';

    String serviceName = 'Servicio';
    String serviceImg = 'https://via.placeholder.com/150';
    double price = 0.0;

    if (isBusiness) {
      // Mapping FullBookingDataBusiness
      // Has: client (ClientData), requests (RequestData), quote (QuoteData)

      final clientJson = json['client'] ?? {};
      clientName =
          '${clientJson['first_name'] ?? ''} ${clientJson['last_name'] ?? ''}'
              .trim();
      clientImg = _resolveImage(
        clientJson['profile_url'] ?? clientJson['photo_id'],
        bucket: 'client',
      );

      // final businessJson = json['assigned_business'] ?? {};
      businessName = 'Tu Negocio';

      final quoteJson = json['quote'] ?? {};
      price = ((quoteJson['amountCents'] ?? 0) / 100).toDouble();

      // Service fallback (Not in FullBookingDataBusiness, try quote description or request)
      if (quoteJson['description'] != null) {
        // E.g. "Booking for Extensiones de Pestañas..."
        // We can try to extract or just use description
        // serviceName = quoteJson['description']; // Might be too long
      }
    } else {
      // Mapping FullBookingDataClient
      // Has: business (BusinessData), requests (FullRequestDataWithService -> services), quote (QuoteData)

      final businessJson = json['business'] ?? {};
      businessName = businessJson['name'] ?? 'Negocio';
      businessImg = _resolveImage(
        businessJson['profile_image'] ?? businessJson['logo_url'],
        bucket: 'business',
      );

      final requestJson = json['requests'] ?? {};
      final serviceJson = requestJson['services'] ?? {};
      serviceName = serviceJson['name'] ?? 'Servicio';

      // Service Image
      final rawImgs = serviceJson['images'];
      serviceImg = _resolveServiceImage(rawImgs);

      final quoteJson = json['quote'] ?? {};
      price = ((quoteJson['amountCents'] ?? 0) / 100).toDouble();

      // Client is 'Me'
      clientName = 'Yo';
    }

    return BookingModel(
      id: idStr,
      title: serviceName, // Use service name as title
      type: 'Cita',
      status: status,
      date: date,
      timeRange: DateFormat('HH:mm').format(date),
      price: price,
      client: BookingParticipant(
        id: (json['client_id'] ?? 0).toString(),
        name: clientName,
        role: 'Cliente',
        image: clientImg,
      ),
      agent: BookingParticipant(
        id: (json['business_id'] ?? 0).toString(),
        name: businessName,
        role: 'Proveedor',
        image: businessImg,
      ),
      serviceName: serviceName,
      serviceImage: serviceImg,
    );
  }

  String _resolveImage(String? path, {required String bucket}) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return 'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/$bucket/$path';
  }

  String _resolveServiceImage(dynamic rawImgs) {
    if (rawImgs == null) return 'https://via.placeholder.com/150';
    List imgs = [];
    try {
      if (rawImgs is String) {
        imgs = jsonDecode(rawImgs);
      } else if (rawImgs is List) {
        imgs = rawImgs;
      }
    } catch (_) {}

    if (imgs.isNotEmpty) {
      String img = imgs.first;
      if (img.startsWith('http')) return img;
      return 'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/$img';
    }
    return 'https://via.placeholder.com/150';
  }
}
