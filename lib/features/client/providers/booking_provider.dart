import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';

final bookingProvider =
    AsyncNotifierProvider<BookingNotifier, List<BookingModel>>(
      BookingNotifier.new,
    );

class BookingNotifier extends AsyncNotifier<List<BookingModel>> {
  @override
  Future<List<BookingModel>> build() async {
    // Mock Data for now
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      BookingModel(
        id: '1',
        serviceName: 'Limpieza General',
        serviceImage:
            'https://images.unsplash.com/photo-1581578731117-10d52143b0d8?auto=format&fit=crop&q=80&w=200',
        providerName: 'CleanPro Services',
        date: DateTime.now().add(const Duration(days: 2)),
        status: BookingStatus.confirmed,
        price: 50.0,
      ),
      BookingModel(
        id: '2',
        serviceName: 'Mantenimiento de PC',
        serviceImage:
            'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?auto=format&fit=crop&q=80&w=200',
        providerName: 'TechFix',
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: BookingStatus.completed,
        price: 85.0,
      ),
      BookingModel(
        id: '3',
        serviceName: 'Jardinería Express',
        serviceImage:
            'https://images.unsplash.com/photo-1558904541-efa843a96f01?auto=format&fit=crop&q=80&w=200',
        providerName: 'GreenThumb',
        date: DateTime.now().add(const Duration(days: 1)),
        status: BookingStatus.pending,
        price: 40.0,
      ),
    ];
  }
}
