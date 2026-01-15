import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Keep for image resolution
import '../../../core/services/api_service.dart';
import '../models/lead_model.dart';

final leadsServiceProvider = Provider<LeadsService>((ref) {
  final apiService = ref.watch(
    apiServiceProvider,
  ); // Now explicitly imported via relative path if needed, or assumed global if in same file.
  // Wait, I see I already added the import in the previous step but better double check imports.
  return LeadsService(apiService);
});

class LeadsService {
  final ApiService _apiService;

  LeadsService(this._apiService);

  Future<List<Lead>> fetchBusinessLeads(int businessId) async {
    try {
      final jsonResponse = await _apiService.get('/leads/business/$businessId');

      if (jsonResponse['success'] == true) {
        final List<dynamic> data = jsonResponse['data'];

        return data.map((jsonItem) {
          _resolveLeadImage(jsonItem);
          return Lead.fromJson(jsonItem);
        }).toList();
      } else {
        throw Exception(jsonResponse['error'] ?? 'Failed to load leads');
      }
    } catch (e) {
      throw Exception('Error fetching leads: $e');
    }
  }

  void _resolveLeadImage(Map<String, dynamic> jsonItem) {
    try {
      final request = jsonItem['requests'] ?? {};
      final client = request['client'] ?? {};
      String? imagePath =
          client['photo_id'] ??
          client['profile_url'] ??
          client['profile_image'];

      if (imagePath != null &&
          imagePath.isNotEmpty &&
          !imagePath.startsWith('http')) {
        // Fix: Prepend clientId folder if missing
        if (!imagePath.contains('/')) {
          final clientId = client['id'];
          imagePath = '$clientId/$imagePath';
        }

        final publicUrl = Supabase.instance.client.storage
            .from('client')
            .getPublicUrl(imagePath);
        client['photo_id'] = publicUrl;
        client['profile_url'] = publicUrl;
        client['profile_image'] =
            publicUrl; // Ensure profile_image is also updated
      }
    } catch (e) {
      print('Error resolving image url: $e');
    }
  }
}
