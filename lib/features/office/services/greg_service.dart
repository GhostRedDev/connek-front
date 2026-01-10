import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/greg_model.dart';

class GregService {
  final SupabaseClient _supabase;

  GregService(this._supabase);

  // Fetch Greg configuration for a specific business
  // Assuming 'greg' table has a 'business_id' foreign key and we want the first match
  // OR the 'id' in GregModel refers to the row ID.
  // For now, let's assume we query by businessId.
  Future<GregModel?> getGregByBusinessId(int businessId) async {
    try {
      final response = await _supabase
          .from('greg')
          .select()
          .eq('business_id', businessId)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return GregModel.fromJson(response);
    } catch (e) {
      // Handle error (log it, rethrow, etc.)
      print('Error fetching Greg: $e');
      return null;
    }
  }

  // Update Greg configuration
  Future<void> updateGreg(GregModel greg) async {
    try {
      await _supabase.from('greg').update(greg.toJson()).eq('id', greg.id);
    } catch (e) {
      print('Error updating Greg: $e');
      rethrow;
    }
  }
}
