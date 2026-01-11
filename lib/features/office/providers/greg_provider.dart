import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/greg_model.dart';
import '../../../core/services/api_service.dart';
import '../services/greg_service.dart';

// Service Provider
final gregServiceProvider = Provider<GregService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return GregService(apiService);
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
    debugPrint('🔄 GregNotifier: Loading Greg for business $businessId...');
    try {
      final service = ref.read(gregServiceProvider);
      final greg = await service.getGregByBusinessId(businessId);
      if (greg != null) {
        debugPrint('✅ GregNotifier: Greg loaded for business $businessId');
        state = GregLoaded(greg);
      } else {
        debugPrint('⚠️ GregNotifier: No Greg found for business $businessId');
        state = GregError("Greg configuration not found for this business.");
      }
    } catch (e) {
      debugPrint('❌ GregNotifier: Error loading Greg: $e');
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
    }
  }

  Future<void> updateGregCancellations(GregModel updatedGreg) async {
    try {
      final service = ref.read(gregServiceProvider);
      await service.updateGregCancellations(updatedGreg);
      state = GregLoaded(updatedGreg); // Optimistic update
    } catch (e) {
      print("Cancellations update failed: $e");
      rethrow;
    }
  }

  Future<void> updateGregPayments(GregModel updatedGreg) async {
    try {
      final service = ref.read(gregServiceProvider);
      await service.updateGregPayments(updatedGreg);
      state = GregLoaded(updatedGreg); // Optimistic update
    } catch (e) {
      print("Payments update failed: $e");
      rethrow;
    }
  }

  Future<void> updateGregProcedures(GregModel updatedGreg) async {
    try {
      final service = ref.read(gregServiceProvider);
      await service.updateGregProcedures(updatedGreg);
      state = GregLoaded(updatedGreg); // Optimistic update
    } catch (e) {
      print("Procedures update failed: $e");
      rethrow;
    }
  }

  Future<void> updateGregPrivacy(GregModel updatedGreg) async {
    try {
      final service = ref.read(gregServiceProvider);
      await service.updateGregPrivacy(updatedGreg);
      state = GregLoaded(updatedGreg); // Optimistic update
    } catch (e) {
      print("Privacy update failed: $e");
      rethrow;
    }
  }

  Future<void> updateGregLibrary(GregModel updatedGreg) async {
    try {
      final service = ref.read(gregServiceProvider);
      await service.updateGregLibrary(updatedGreg);
      state = GregLoaded(updatedGreg); // Optimistic update
    } catch (e) {
      print("Library update failed: $e");
      rethrow;
    }
  }
}

// State Provider
final gregProvider = NotifierProvider<GregNotifier, GregState>(
  GregNotifier.new,
);
