import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../settings/providers/profile_provider.dart';
import '../../leads/services/leads_service.dart';
import '../../leads/models/lead_model.dart';
import '../../../core/services/api_service.dart'; // Import ApiService
// import '../../auth/providers/auth_provider.dart'; // Removed

// --- Models ---

class BusinessDashboardData {
  final int totalRequests;
  final double monthEarnings;
  final List<double> activityChart;
  final List<Lead> recentLeads;
  final List<Map<String, dynamic>> employees;
  final List<Map<String, dynamic>> services;

  BusinessDashboardData({
    required this.totalRequests,
    required this.monthEarnings,
    required this.activityChart,
    required this.recentLeads,
    required this.employees,
    required this.services,
  });

  factory BusinessDashboardData.empty() {
    return BusinessDashboardData(
      totalRequests: 0,
      monthEarnings: 0.0,
      activityChart: [0, 0, 0, 0, 0, 0, 0],
      recentLeads: [],
      employees: [],
      services: [],
    );
  }
}

// --- Repository ---

// Moved import to top, removing this line.

// ...

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
      final data = await _supabase
          .from('business')
          .select()
          .eq('owner_client_id', clientId)
          .maybeSingle();
      return data;
    } catch (e) {
      print('Error fetching business: $e');
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
          // If it returns a map, assume it might be a single object or we need to extract a list
          // Logging this for debugging would be ideal, but for now let's see if we can just wrap it?
          // Or maybe it has a nested list?
          if (data.containsKey('employees')) {
            return List<Map<String, dynamic>>.from(data['employees']);
          }
          // Fallback: treat as single object
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
      final data = await _supabase
          .from('service')
          .select()
          .eq('business_id', businessId);
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error fetching services: $e');
      return [];
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
  BusinessRepository? _repository;
  LeadsService? _leadsService;
  RealtimeChannel? _leadsSubscription;

  @override
  Future<BusinessDashboardData> build() async {
    // Handle disposal of real-time subscription
    ref.onDispose(() {
      _leadsSubscription?.unsubscribe();
    });
    _repository = ref.read(businessRepositoryProvider);
    _leadsService = ref.read(leadsServiceProvider);

    // Ensure repository is available
    final repo = _repository!;
    final leadsService = _leadsService!;

    final profile = ref.watch(profileProvider).value;
    if (profile == null) {
      return BusinessDashboardData.empty();
    }

    final business = await repo.getMyBusiness(profile.id);
    if (business == null) {
      return BusinessDashboardData.empty();
    }

    final businessId = business['id'] as int;

    // Fetch Data
    final results = await Future.wait([
      leadsService.fetchBusinessLeads(businessId),
      repo.getEmployees(businessId),
      repo.getServices(businessId),
    ]);

    final leads = results[0] as List<Lead>;
    final employeesRaw = results[1] as List<Map<String, dynamic>>;
    final servicesRaw = results[2] as List<Map<String, dynamic>>;

    // Map Employees
    final employees = employeesRaw.map((bot) {
      final botImageRaw = bot['profile_image'] ?? bot['image'];
      String? image;
      if (botImageRaw != null) {
        image = repo._resolveUrl(botImageRaw.toString(), 'business');
      }

      return {
        'name': bot['name'] ?? 'Bot',
        'role': 'Asistente IA',
        'tag': 'General',
        'status': 'Activo',
        'image': image,
      };
    }).toList();

    // Map Services
    final services = servicesRaw.map((s) {
      // Resolve image if needed
      String? image;
      if (s['image_url'] != null) {
        image = repo._resolveUrl(
          s['image_url'],
          'service',
        ); // Assuming 'service' bucket or similar
      }
      return {...s, 'image': image};
    }).toList();

    // Setup Realtime Subscription for Leads (Example)
    // We only subscribe once.
    if (_leadsSubscription == null) {
      _subscribeToLeads(businessId);
    }

    return BusinessDashboardData(
      totalRequests: leads.length,
      monthEarnings: 0.0,
      activityChart: [0, 0, 0, 0, 0, 0, 0],
      recentLeads: leads,
      employees: employees,
      services: services,
    );
  }

  void _subscribeToLeads(int businessId) {
    _leadsSubscription = Supabase.instance.client
        .channel('public:leads:business_id=eq.$businessId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'leads', // Verify table name
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'business_id',
            value: businessId,
          ),
          callback: (payload) {
            // Reload data on change
            ref.invalidateSelf();
          },
        )
        .subscribe();
  }
}
