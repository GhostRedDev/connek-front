enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final String serviceName;
  final String serviceImage;
  final String providerName; // Business or Professional Name
  final DateTime date;
  final BookingStatus status;
  final double price;

  const BookingModel({
    required this.id,
    required this.serviceName,
    required this.serviceImage,
    required this.providerName,
    required this.date,
    required this.status,
    required this.price,
  });
}
