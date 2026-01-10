import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/greg_model.dart';
import '../services/greg_service.dart';

// Service Provider
final gregServiceProvider = Provider<GregService>((ref) {
  return GregService(Supabase.instance.client);
});

// State definitions
abstract class GregState {}

class GregInitial extends GregState {}

class GregLoading extends GregState {}

class GregLoaded extends GregState {
  final GregModel greg;
  GregLoaded(this.greg);
}

class GregError extends GregState {
  final String message;
  GregError(this.message);
}

// Notifier
class GregNotifier extends Notifier<GregState> {
  @override
  GregState build() {
    return GregInitial();
  }

  Future<void> loadGreg(int businessId) async {
    state = GregLoading();
    try {
      final service = ref.read(gregServiceProvider);
      final greg = await service.getGregByBusinessId(businessId);
      if (greg != null) {
        state = GregLoaded(greg);
      } else {
        state = GregError("Greg configuration not found for this business.");
      }
    } catch (e) {
      state = GregError(e.toString());
    }
  }

  Future<void> updateGreg(GregModel updatedGreg) async {
    try {
      final service = ref.read(gregServiceProvider);
      await service.updateGreg(updatedGreg);
      state = GregLoaded(updatedGreg); // Optimistic update
    } catch (e) {
      print("Update failed: $e");
      // Optionally set error state or keep showing old state with a toast handled by UI
    }
  }
}

// State Provider
final gregProvider = NotifierProvider<GregNotifier, GregState>(
  GregNotifier.new,
);
