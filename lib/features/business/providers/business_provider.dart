import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../settings/providers/profile_provider.dart';
import '../../leads/services/leads_service.dart';
import '../../leads/models/lead_model.dart';
import '../../../core/services/api_service.dart';
import '../../../core/providers/auth_provider.dart';

// --- Models ---

class BusinessDashboardData {
  final int totalRequests;
  final double monthEarnings;
  final List<double> activityChart;
  final List<Lead> recentLeads;
  final List<Map<String, dynamic>> employees;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> clients;
  final List<Map<String, dynamic>> quotes;
  final List<Map<String, dynamic>> reviews;
  final List<Map<String, dynamic>> events; // Added events
  final Map<String, dynamic>? businessProfile;

  BusinessDashboardData({
    required this.totalRequests,
    required this.monthEarnings,
    required this.activityChart,
    required this.recentLeads,
    required this.employees,
    required this.services,
    required this.clients,
    required this.quotes,
    required this.reviews,
    required this.events, // Added
    this.businessProfile,
  });

  factory BusinessDashboardData.empty() {
    return BusinessDashboardData(
      totalRequests: 0,
      monthEarnings: 0.0,
      activityChart: [0, 0, 0, 0, 0, 0, 0],
      recentLeads: [],
      employees: [],
      services: [],
      clients: [],
      quotes: [],
      reviews: [],
      events: [], // Added
      businessProfile: null,
    );
  }
}

// --- Repository ---

class BusinessRepository {
  final SupabaseClient _supabase;
  final ApiService _apiService;

  BusinessRepository(this._supabase, this._apiService);

