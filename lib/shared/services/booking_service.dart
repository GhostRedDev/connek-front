import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';
import '../../features/settings/providers/profile_provider.dart';
import '../models/booking_model.dart';

class BookingService {
  final ApiService _apiService;
  final Ref _ref;
  final SupabaseClient _supabase = Supabase.instance.client;

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
    }

    // Fallback: Direct DB Query
    try {
      print('DEBUG: Trying Direct DB for Business Bookings');
      final response = await _supabase
          .from('bookings')
          .select('*, client:clients(*), service:services(*)')
          .eq('business_id', businessId)
          .order('created_at', ascending: false);

      final List data = response as List;
      return data.map((json) {
        // Transform Supabase structure to Model
        // Note: 'client' and 'service' are objects thanks to select()
        final enrichedJson = Map<String, dynamic>.from(json);
        if (json['client'] != null) enrichedJson['client'] = json['client'];
        // If no quote, create dummy quote structure for price if available in service
        if (json['service'] != null) {
          final svc = json['service'];
          final cents =
              svc['price_cents'] ??
              (svc['price'] != null ? (svc['price'] * 100).toInt() : 0);
          enrichedJson['quote'] = {
            'amountCents': cents,
            'description': svc['name'],
          };
          enrichedJson['requests'] = {
            'services': svc,
          }; // Mock structure for mapper
        }
        return _mapBackendBookingToModel(enrichedJson, isBusiness: true);
      }).toList();
    } catch (dbError) {
      print('DB Error fetching business bookings: $dbError');
    }

    return [];
  }

  Future<List<BookingModel>> _fetchClientBookings() async {
    final profile = await _ref.read(profileProvider.future);
    if (profile == null) {
      print('DEBUG: Profile is null in _fetchClientBookings');
      return [];
    }
    print(
      'DEBUG: Fetching client bookings. ID (int): ${profile.id}, UserID (UUID): ${profile.userId}',
    );

    // Strategy: Try multiple endpoints since backend route is uncertain without docs
    final endpoints = [
      '/bookings/client/${profile.id}',
      '/bookings?client_id=${profile.id}',
      '/bookings/user/${profile.userId}', // Try UUID
      '/client/${profile.id}/bookings',
    ];

    for (final endpoint in endpoints) {
      try {
        print('DEBUG: Trying endpoint: $endpoint');
        final response = await _apiService.get(endpoint);
        print(
          'DEBUG: Response for $endpoint: ${response != null ? "OK" : "NULL"}',
        );

        dynamic rawData = [];
        if (response is Map && response['success'] == true) {
          rawData = response['data'];
        } else if (response is List) {
          rawData = response;
        }

        if (rawData is List) {
          print('DEBUG: Found ${rawData.length} bookings at $endpoint');
          if (rawData.isNotEmpty) {
            return rawData
                .map((json) {
                  try {
                    return _mapBackendBookingToModel(json, isBusiness: false);
                  } catch (e) {
                    print('DEBUG: Map error: $e');
                    return null;
                  }
                })
                .whereType<BookingModel>()
                .toList();
          }
          // If empty, we might want to return empty immediately
          // But if we are iterating endpoints, maybe the first one returned empty (correctly)
          // and we stop? Or maybe it was the wrong endpoint that returned empty?
          // We'll assume the FIRST endpoint that returns a valid structure is the correct one.
          // So if we get [] from the first one, we return [] and stop.
          return [];
        }
      } catch (e) {
        print('DEBUG: Endpoint $endpoint failed: $e');
      }
    }

    // Direct DB Fallback
    try {
      print('DEBUG: Trying Direct DB for Client Bookings');
      final response = await _supabase
          .from('bookings')
          .select(
            '*, business:business!bookings_business_id_fkey(*), requests:requests(*, services:services(*))',
          )
          .eq('client_id', profile.id)
          .order('created_at', ascending: false);

      final List data = response as List;
      return data.map((json) {
        final enrichedJson = Map<String, dynamic>.from(json);
        if (json['business'] != null)
          enrichedJson['business'] = json['business'];

        // Populate service details from linked request if available
        if (json['requests'] != null) {
          final request = json['requests'];
          // Supabase single object if one-to-one or list if one-to-many.
          // Assuming booking -> request is 1:1 or 1:N but we take first.
          // However standard join might return list. Let's handle it.
          Map<String, dynamic>? svc;
          if (request is List && request.isNotEmpty) {
            if (request[0]['services'] != null) svc = request[0]['services'];
          } else if (request is Map && request['services'] != null) {
            svc = request['services'];
          }

          if (svc != null) {
            enrichedJson['requests'] = {'services': svc};
            final cents =
                svc['price_cents'] ??
                (svc['price'] != null ? (svc['price'] * 100).toInt() : 0);
            enrichedJson['quote'] = {'amountCents': cents};
          }
        }
        return _mapBackendBookingToModel(enrichedJson, isBusiness: false);
      }).toList();
    } catch (dbError) {
      print('DB Error fetching client bookings: $dbError');
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
    if (status == BookingStatus.in_progress) statusStr = 'in_progress';

    try {
      // Use PATCH with URL-encoded body for status updates
      await _apiService.putUrlEncoded('/bookings/$numericId', {
        'status': statusStr,
      });
    } catch (e) {
      print('Error updating booking status: $e');
      // Direct DB Fallback
      try {
        await _supabase
            .from('bookings')
            .update({'status': statusStr})
            .eq('id', numericId);
        print('Direct DB Status Update Success');
      } catch (dbError) {
        print('Direct DB Status Update Error: $dbError');
      }
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
      await _apiService.putUrlEncoded('/bookings/$numericId', {
        'start_time_utc': finalDate.toUtc().toIso8601String(),
      });
    } catch (e) {
      print('Error rescheduling booking: $e');
    }
  }

  Future<bool> createManualBooking({
    required int clientId,
    required int serviceId,
    required DateTime date,
    int? staffId,
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

          // Check for nested addresses object (as seen in logs)
          if (businessData['addresses'] != null &&
              businessData['addresses'] is Map) {
            addressId = businessData['addresses']['id'] ?? 0;
          }
          // Fallback to root level if not nested
          else if (businessData['address_id'] != null) {
            addressId = businessData['address_id'];
          }
        }
      } catch (e) {
        print('Could not fetch business address: $e');
      }

      if (addressId == 0) {
        print(
          'Warning: Using address_id=0 (fallback), backend may use business_id',
        );
      }

      // 2. Create Booking via API
      // Backend automatically creates Request/Lead/Quote if missing.
      final payload = {
        'client_id': clientId,
        'business_id': businessId,
        'address_id': addressId,
        'service_id': serviceId,
        'start_time_utc': date.toUtc().toIso8601String(),
        // 'end_time_utc': null, // Backend calculates from service duration
      };

      if (staffId != null) {
        payload['resource_id'] = staffId;
      }

      print('📤 CreateManualBooking: Sending payload: $payload');

      final response = await _apiService.postUrlEncoded(
        '/bookings/create',
        payload,
      );

      if (response != null && response['success'] == true) {
        print('✅ CreateManualBooking: Success - Booking created');
        return true;
      }

      print(
        '⚠️ CreateManualBooking: Failed - ${response?['error'] ?? 'Unknown error'}',
      );
      return false;
    } catch (e) {
      print('❌ Error creating manual booking: $e');
      return false;
    }
  }

  Future<bool> createClientBooking({
    required int businessId,
    required int serviceId,
    required DateTime date,
    int? employeeId,
    Map<String, dynamic>? customFormAnswers,
  }) async {
    dynamic profile;
    int? clientId;
    int addressId = 0;

    try {
      profile = _ref.read(profileProvider).value;
      if (profile == null) return false;
      clientId = profile.id;

      // 1. Fetch Business to get address_id
      try {
        final businessRes = await _apiService.get('/business/full/$businessId');
        if (businessRes != null && businessRes['success'] == true) {
          final businessData = businessRes['data'];

          // Check for nested addresses object (as seen in logs)
          if (businessData['addresses'] != null &&
              businessData['addresses'] is Map) {
            addressId = businessData['addresses']['id'] ?? 0;
          }
          // Fallback to root level if not nested
          else if (businessData['address_id'] != null) {
            addressId = businessData['address_id'];
          }

          print(
            'CreateBooking: Determined addressId=$addressId from business data',
          );
        }
      } catch (e) {
        print('CreateBooking: Error fetching business address: $e');
      }

      // 2. Create Booking via API
      final Map<String, dynamic> fields = {
        'client_id': clientId,
        'business_id': businessId,
        'address_id': addressId, // Can be 0 if unknown
        'service_id': serviceId,
        'start_time_utc': date.toUtc().toIso8601String(),
        if (employeeId != null) 'employee_id': employeeId,
      };

      if (customFormAnswers != null) {
        fields['custom_form_answers'] = jsonEncode(customFormAnswers);
      }

      final response = await _apiService.postForm(
        '/bookings/create',
        fields: fields,
      );

      if (response != null && response['success'] == true) {
        print('✅ CreateClientBooking: Success - Booking created');
        return true;
      }

      print(
        '⚠️ CreateClientBooking: Failed - ${response?['error'] ?? 'Unknown error'}',
      );
      return false;
    } catch (e) {
      print('Error creating client booking via API: $e. Using DB Fallback.');

      if (profile == null || clientId == null) return false;

      // Direct DB Fallback
      try {
        final payload = {
          'client_id': clientId,
          'business_id': businessId,
          // 'service_id': serviceId, // Column likely missing or named differently (e.g. quote/request link)
          'start_time_utc': date.toIso8601String(),
          'status': 'pending',
          if (employeeId != null) 'employee_id': employeeId,
          if (customFormAnswers != null)
            'custom_form_answers': customFormAnswers,
          // 'created_by': profile.userId,
        };

        // If addressId > 0 use it
        if (addressId > 0) {
          payload['address_id'] = addressId;
        }

        print('DEBUG: DB Insert Payload Keys: ${payload.keys.toList()}');
        await _supabase.from('bookings').insert(payload);
        print('Direct DB Booking Creation Success');
        return true;
      } catch (dbError) {
        print('Direct DB Error creating booking: $dbError');
        return false;
      }
    }
  }

  /// Update an existing booking
  /// Supports updating: start_time_utc, service_id, resource_id (staff), status
  Future<bool> updateBooking({
    required String bookingId,
    DateTime? newDate,
    int? newServiceId,
    int? newStaffId,
    String? newStatus,
  }) async {
    final numericId = int.tryParse(bookingId.replaceAll(RegExp(r'[^0-9]'), ''));
    if (numericId == null) return false;

    try {
      final Map<String, dynamic> updateData = {};

      if (newDate != null) {
        updateData['start_time_utc'] = newDate.toUtc().toIso8601String();
      }

      if (newServiceId != null) {
        updateData['service_id'] = newServiceId;
      }

      if (newStaffId != null) {
        updateData['resource_id'] = newStaffId;
      }

      if (newStatus != null) {
        updateData['status'] = newStatus;
      }

      if (updateData.isEmpty) {
        print('⚠️ UpdateBooking: No fields to update');
        return false;
      }

      print('📤 UpdateBooking [$numericId]: Sending payload: $updateData');

      final response = await _apiService.putUrlEncoded(
        '/bookings/$numericId',
        updateData,
      );

      if (response != null && response['success'] == true) {
        print('✅ UpdateBooking [$numericId]: Success');
        return true;
      }

      print(
        '⚠️ UpdateBooking [$numericId]: Failed - ${response?['error'] ?? 'Unknown error'}',
      );
      return false;
    } catch (e) {
      print('❌ Error updating booking [$numericId]: $e');
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
      final response = await _apiService.postUrlEncoded(
        '/bookings/$numericId/rebook',
        {'booking_date': dateStr, 'start_time': startTime, 'end_time': endTime},
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
    } else if (statusStr == 'in_progress') {
      status = BookingStatus.in_progress;
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

    // Location
    String? location;
    if (json['address'] != null) {
      if (json['address'] is String) {
        location = json['address'];
      } else if (json['address'] is Map) {
        location = json['address']['address'];
        if (json['address']['city'] != null) {
          location = '$location, ${json['address']['city']}';
        }
      }
    }

    return BookingModel(
      id: idStr,
      title: serviceName, // Use service name as title
      type: 'Cita',
      status: status,
      date: date,
      timeRange: DateFormat('HH:mm').format(date),
      location: location,
      price: price,
      client: BookingParticipant(
        id: (json['client_id'] ?? 0).toString(),
        name: clientName,
        role: 'Cliente',
        image: clientImg,
        phone: json['client']?['phone']?.toString(), // Map client phone
      ),
      agent: BookingParticipant(
        id: (json['business_id'] ?? 0).toString(),
        name: businessName,
        role: 'Proveedor',
        image: businessImg,
        phone: json['business']?['phone']?.toString(), // Map business phone
      ),
      serviceName: serviceName,
      serviceImage: serviceImg,
      customFormAnswers: json['custom_form_answers'] is Map
          ? json['custom_form_answers']
          : null,
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
