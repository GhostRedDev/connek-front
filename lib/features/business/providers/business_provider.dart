import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../settings/providers/profile_provider.dart';
import '../../leads/services/leads_service.dart';
import '../../leads/models/lead_model.dart';
import '../../../core/services/api_service.dart'; // Import ApiService
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
  final Map<String, dynamic>? businessProfile; // Added

  BusinessDashboardData({
    required this.totalRequests,
    required this.monthEarnings,
    required this.activityChart,
    required this.recentLeads,
    required this.employees,
    required this.services,
    required this.clients,
    this.businessProfile, // Added
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
      businessProfile: null, // Added
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

  Future<Map<String, dynamic>?> getMyBusiness(int clientId) async {
    try {
      // Fetch accounts to find the business
      final response = await _apiService.get(
        '/clients/accounts?client_id=$clientId',
      );
      if (response != null && response['success'] == true) {
        final data = response['data'];
        final businesses = data['businesses'];
        if (businesses is List && businesses.isNotEmpty) {
          // Return the first business found (map format)
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
      return [];
    } catch (e) {
      print('Error fetching employees via API: $e');
      return [];
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
      return [];
    } catch (e) {
      print('Error fetching services via API: $e');
      return [];
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
      return []; // Return empty list if no data or malformed
    } catch (e) {
      print('Error fetching clients via API: $e');
      return [];
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
      throw e;
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

  Future<List<String>> uploadBusinessFiles(
    int businessId,
    List<File> files,
  ) async {
    // Note: This requires converting dart:io File to http.MultipartFile
    // Helper needed or assume files are handled in UI before repository?
    // Usually Repository takes simpler types. Let's assume File path or bytes.
    // For now, skipping generic upload until logic is confirmed or using ApiService.postMultipart
    return [];
  }

  // --- Services Mutations ---

  Future<Map<String, dynamic>?> createService(
    Map<String, dynamic> serviceData,
  ) async {
    try {
      // serviceData should mirror the Form fields expected by backend
      final response = await _apiService.post(
        '/services/create',
        body: serviceData,
      );
      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error creating service: $e');
      return null; // Or throw
    }
  }

  Future<Map<String, dynamic>?> updateService(
    int serviceId,
    Map<String, dynamic> serviceData,
  ) async {
    try {
      final response = await _apiService.put(
        '/services/$serviceId',
        body: serviceData,
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
  RealtimeChannel? _employeesSubscription; // Added

  @override
  Future<BusinessDashboardData> build() async {
    // Handle disposal of real-time subscription
    ref.onDispose(() {
      _leadsSubscription?.unsubscribe();
      _employeesSubscription?.unsubscribe();
    });
    _repository = ref.read(businessRepositoryProvider);
    _leadsService = ref.read(leadsServiceProvider);

    // Ensure repository is available
    final repo = _repository!;
    final leadsService = _leadsService!;

    // Watch Auth to trigger refresh on state change
    final authState = ref.watch(authStateProvider);
    if (authState.value?.session == null) {
      return BusinessDashboardData.empty();
    }

    final profile = ref.watch(profileProvider).value;
    if (profile == null) {
      return BusinessDashboardData.empty();
    }

    final business = await repo.getMyBusiness(profile.id);
    if (business == null) {
      return BusinessDashboardData.empty();
    }

    final businessId = business['id'] as int;

    // Setup Subscription if not active
    if (_leadsSubscription == null) {
      _subscribeToLeads(businessId);
    }
    if (_employeesSubscription == null) {
      _subscribeToEmployees(businessId);
    }

    // Fetch Data
    final results = await Future.wait([
      leadsService.fetchBusinessLeads(businessId),
      repo.getEmployees(businessId),
      repo.getServices(businessId),
      repo.getClients(businessId), // Added
    ]);

    final leads = results[0] as List<Lead>;
    final employeesRaw = results[1] as List<Map<String, dynamic>>;
    final servicesRaw = results[2] as List<Map<String, dynamic>>;
    final clientsRaw = results[3] as List<Map<String, dynamic>>; // Added

    // Map Clients (Optional: Enrich with image logic if needed)
    final clients = clientsRaw.map((c) {
      // Ensure image is full URL if needed, but client images are usually URLs from auth
      // or relative paths if stored in bucket.
      // Let's assume they are ready for UI or need basic handling.
      // If image is null, UI handles it.
      return c;
    }).toList();

    // Map Employees
    final employees = employeesRaw.map((bot) {
      final botImageRaw = bot['profile_image'] ?? bot['image'];
      String? image;
      if (botImageRaw != null) {
        String path = botImageRaw.toString();
        // If it's just a filename (no slashes) and likely not a full URL, prepend businessId
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
        'image': image, // Fixed: Now includes businessId/filename
      };
    }).toList();

    // Map Services
    final services = servicesRaw.map((s) {
      // Resolve image if needed
      String? image;
      // Backend uses 'profile_image' key and stores in 'business' bucket
      // Path: businessId/services/serviceId/filename
      final createProfileImage = s['profile_image'];

      if (createProfileImage != null &&
          createProfileImage.toString().isNotEmpty) {
        String filename = createProfileImage.toString();
        // If it's just a filename, construct the full path
        if (!filename.startsWith('http') && !filename.contains('/')) {
          // We need service ID. 's' is the service map.
          final serviceId = s['id'];
          filename = '$businessId/services/$serviceId/$filename';
        }

        image = repo._resolveUrl(filename, 'business');
      }
      return {...s, 'image': image};
    }).toList();

    return BusinessDashboardData(
      totalRequests: leads.length,
      monthEarnings: 0.0,
      activityChart: [0, 0, 0, 0, 0, 0, 0],
      recentLeads: leads,
      employees: employees,
      services: services,
      clients: clients,
      businessProfile: business, // Added
    );
  }

  void _subscribeToLeads(int businessId) {
    _leadsSubscription = _supabase
        .channel('public:service_requests:business:$businessId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'service_requests',
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
    _employeesSubscription =
        _supabase // Assigned to field
            .channel('public:employees:business:$businessId')
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'employees', // Assuming 'employees' table
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

  Future<bool> updateBusinessProfile(Map<String, dynamic> data) async {
    final currentState = state.value;
    if (currentState?.businessProfile == null) return false;

    final businessId = currentState!.businessProfile!['id'];
    final success = await _repository?.updateBusiness(businessId, data);

    if (success != null) {
      // Refresh data
      ref.invalidateSelf();
      return true;
    }
    return false;
  }
}

// Lightweight Provider for fetching Business Name only
final myBusinessNameProvider = FutureProvider<String?>((ref) async {
  final profile = ref.watch(profileProvider).value;
  if (profile == null) return null;

  final repo = ref.read(businessRepositoryProvider);
  final business = await repo.getMyBusiness(profile.id);
  return business?['name'] as String?;
});

final myBusinessLogoProvider = FutureProvider<String?>((ref) async {
  final profile = ref.watch(profileProvider).value;
  if (profile == null) return null;

  final repo = ref.read(businessRepositoryProvider);
  final business = await repo.getMyBusiness(profile.id);
  // 'image' or 'logo_url' - checking repository or creating resolver
  // Based on getEmployees mapping, it seems images are usually resolved.
  // Let's assume 'image' key from DB and resolve it.
  final rawImage = business?['image'] as String?;
  if (rawImage == null) return null;

  if (rawImage.startsWith('http')) return rawImage;

  // Fix: Prepend businessId folder if missing
  // The business repository logic should be reused or duplicated here safest
  final businessId =
      business!['id']; // Safe because rawImage passed earlier check implies business exists
  String path = rawImage;
  if (!path.contains('/')) {
    path = '$businessId/$path';
  }

  return Supabase.instance.client.storage.from('business').getPublicUrl(path);
});

// State for Sales Tab Dropdown Selection
final selectedSalesViewProvider =
    NotifierProvider<SelectedSalesViewNotifier, String>(
      SelectedSalesViewNotifier.new,
    );

class SelectedSalesViewNotifier extends Notifier<String> {
  @override
  String build() => 'ventas';

  void setView(String view) {
    state = view;
  }
}
