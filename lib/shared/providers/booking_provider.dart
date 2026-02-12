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

  Future<void> confirmBooking(String id, String role) async {
    final service = ref.read(bookingServiceProvider);
    await service.updateBookingStatus(id, BookingStatus.confirmed);
    ref.invalidate(bookingListProvider(role));
    ref.invalidate(bookingDetailsProvider(id));
  }

  Future<void> startService(String id, String role) async {
    final service = ref.read(bookingServiceProvider);
    await service.updateBookingStatus(id, BookingStatus.in_progress);
    ref.invalidate(bookingListProvider(role));
    ref.invalidate(bookingDetailsProvider(id));
  }

  Future<void> completeBooking(String id, String role) async {
    final service = ref.read(bookingServiceProvider);
    await service.updateBookingStatus(id, BookingStatus.completed);
    ref.invalidate(bookingListProvider(role));
    ref.invalidate(bookingDetailsProvider(id));
  }

  Future<bool> createManualBooking({
    required int clientId,
    required int serviceId,
    required DateTime date,
    int? staffId,
  }) async {
    final service = ref.read(bookingServiceProvider);
    final success = await service.createManualBooking(
      clientId: clientId,
      serviceId: serviceId,
      date: date,
      staffId: staffId,
    );
    if (success) {
      ref.invalidate(bookingListProvider('business'));
      ref.invalidate(bookingListProvider('client'));
    }
    return success;
  }

  Future<bool> createClientBooking({
    required int businessId,
    required int serviceId,
    required DateTime date,
<<<<<<< Updated upstream
    int? employeeId,
    Map<String, dynamic>? customFormAnswers,
=======
    int? staffId,
>>>>>>> Stashed changes
  }) async {
    final service = ref.read(bookingServiceProvider);
    final success = await service.createClientBooking(
      businessId: businessId,
      serviceId: serviceId,
      date: date,
<<<<<<< Updated upstream
      employeeId: employeeId,
      customFormAnswers: customFormAnswers,
=======
      staffId: staffId,
>>>>>>> Stashed changes
    );
    if (success) {
      ref.invalidate(bookingListProvider('business'));
      ref.invalidate(bookingListProvider('client'));
    }
    return success;
  }

  Future<bool> deleteBooking(String id, String role) async {
    final service = ref.read(bookingServiceProvider);
    final success = await service.deleteBooking(id);
    if (success) {
      ref.invalidate(bookingListProvider(role));
      // If detail view needs to pop, UI handles it
    }
    return success;
  }

  /// Update booking details (date, service, staff, status)
  Future<bool> updateBooking({
    required String bookingId,
    DateTime? newDate,
    int? newServiceId,
    int? newStaffId,
    String? newStatus,
    required String role,
  }) async {
    final service = ref.read(bookingServiceProvider);
    final success = await service.updateBooking(
      bookingId: bookingId,
      newDate: newDate,
      newServiceId: newServiceId,
      newStaffId: newStaffId,
      newStatus: newStatus,
    );
    if (success) {
      ref.invalidate(bookingListProvider(role));
      ref.invalidate(bookingDetailsProvider(bookingId));
    }
    return success;
  }

  Future<bool> rebook(
    String id,
    DateTime date,
    String start,
    String end,
    String role,
  ) async {
    final service = ref.read(bookingServiceProvider);
    final success = await service.rebook(
      id,
      date: date,
      startTime: start,
      endTime: end,
    );
    if (success) {
      ref.invalidate(bookingListProvider(role));
    }
    return success;
  }
}
