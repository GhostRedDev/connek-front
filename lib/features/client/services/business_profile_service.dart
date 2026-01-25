import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../business/providers/business_provider.dart';

// Model for Business Profile
class BusinessProfile {
  final String id;
  final String name;
  final String handle;
  final String description;
  final String coverImage;
  final String avatarImage;
  final double rating;
  final int reviewCount;
  final int followers;
  final int likesCount; // New
  final bool isLiked; // New
  final int servicesCount;
  final String location;
  final String hours;
  final String phone;
  final String email;
  final String website;
  final String instagram;
  final String facebook;
  final List<String> images; // Portfolio/Media

  const BusinessProfile({
    required this.id,
    required this.name,
    required this.handle,
    required this.description,
    required this.coverImage,
    required this.avatarImage,
    required this.rating,
    required this.reviewCount,
    required this.followers,
    this.likesCount = 0, // New
    this.isLiked = false, // New
    required this.servicesCount,
    required this.location,
    required this.hours,
    required this.phone,
    required this.email,
    required this.website,
    required this.instagram,
    required this.facebook,
    this.images = const [],
  });
}

class BusinessServiceItem {
  final String id;
  final String title;
  final String image;
  final String price;
  final String rating;

  const BusinessServiceItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.rating,
  });
}

class BusinessProfileService {
  final BusinessRepository _repository;

  BusinessProfileService(this._repository);

  Future<BusinessProfile?> getBusinessProfile(String id) async {
    try {
      final businessId = int.tryParse(id);
      if (businessId == null) return null;

      // 1. Fetch Basic Info
      final business = await _repository.getBusinessById(businessId);
      if (business == null) return null;

      // 2. Fetch Services (for count)
      final services = await _repository.getServices(businessId);

      // 3. Fetch Reviews (for rating)
      final reviews = await _repository.getReviews(businessId);

      // 4. Fetch Likes Status
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final likeStatus = await _repository.getBusinessLikeStatus(
        businessId,
        userId,
      );

      // 5. Calculate Stats
      double avgRating = 0;
      if (reviews.isNotEmpty) {
        final total = reviews.fold(0, (sum, r) => sum + (r['rating'] as int));
        avgRating = total / reviews.length;
      }

      // 6. Parse Images (Portfolio)
      List<String> portfolioImages = [];
      if (business['images'] != null) {
        try {
          final imgs = business['images'];
          if (imgs is List) {
            portfolioImages = imgs.map((e) => e.toString()).toList();
          } else if (imgs is String) {
            // Handle potential JSON string
            // portfolioImages = List<String>.from(jsonDecode(imgs));
            // For now assume if string it might be just one url or malformed
            portfolioImages = [imgs];
          }
        } catch (_) {}
      }

      return BusinessProfile(
        id: id,
        name: business['name'] ?? 'Negocio',
        handle:
            '@${business['name'].toString().replaceAll(' ', '').toLowerCase()}',
        description: business['description'] ?? 'Sin descripción.',
        coverImage:
            business['cover_image'] ??
            'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80&w=1200',
        avatarImage:
            business['profile_image'] ??
            'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?auto=format&fit=crop&w=300&q=80',
        rating: double.parse(avgRating.toStringAsFixed(1)),
        reviewCount: reviews.length,
        followers: 0, // TODO: Implement followers
        likesCount: likeStatus['count'] as int,
        isLiked: likeStatus['isLiked'] as bool,
        servicesCount: services.length,
        location: business['address'] ?? 'Sin ubicación',
        hours: business['hours'] ?? 'Sin horario',
        phone: business['phone'] ?? '',
        email: business['email'] ?? '',
        website: business['website'] ?? '',
        instagram: business['instagram'] ?? '',
        facebook: business['facebook'] ?? '',
        images: portfolioImages,
      );
    } catch (e) {
      print('Error fetching business profile view: $e');
      return null;
    }
  }

  Future<bool> toggleLike(String businessId) async {
    final bId = int.tryParse(businessId);
    if (bId == null) return false;

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return false;

    return await _repository.toggleBusinessLike(bId, userId);
  }

  Future<List<BusinessServiceItem>> getBusinessServices(String id) async {
    final businessId = int.tryParse(id);
    if (businessId == null) return [];

    try {
      final services = await _repository.getServices(businessId);
      return services.map((s) {
        // Price formatting
        String priceDisplay = '\$--';
        if (s['price_cents'] != null) {
          final p = (s['price_cents'] as int) / 100.0;
          priceDisplay = '\$${p.toStringAsFixed(0)}';
        }

        return BusinessServiceItem(
          id: s['id'].toString(),
          title: s['name'] ?? 'Servicio',
          image:
              s['profile_image'] ??
              s['image'] ?? // Fallback to old key
              'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&q=80&w=400',
          price: priceDisplay,
          rating: '5.0', // Service specific rating not yet implemented
        );
      }).toList();
    } catch (e) {
      print('Error fetching business services: $e');
      return [];
    }
  }
}

final businessProfileServiceProvider = Provider((ref) {
  final repo = ref.watch(businessRepositoryProvider);
  return BusinessProfileService(repo);
});

final businessProfileProvider = FutureProvider.family<BusinessProfile?, String>(
  (ref, id) async {
    return ref.watch(businessProfileServiceProvider).getBusinessProfile(id);
  },
);

final businessServicesProvider =
    FutureProvider.family<List<BusinessServiceItem>, String>((ref, id) async {
      return ref.watch(businessProfileServiceProvider).getBusinessServices(id);
    });
