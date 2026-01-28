import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../models/service_request_model.dart';

final clientRequestsServiceProvider = Provider<ClientRequestsService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ClientRequestsService(apiService);
});

class ClientRequestsService {
  final ApiService _apiService;

  ClientRequestsService(this._apiService);

  Future<List<ServiceRequest>> fetchClientRequests(int? clientId) async {
    if (clientId == null) return [];

    try {
      final response = await _apiService.get('/requests/client/$clientId');
      if (response != null && response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return data.map((e) => ServiceRequest.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      // 404 means no requests found for this client, which is a valid empty state.
      if (e.toString().contains('404')) {
        return [];
      }
      print('Error fetching client requests: $e');
      return [];
    }
  }

  Future<bool> acceptProposal(int quoteId, int leadId) async {
    try {
      final response = await _apiService.post(
        '/quotes/accept',
        body: {'quote_id': quoteId, 'lead_id': leadId},
      );
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error accepting proposal: $e');
      return false;
    }
  }

  Future<bool> declineProposal(int quoteId, int leadId) async {
    try {
      final response = await _apiService.post(
        '/quotes/decline',
        body: {'quote_id': quoteId, 'lead_id': leadId},
      );
      return response != null && response['success'] == true;
    } catch (e) {
      print('Error declining proposal: $e');
      return false;
    }
  }
}
