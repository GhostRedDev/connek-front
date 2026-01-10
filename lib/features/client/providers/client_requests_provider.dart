import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_request_model.dart';
import '../services/client_requests_service.dart';
import '../../settings/providers/profile_provider.dart';

final clientRequestsProvider = FutureProvider<List<ServiceRequest>>((
  ref,
) async {
  final profile = await ref.watch(profileProvider.future);
  if (profile == null) return [];

  final service = ref.read(clientRequestsServiceProvider);
  // Using profile.id (which is usually UUID string in Supabase Auth, but Client table might have Int ID)
  // Assuming profile.id is the int ID from 'client' table based on previous usage
  return service.fetchClientRequests(profile.id);
});
