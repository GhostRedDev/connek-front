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

      if (jsonResponse != null && jsonResponse['success'] == true) {
        // Robust check
        final List<dynamic> data = jsonResponse['data'];

        return data.map((jsonItem) {
          _resolveLeadImage(jsonItem);
          return Lead.fromJson(jsonItem);
        }).toList();
      }
      throw Exception(jsonResponse['error'] ?? 'Failed to load leads');
    } catch (e) {
      print('⚠️ API Leads fetch failed. Trying Direct DB...');
      try {
        final data = await Supabase.instance.client
            .from('leads')
            .select('*, requests(*, client(*))')
            .eq('business_id', businessId)
            .order('created_at', ascending: false);

        return (data as List).map((json) {
          // Basic Lead mapping for fallback
          // Ensure 'requests' structure is mocked or available if needed by UI
          // But Lead.fromJson handles it.
          return Lead.fromJson(json);
        }).toList();
      } catch (dbError) {
        print('❌ Direct DB fetch failed for leads: $dbError');
        return [];
      }
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
          // Try different common paths: 'clientId/filename' or just 'filename' if bucket is structured that way
          // But usually 'client' bucket has 'userId/filename' or 'clientId/filename'
          imagePath = '$clientId/$imagePath';
        }

        final publicUrl = Supabase.instance.client.storage
            .from(
              'client',
            ) // Ensure bucket name 'client' matches Supabase storage
            .getPublicUrl(imagePath);

        // Update all potential image fields
        client['photo_id'] = publicUrl;
        client['profile_url'] = publicUrl;
        client['profile_image'] = publicUrl;

        // Also update nested request->client if deep nested
        if (jsonItem['requests'] != null &&
            jsonItem['requests']['client'] != null) {
          jsonItem['requests']['client']['photo_id'] = publicUrl;
          jsonItem['requests']['client']['profile_url'] = publicUrl;
        }
      }
    } catch (e) {
      print('Error resolving image url: $e');
    }
  }
}
