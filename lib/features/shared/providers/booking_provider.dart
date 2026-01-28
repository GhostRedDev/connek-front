import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';
import '../../../core/services/api_service.dart';

import '../services/booking_service.dart';

// Global Service Instance
final bookingServiceProvider = Provider<BookingService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return BookingService(apiService, ref);
});

// Family Notifier to handle lists
final bookingListProvider =
    AsyncNotifierProvider.family<
      BookingListNotifier,
      List<BookingModel>,
      String
    >(BookingListNotifier.new);

class BookingListNotifier
    extends FamilyAsyncNotifier<List<BookingModel>, String> {
  @override
  Future<List<BookingModel>> build(String arg) async {
    final service = ref.read(bookingServiceProvider);
    return service.fetchBookings(role: arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(bookingServiceProvider);
    state = await AsyncValue.guard(() => service.fetchBookings(role: arg));
  }
}

// Single Booking Provider (for Details Page)
final bookingDetailsProvider = FutureProvider.family<BookingModel?, String>((
  ref,
  id,
) async {
  final service = ref.read(bookingServiceProvider);
  return service.getBookingById(id);
});

// Action Providers
final bookingUpdateProvider = Provider((ref) => BookingController(ref));

class BookingController {
  final Ref ref;
  BookingController(this.ref);

  Future<void> cancelBooking(String id, String role) async {
    final service = ref.read(bookingServiceProvider);
    await service.updateBookingStatus(id, BookingStatus.cancelled);
    ref.invalidate(bookingListProvider(role));
    ref.invalidate(bookingDetailsProvider(id));
  }

  Future<void> reschedule(
    String id,
    DateTime date,
    String time,
    String role,
  ) async {
    final service = ref.read(bookingServiceProvider);
    await service.rescheduleBooking(id, date, time);
    ref.invalidate(bookingListProvider(role));
    ref.invalidate(bookingDetailsProvider(id));
  }

  Future<bool> createManualBooking({
    required int clientId,
    required int serviceId,
    required DateTime date,
  }) async {
    final service = ref.read(bookingServiceProvider);
    final success = await service.createManualBooking(
      clientId: clientId,
      serviceId: serviceId,
      date: date,
    );
    if (success) {
      ref.invalidate(bookingListProvider('business'));
    }
    return success;
  }
}
