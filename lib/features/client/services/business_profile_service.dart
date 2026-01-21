import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final int servicesCount;
  final String location;
  final String hours;
  final String phone;
  final String email;
  final String website;
  final String instagram;
  final String facebook;

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
    required this.servicesCount,
    required this.location,
    required this.hours,
    required this.phone,
    required this.email,
    required this.website,
    required this.instagram,
    required this.facebook,
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
  Future<BusinessProfile?> getBusinessProfile(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock Data
    return BusinessProfile(
      id: id,
      name: 'Studio Creativo Luna',
      handle: '@studiocreativoluna',
      description:
          'Transformamos ideas en experiencias visuales memorables. Especialistas en branding, diseño web y producción audiovisual.',
      coverImage:
          'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80&w=1200',
      avatarImage:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=200',
      rating: 4.9,
      reviewCount: 127,
      followers: 2400,
      servicesCount: 5,
      location: 'Ciudad de México, MX',
      hours: 'Lun - Vie: 9:00 - 18:00',
      phone: '+52 55 1234 5678',
      email: 'hola@studiocreativoluna.com',
      website: 'www.studiocreativoluna.com',
      instagram: '@studiocreativoluna',
      facebook: 'studiocreativoluna',
    );
  }

  Future<List<BusinessServiceItem>> getBusinessServices(String id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      const BusinessServiceItem(
        id: 's1',
        title: 'Terapia para mejorar el flujo de energía',
        image:
            'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&q=80&w=400',
        price: '\$40/h',
        rating: '5.0',
      ),
      const BusinessServiceItem(
        id: 's2',
        title: 'Consulta de Diseño de Interiores',
        image:
            'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&q=80&w=400',
        price: '\$80/h',
        rating: '5.0',
      ),
      const BusinessServiceItem(
        id: 's3',
        title: 'Paquete Completo de Branding',
        image:
            'https://images.unsplash.com/photo-1626785774573-4b79931434c3?auto=format&fit=crop&q=80&w=400',
        price: '\$500',
        rating: '4.8',
      ),
    ];
  }
}

final businessProfileServiceProvider = Provider(
  (ref) => BusinessProfileService(),
);

final businessProfileProvider = FutureProvider.family<BusinessProfile?, String>(
  (ref, id) async {
    return ref.watch(businessProfileServiceProvider).getBusinessProfile(id);
  },
);

final businessServicesProvider =
    FutureProvider.family<List<BusinessServiceItem>, String>((ref, id) async {
      return ref.watch(businessProfileServiceProvider).getBusinessServices(id);
    });
