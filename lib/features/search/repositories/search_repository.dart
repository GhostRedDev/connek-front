import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../models/business_model.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SearchRepository(apiService);
});

class SearchRepository {
  final ApiService _apiService;

  SearchRepository(this._apiService);

  Future<({List<Business> results, String? message})> search(String query, {int? clientId}) async {
    try {
      String endpoint = '/search/?prompt=$query';
      if (clientId != null) {
        endpoint += '&client_id=$clientId';
      }
      final response = await _apiService.get(endpoint);
      if (response == null) return (results: <Business>[], message: null);
      
      final searchResponse = BusinessSearchResponse.fromJson(response);
      return (results: searchResponse.data, message: searchResponse.message);
    } catch (e) {
      if (e.toString().contains('503')) {
        throw Exception('Servicio no disponible momentáneamente. Por favor intenta más tarde.');
      }
      throw Exception('Failed to search: $e');
    }
  }
}
