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
        return List<Map<String, dynamic>>.from(response['data']);
      }
      return [];
    } catch (e) {
      print('Error fetching employees via API: $e');
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
  // Remove late final to prevent initialization errors on rebuild
  BusinessRepository? _repository;
  LeadsService? _leadsService;

  @override
  Future<BusinessDashboardData> build() async {
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
    // We fetch leads from API now
    final results = await Future.wait([
      leadsService.fetchBusinessLeads(businessId),
      repo.getEmployees(businessId),
    ]);

    final leads = results[0] as List<Lead>;
    final employeesRaw = results[1] as List<Map<String, dynamic>>;

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

    return BusinessDashboardData(
      totalRequests: leads.length,
      monthEarnings: 0.0,
      activityChart: [0, 0, 0, 0, 0, 0, 0],
      recentLeads: leads,
      employees: employees,
      services: [],
    );
  }
}