  // Helper to resolve URL
  String? _resolveUrl(String? path, String bucket) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http')) return path;
    return _supabase.storage.from(bucket).getPublicUrl(path);
  }

  // --- Likes ---
  Future<Map<String, dynamic>> getBusinessLikeStatus(
    int businessId,
    String? userId,
  ) async {
    try {
      // 1. Get Count
      final countRes = await _supabase
          .from('business_likes')
          .count()
          .eq('business_id', businessId);

      final count = countRes;

      // 2. Check if liked by user
      bool isLiked = false;
      if (userId != null) {
        // We need client_id corresponding to user_id usually,
        // or business_likes might use user_id directly?
        // Let's assume business_likes uses client_id like review_likes.
        // We need to fetch client_id from user_id first IF table relies on client_id.
        // Or we can try to join.
        // Simpler: Fetch client first (usually cached in ProfileRepository/Provider).
        // But here in Repo we might just use user_id if table supports it.
        // Only Reviews used client_id.
        // Let's assume business_likes uses 'user_id' for simplicity or 'client_id'.
        // I will try to fetch client_id if needed.

        final clientRes = await _supabase
            .from('clients')
            .select('id')
            .eq('user_id', userId)
            .maybeSingle();
        if (clientRes != null) {
          final clientId = clientRes['id'];
          final like = await _supabase
              .from('business_likes')
              .select()
              .eq('business_id', businessId)
              .eq('client_id', clientId)
              .maybeSingle();
          isLiked = like != null;
        }
      }

      return {'count': count, 'isLiked': isLiked};
    } catch (e) {
      // Logic for fallback/error
      return {'count': 0, 'isLiked': false};
    }
  }

  Future<bool> toggleBusinessLike(int businessId, String userId) async {
    try {
      // Get client_id
      final clientRes = await _supabase
          .from('clients')
          .select('id')
          .eq('user_id', userId)
          .single();
      final clientId = clientRes['id'];

      final existing = await _supabase
          .from('business_likes')
          .select()
          .eq('business_id', businessId)
          .eq('client_id', clientId)
          .maybeSingle();

      if (existing != null) {
        await _supabase
            .from('business_likes')
            .delete()
            .eq('id', existing['id']);
        return false; // unliked
      } else {
        await _supabase.from('business_likes').insert({
          'business_id': businessId,
          'client_id': clientId,
        });
        return true; // liked
      }
    } catch (e) {
      print('Error toggling like: $e');
      throw e;
    }
  }

  // --- Events ---
  Future<List<Map<String, dynamic>>> getEvents(int businessId) async {
    try {
      // Try API first if available (mock path)
      // final response = await _apiService.get('/events/business/$businessId');
      // ...

      // Direct DB
      final data = await _supabase
          .from('events')
          .select()
          .eq('business_id', businessId)
          .order('start_date', ascending: true);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('⚠️ Error fetching events (might not exist): $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getBusinessById(int businessId) async {
    try {
      final res = await _supabase
          .from('business')
          .select()
          .eq('id', businessId)
          .maybeSingle();
      if (res != null) {
        return Map<String, dynamic>.from(res);
      }
      return null;
    } catch (e) {
      print('Error fetching business by ID: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMyBusiness(int clientId) async {
    try {
      final response = await _apiService.get(
        '/clients/accounts?client_id=$clientId',
      );
      if (response != null && response['success'] == true) {
        final data = response['data'];
        final businesses = data['businesses'];
        if (businesses is List && businesses.isNotEmpty) {
          return Map<String, dynamic>.from(businesses[0]);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching business via API: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getEmployees(int businessId) async {
    try {
      final response = await _apiService.get(
        '/employees/greg/business/$businessId',
      );
      if (response != null && response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        } else if (data is Map) {
          if (data.containsKey('employees')) {
            return List<Map<String, dynamic>>.from(data['employees']);
          }
          return [Map<String, dynamic>.from(data)];
        }
      }
      throw Exception('API Invalid Response');
    } catch (e) {
      print('⚠️ API fetch failed for employees. Trying Direct DB...');
      try {
        final List<Map<String, dynamic>> combined = [];

        // 1. Fetch Humans & Bots via Chatbot table
        try {
          final chatbots = await _supabase
              .from('chatbot')
              .select('*, employees(*)')
              .eq('business_id', businessId);

          for (var item in chatbots) {
            final employeeData = item['employees'];
            if (employeeData != null) {
              final merged = Map<String, dynamic>.from(employeeData);
              merged['chatbot_id'] = item['id'];
              merged['chatbot_name'] = item['name'];
              combined.add(merged);
            }
          }
        } catch (e) {
          print('Error fetching chatbot/employees table: $e');
        }

        // 2. Fetch Greg (AI)
        try {
          final greg = await _supabase
              .from('greg')
              .select()
              .eq('business_id', businessId)
              .maybeSingle();
          if (greg != null) {
            final gregMap = Map<String, dynamic>.from(greg);
            gregMap['name'] = 'Greg (AI)';
            gregMap['role'] = 'AI Assistant';
            gregMap['is_greg'] = true;
            combined.add(gregMap);
          }
        } catch (e) {
          print('Error fetching greg table: $e');
        }

        return combined;
      } catch (dbError) {
        print('❌ Direct DB fetch failed for employees: $dbError');
        return [];
      }
    }
  }

  Future<List<Map<String, dynamic>>> getServices(int businessId) async {
    try {
      final response = await _apiService.get('/services/business/$businessId');
      if (response != null && response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
      }
      throw Exception('API Invalid Response');
    } catch (e) {
      print('⚠️ API fetch failed for services. Trying Direct DB...');
      try {
        final data = await _supabase
            .from('services')
            .select()
            .eq('business_id', businessId);
        return List<Map<String, dynamic>>.from(data);
      } catch (dbError) {
        print('❌ Direct DB fetch failed for services: $dbError');
        return [];
      }
    }
  }

  Future<List<Map<String, dynamic>>> getClients(int businessId) async {
    try {
      final response = await _apiService.get('/business/$businessId/clients');
      if (response != null && response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
      }
      throw Exception('API Invalid Response');
    } catch (e) {
      print('⚠️ API fetch failed for clients. Trying Direct DB...');
      try {
        final data = await _supabase
            .from('business_clients')
            .select('*, client(*)')
            .eq('business_id', businessId);

        final mappedList = (data as List).map((item) {
          final client = item['client'];
          if (client != null) {
            final merged = Map<String, dynamic>.from(client);
            merged['business_client_id'] = item['id'];
            return merged;
          }
          return Map<String, dynamic>.from(item);
        }).toList();

        return List<Map<String, dynamic>>.from(mappedList);
      } catch (dbError) {
        print('❌ Direct DB fetch failed for clients: $dbError');
        return [];
      }
    }
  }

  Future<List<Map<String, dynamic>>> getReviews(int businessId) async {
    try {
      final response = await _apiService.get('/reviews/business/$businessId');
      if (response != null && response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
      }
      return [];
    } catch (e) {
      print('⚠️ API fetch failed for reviews. Trying Direct DB...');
      try {
        final data = await _supabase
            .from('reviews')
            .select('*, client(*)')
            .eq('business_id', businessId)
            .order('created_at', ascending: false);

        return (data as List).map((item) {
          return Map<String, dynamic>.from(item);
        }).toList();
      } catch (dbError) {
        print('❌ Direct DB fetch failed for reviews: $dbError');
        return [];
      }
    }
  }

  Future<bool> updateLeadStatus(int leadId, String status) async {
    try {
      await _supabase.from('leads').update({'status': status}).eq('id', leadId);
      return true;
    } catch (e) {
      print('Error updating lead status: $e');
      return false;
    }
  }

  Future<bool> updateLeadField(int leadId, Map<String, dynamic> fields) async {
    try {
      await _supabase.from('leads').update(fields).eq('id', leadId);
      return true;
    } catch (e) {
      print('Error updating lead fields: $e');
      return false;
    }
  }

  // --- Quotes ---

  Future<List<Map<String, dynamic>>> getQuotes(int businessId) async {
    try {
      final response = await _apiService.get('/quotes/business/$businessId');
      if (response != null && response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
      }
      return [];
    } catch (e) {
      print('⚠️ API fetch failed for quotes. Trying Direct DB...');
      try {
        final data = await _supabase
            .from('quote')
            .select('*, leads!inner(business_id)')
            .eq('leads.business_id', businessId);

        return (data as List).map((item) {
          return Map<String, dynamic>.from(item);
        }).toList();
      } catch (dbError) {
        print('❌ Direct DB fetch failed for quotes: $dbError');
        return [];
      }
    }
  }

  Future<Map<String, dynamic>?> createQuote(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postForm(
        '/quotes/create',
        fields: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      throw Exception('API Error');
    } catch (e) {
      print('⚠️ API create quote failed. Trying Direct DB...');
      try {
        final res = await _supabase
            .from('quote')
            .insert(data)
            .select()
            .single();
        return res;
      } catch (dbError) {
        print('❌ Direct DB create quote failed: $dbError');
        return null;
      }
    }
  }

  Future<Map<String, dynamic>?> updateQuote(
    int quoteId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.putForm(
        '/quotes/$quoteId',
        fields: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      throw Exception('API Error');
    } catch (e) {
      print('⚠️ API update quote failed. Trying Direct DB...');
      try {
        final res = await _supabase
            .from('quote')
            .update(data)
            .eq('id', quoteId)
            .select()
            .single();
        return res;
      } catch (dbError) {
        print('❌ Direct DB update quote failed: $dbError');
        return null;
      }
    }
  }

  Future<bool> deleteQuote(int quoteId) async {
    try {
      final response = await _apiService.delete('/quotes/$quoteId');
      if (response != null && response['success'] == true) return true;
      throw Exception('API Error');
    } catch (e) {
      print('⚠️ API delete quote failed. Trying Direct DB...');
      try {
        await _supabase.from('quote').delete().eq('id', quoteId);
        return true;
      } catch (dbError) {
        print('❌ Direct DB delete quote failed: $dbError');
        return false;
      }
    }
  }

  Future<String?> getQuotePdfUrl(int quoteId) async {
    return '${_apiService.baseUrl}/quotes/$quoteId/pdf';
  }

  Future<Uint8List?> getQuotePdfBytes(int quoteId) async {
    try {
      return await _apiService.getBytes('/quotes/$quoteId/pdf');
    } catch (e) {
      print('Error getting PDF bytes: $e');
      return null;
    }
  }

  // --- Business Mutations ---

  Future<Map<String, dynamic>?> createBusiness(
    Map<String, dynamic> businessData,
  ) async {
    try {
      final response = await _apiService.post(
        '/business/new',
        body: businessData,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error creating business: $e');
      rethrow;
    }
  }

  Future<bool> deleteBusiness(int businessId, int clientId) async {
    try {
      final response = await _apiService.delete(
        '/business/$businessId?client_id=$clientId',
      );
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error deleting business: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> updateBusiness(
    int businessId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put(
        '/business/$businessId',
        body: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error updating business: $e');
      return null;
    }
  }

  // --- Services Mutations ---

  Future<Map<String, dynamic>?> createService(
    Map<String, dynamic> serviceData,
  ) async {
    try {
      final response = await _apiService.postForm(
        '/services/create',
        fields: serviceData,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error creating service: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateService(
    int serviceId,
    Map<String, dynamic> serviceData,
  ) async {
    try {
      final response = await _apiService.putForm(
        '/services/$serviceId',
        fields: serviceData,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error updating service: $e');
      return null;
    }
  }

  Future<bool> deleteService(int serviceId) async {
    try {
      final response = await _apiService.delete('/services/$serviceId');
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error deleting service: $e');
      return false;
    }
  }

  // --- Business Clients Mutations ---

  Future<Map<String, dynamic>?> createBusinessClient(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.post(
        '/business/business-clients/create',
        body: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error creating business client: $e');
      return null;
    }
  }

  Future<bool> deleteBusinessClient(int id) async {
    try {
      final response = await _apiService.delete(
        '/business/business-clients/$id',
      );
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error deleting business client: $e');
      return false;
    }
  }

  // --- Employees Mutations ---

  Future<Map<String, dynamic>?> createEmployee(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.postForm(
        '/employees/create',
        fields: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      throw Exception('API Error');
    } catch (e) {
      print('⚠️ API create employee failed. Trying Direct DB...');
      try {
        final res = await _supabase
            .from('employees')
            .insert(data)
            .select()
            .single();
        return res;
      } catch (dbError) {
        print('❌ Direct DB create employee failed: $dbError');
        return null;
      }
    }
  }

  Future<Map<String, dynamic>?> updateEmployee(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.putForm(
        '/employees/$id',
        fields: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      throw Exception('API Error');
    } catch (e) {
      print('⚠️ API update employee failed. Trying Direct DB...');
      try {
        final res = await _supabase
            .from('employees')
            .update(data)
            .eq('id', id)
            .select()
            .single();
        return res;
      } catch (dbError) {
        print('❌ Direct DB update employee failed: $dbError');
        return null;
      }
    }
  }

  Future<bool> deleteEmployee(int id) async {
    try {
      final response = await _apiService.delete('/employees/$id');
      if (response != null && response['success'] == true) return true;
      throw Exception('API Error');
    } catch (e) {
      print('⚠️ API delete employee failed. Trying Direct DB...');
      try {
        await _supabase.from('employees').delete().eq('id', id);
        return true;
      } catch (dbError) {
        print('❌ Direct DB delete employee failed: $dbError');
        return false;
      }
    }
  }

  Future<Map<String, dynamic>?> updateBusinessClient(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put(
        '/business/business-clients/$id',
        body: data,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      throw Exception('API Error');
    } catch (e) {
      // No direct endpoint for updating business client likely implies we use direct DB
      // or the endpoint assumes body.
      print('⚠️ API update business client failed. Trying Direct DB...');
      try {
        final res = await _supabase
            .from('business_clients')
            .update(data)
            .eq('id', id)
            .select()
            .single();
        return res;
      } catch (dbError) {
        print('❌ Direct DB update business client failed: $dbError');
        return null;
      }
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentMethodsForBusiness(
    int businessId,
    int clientId,
  ) async {
    try {
      final response = await _apiService.get(
        '/payments/methods?client_id=$clientId&business_id=$businessId',
      );
      if (response != null && response['success'] == true) {
        return List<Map<String, dynamic>>.from(response['data']);
      }
      return [];
    } catch (e) {
      print('Error fetching payment methods: $e');
      return [];
    }
  }

  Future<bool> createEvent(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.postForm(
        '/events/create',
        fields: data,
        // files: ... add later if we support image upload in UI
      );
      if (response != null && response['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error creating event: $e');
      return false;
    }
  }

  Future<bool> updateEvent(int eventId, Map<String, dynamic> data) async {
    try {
      // Backend update is PUT /events/{id}
      final response = await _apiService.putForm(
        '/events/$eventId',
        fields: data,
      );
      if (response != null && response['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating event: $e');
      return false;
    }
  }

  Future<bool> deleteEvent(int eventId, int businessId) async {
    try {
      // Backend delete is DELETE /events/{id}?business_id=...
      // Or pass business_id in body? My backend delete router expects query param?
      // Let's check backend router:
      // function delete_event(event_id: int, business_id: int, ...)
      // Since it's a GET param usually for DELETE unless specified Body.
      // FastAPI defaults top-level args to Query if not simple types?
      // Let's assume Query param.
      // ApiService delete supports body.
      // I'll assume I can pass qparams in URL.

      final response = await _apiService.delete(
        '/events/$eventId?business_id=$businessId',
      );
      if (response != null && response['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting event: $e');
      return false;
    }
  }
}

// --- Provider ---

final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return BusinessRepository(Supabase.instance.client, apiService);
});

final businessProvider =
    AsyncNotifierProvider<BusinessNotifier, BusinessDashboardData>(
      BusinessNotifier.new,
    );

class BusinessNotifier extends AsyncNotifier<BusinessDashboardData> {
  final _supabase = Supabase.instance.client;
  BusinessRepository? _repository;
  LeadsService? _leadsService;
  RealtimeChannel? _leadsSubscription;
  RealtimeChannel? _employeesSubscription;
  RealtimeChannel? _eventsSubscription;

  @override
  Future<BusinessDashboardData> build() async {
    ref.onDispose(() {
      _leadsSubscription?.unsubscribe();
      _employeesSubscription?.unsubscribe();
      _eventsSubscription?.unsubscribe();
    });
    _repository = ref.read(businessRepositoryProvider);
    _leadsService = ref.read(leadsServiceProvider);

    final repo = _repository!;
    final leadsService = _leadsService!;

    final authState = ref.watch(authStateProvider);
    if (authState.value?.session == null) {
      return BusinessDashboardData.empty();
    }

    final profile = ref.watch(profileProvider).value;
    if (profile == null) {
      return BusinessDashboardData.empty();
    }

    Map<String, dynamic> businessMap = {};
    int? businessId = profile.businessId;

    if (businessId != null) {
      // Even if we have the ID, let's try to get the FULL business profile data
      // from the repo (Direct DB or API) so we have address, phone, etc.
      try {
        final fullBusiness = await repo.getBusinessById(businessId);
        if (fullBusiness != null) {
          businessMap = fullBusiness;
          print(
            '🚀 BusinessProvider: Fetched FULL Business Profile for ID: $businessId',
          );
        } else {
          // Fallback to minimal cached data
          businessMap = {
            'id': businessId,
            'name': profile.businessName ?? 'My Business',
            'profile_image': profile.businessProfileImage,
            'owner_user': profile.userId,
          };
          print(
            '⚠️ BusinessProvider: Could not fetch details. Using cached minimal data.',
          );
        }
      } catch (e) {
        print('❌ BusinessProvider: Error fetching full details: $e');
        businessMap = {
          'id': businessId,
          'name': profile.businessName ?? 'My Business',
          'profile_image': profile.businessProfileImage,
          'owner_user': profile.userId,
        };
      }
    } else {
      print('⚠️ BusinessProvider: Fetching Business via API...');
      final fetchedBusiness = await repo.getMyBusiness(profile.id);
      if (fetchedBusiness != null) {
        businessMap = fetchedBusiness;
        businessId = businessMap['id'] as int?;
      }
    }

    if (businessId == null) {
      try {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          print(
            '⚠️ BusinessProvider: API failed. Querying DB directly for Business ID...',
          );
          final data = await _supabase
              .from('business')
              .select('id, name, profile_image')
              .eq('owner_user', user.id)
              .maybeSingle();
          if (data != null) {
            businessId = data['id'] as int?;
            businessMap = {
              'id': businessId,
              'name': data['name'],
              'profile_image': data['profile_image'],
              'owner_user': user.id,
            };
            print('✅ BusinessProvider: Found Business ID via DB: $businessId');
          }
        }
      } catch (e) {
        print('❌ BusinessProvider: DB Fallback failed: $e');
      }
    }

    if (businessId == null) {
      print('❌ BusinessProvider: No Business ID found. Returning empty.');
      return BusinessDashboardData.empty();
    }

    if (_leadsSubscription == null) {
      _subscribeToLeads(businessId);
    }
    if (_employeesSubscription == null) {
      _subscribeToEmployees(businessId);
    }
    if (_eventsSubscription == null) {
      _subscribeToEvents(businessId);
    }

    final results = await Future.wait([
      leadsService.fetchBusinessLeads(businessId).catchError((e) {
        print('❌ BusinessProvider: Lead fetch failed: $e');
        return <Lead>[];
      }),
      repo.getEmployees(businessId).catchError((e) {
        print('❌ BusinessProvider: Employee fetch failed: $e');
        return <Map<String, dynamic>>[];
      }),
      repo.getServices(businessId).catchError((e) {
        print('❌ BusinessProvider: Service fetch failed: $e');
        return <Map<String, dynamic>>[];
      }),
      repo.getClients(businessId).catchError((e) {
        print('❌ BusinessProvider: Client fetch failed: $e');
        return <Map<String, dynamic>>[];
      }),
      repo.getQuotes(businessId).catchError((e) {
        print('❌ BusinessProvider: Quote fetch failed: $e');
        return <Map<String, dynamic>>[];
      }),
      repo.getReviews(businessId).catchError((e) {
        print('❌ BusinessProvider: Reviews fetch failed: $e');
        return <Map<String, dynamic>>[];
      }),
      repo.getEvents(businessId).catchError((e) {
        print('❌ BusinessProvider: Events fetch failed: $e');
        return <Map<String, dynamic>>[];
      }),
    ]);

    final leads = results[0] as List<Lead>;
    final employeesRaw = results[1] as List<Map<String, dynamic>>;
    final servicesRaw = results[2] as List<Map<String, dynamic>>;
    final clientsRaw = results[3] as List<Map<String, dynamic>>;
    final quotesRaw = results[4] as List<Map<String, dynamic>>;
    final reviewsRaw = results[5] as List<Map<String, dynamic>>;
    final eventsRaw = results[6] as List<Map<String, dynamic>>;

    final clients = clientsRaw.map((c) {
      return c;
    }).toList();

    final employees = employeesRaw.map((bot) {
      final botImageRaw = bot['profile_image'] ?? bot['image'];
      String? image;
      if (botImageRaw != null) {
        String path = botImageRaw.toString();
        if (!path.startsWith('http') && !path.contains('/')) {
          path = '$businessId/$path';
        }
        image = repo._resolveUrl(path, 'business');
      }

      return {
        'name': bot['name'] ?? 'Bot',
        'role': 'Asistente IA',
        'tag': 'General',
        'status': 'Activo',
        'image': image,
      };
    }).toList();

    final services = servicesRaw.map((s) {
      String? image;
      final createProfileImage = s['profile_image'];

      if (createProfileImage != null &&
          createProfileImage.toString().isNotEmpty) {
        String filename = createProfileImage.toString();
        if (!filename.startsWith('http') && !filename.contains('/')) {
          final serviceId = s['id'];
          filename = '$businessId/services/$serviceId/$filename';
        }

        image = repo._resolveUrl(filename, 'business');
      }

      final newS = Map<String, dynamic>.from(s);
      newS['image'] = image;
      // Calculate display price from cents
      final cents = s['price_cents'] ?? 0;
      newS['price'] = (cents / 100).toStringAsFixed(
        0,
      ); // Integer string if possible or 2 decimals? User had '$50' so int is fine for now or logic

      return newS;
    }).toList();

    // Map Quotes and resolve Client Images
    final quotes = quotesRaw.map((q) {
      final newQuote = Map<String, dynamic>.from(q);

      // Deep copy nested structures to modify safely
      if (newQuote['leads'] != null) {
        final newLeads = Map<String, dynamic>.from(newQuote['leads']);
        newQuote['leads'] = newLeads;

        if (newLeads['requests'] != null) {
          final newReq = Map<String, dynamic>.from(newLeads['requests']);
          newLeads['requests'] = newReq;

          if (newReq['client'] != null) {
            final newClient = Map<String, dynamic>.from(newReq['client']);
            newReq['client'] = newClient;

            // Resolve Image
            final rawImg =
                newClient['photo_id'] ??
                newClient['profile_url'] ??
                newClient['profile_image'];

            if (rawImg != null && rawImg.toString().isNotEmpty) {
              final resolved = repo._resolveUrl(rawImg.toString(), 'client');
              if (resolved != null) {
                newClient['profile_image'] =
                    resolved; // Update property used by Widget
                newClient['image'] = resolved; // Backup
              }
            }
          }
        }
      }
      return newQuote;
    }).toList();

    final totalEarningsCents = quotesRaw.fold<double>(0.0, (sum, quote) {
      final status = quote['status'];
      final paid = quote['paid'] == true;
      final amount = (quote['amountCents'] ?? 0) as num;

      if (paid || status == 'paid' || status == 'completed') {
        return sum + amount;
      }
      return sum;
    });

    final monthEarnings = totalEarningsCents / 100.0;

    return BusinessDashboardData(
      totalRequests: leads.length,
      monthEarnings: monthEarnings,
      activityChart: [0, 0, 0, 0, 0, 0, 0],
      recentLeads: leads,
      employees: employees,
      services: services,
      clients: clients,
      quotes: quotesRaw,
      reviews: reviewsRaw,
      events: eventsRaw,
      businessProfile: businessMap,
    );
  }

  void _subscribeToLeads(int businessId) {
    _leadsSubscription = _supabase
        .channel('public:leads:business:$businessId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'leads',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'business_id',
            value: businessId,
          ),
          callback: (payload) {
            print('Realtime: Business Lead update -> Refreshing dashboard');
            ref.invalidateSelf();
          },
        )
        .subscribe();
  }

  void _subscribeToEmployees(int businessId) {
    _employeesSubscription = _supabase
        .channel('public:employees:business:$businessId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'employees',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'business_id',
            value: businessId,
          ),
          callback: (payload) {
            print(
              'Realtime: Business Employees update -> Refreshing dashboard',
            );
            ref.invalidateSelf();
          },
        )
        .subscribe();
  }

  void _subscribeToEvents(int businessId) {
    _eventsSubscription = _supabase
        .channel('public:events:business:$businessId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'events',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'business_id',
            value: businessId,
          ),
          callback: (payload) {
            print('Realtime: Business Events update -> Refreshing dashboard');
            ref.invalidateSelf();
          },
        )
        .subscribe();
  }

  Future<Map<String, dynamic>?> createQuote(Map<String, dynamic> data) async {
    final success = await _repository?.createQuote(data);
    if (success != null) {
      ref.invalidateSelf();
      return success;
    }
    return null;
  }

  Future<Map<String, dynamic>?> updateQuote(
    int id,
    Map<String, dynamic> data,
  ) async {
    final success = await _repository?.updateQuote(id, data);
    if (success != null) {
      ref.invalidateSelf();
      return success;
    }
    return null;
  }

  Future<bool> deleteQuote(int id) async {
    final success = await _repository?.deleteQuote(id);
    if (success == true) {
      ref.invalidateSelf();
      return true;
    }
    return false;
  }

  Future<bool> updateBusinessProfile(Map<String, dynamic> data) async {
    final currentState = state.value;
    if (currentState?.businessProfile == null) return false;

    final businessId = currentState!.businessProfile!['id'];
    final success = await _repository?.updateBusiness(businessId, data);

    if (success != null) {
      ref.invalidateSelf();
      return true;
    }
    return false;
  }

  Future<bool> updateLeadStatus(int leadId, String status) async {
    final success = await _repository?.updateLeadStatus(leadId, status);
    if (success == true) {
      ref.invalidateSelf();
      return true;
    }
    return false;
  }

  Future<bool> updateLeadField(int leadId, Map<String, dynamic> fields) async {
    final success = await _repository?.updateLeadField(leadId, fields);
    if (success == true) {
      ref.invalidateSelf();
      return true;
    }
    return false;
  }
}

// Lightweight Provider for fetching Business Name only
final myBusinessNameProvider = FutureProvider<String?>((ref) async {
  final profile = ref.watch(profileProvider).value;
  if (profile?.businessName != null) {
    return profile!.businessName;
  }
  return null;
});

// View State for Sales Tab
final selectedSalesViewProvider = StateProvider<String>((ref) => 'invoices');
