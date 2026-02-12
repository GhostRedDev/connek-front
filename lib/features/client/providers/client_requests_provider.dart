import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/service_request_model.dart';
import '../services/client_requests_service.dart';
import '../../settings/providers/profile_provider.dart';

final clientRequestsProvider =
    AsyncNotifierProvider<ClientRequestsNotifier, List<ServiceRequest>>(
      ClientRequestsNotifier.new,
    );

class ClientRequestsNotifier extends AsyncNotifier<List<ServiceRequest>> {
  RealtimeChannel? _subscription;
  // Supabase instance needed for Realtime
  final _supabase = Supabase.instance.client;

  @override
  Future<List<ServiceRequest>> build() async {
    // Watch Auth/Profile
    final profile = await ref.watch(profileProvider.future);

    // Dispose subscription
    ref.onDispose(() {
      _subscription?.unsubscribe();
    });

    if (profile == null) return [];

    // Setup Subscription
    if (_subscription == null) {
      _subscribeToRequests(profile.id);
    }

    return _fetchRequests(profile.id);
  }

  Future<List<ServiceRequest>> _fetchRequests(int clientId) async {
    final service = ref.read(clientRequestsServiceProvider);
    return service.fetchClientRequests(clientId);
  }

  void _subscribeToRequests(int clientId) {
    _subscription = _supabase
        .channel('public:service_requests:client:$clientId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'service_requests',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'client_id',
            value: clientId,
          ),
          callback: (payload) {
            print('Realtime: Client Request update -> Refreshing list');
            ref.invalidateSelf();
          },
        )
        .subscribe();
  }
}
