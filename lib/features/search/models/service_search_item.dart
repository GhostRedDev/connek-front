import 'business_model.dart';

// Flattened model combining Service + Business data for search results
class ServiceSearchItem {
  // Service fields
  final int serviceId;
  final String serviceName;
  final double servicePrice;
  final String? serviceImage;
  final String? serviceProfileImage;
  final String? serviceDescription;

  // Business fields
  final int businessId;
  final String businessName;
  final String? businessProfileImage;
  final String? businessBannerImage;

  // Type flag for rendering
  final bool isGoogleResult;

  ServiceSearchItem({
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
    this.serviceImage,
    this.serviceProfileImage,
    this.serviceDescription,
    required this.businessId,
    required this.businessName,
    this.businessProfileImage,
    this.businessBannerImage,
    this.isGoogleResult = false,
  });

  // Create from Business + Service
  factory ServiceSearchItem.fromBusinessAndService({
    required Business business,
    required Service service,
  }) {
    return ServiceSearchItem(
      serviceId: service.id,
      serviceName: service.name,
      servicePrice: service.price,
      serviceImage: service.image,
      serviceProfileImage: null, // Will be populated if available
      serviceDescription: null,
      businessId: business.id,
      businessName: business.name,
      businessProfileImage: business.profileImage,
      businessBannerImage: business.bannerImage,
      isGoogleResult: business.id < 0,
    );
  }
}
