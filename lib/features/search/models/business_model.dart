class BusinessSearchResponse {
  final bool success;
  final List<Business> data;
  final String? message;

  BusinessSearchResponse({
    required this.success,
    required this.data,
    this.message,
  });

  factory BusinessSearchResponse.fromJson(Map<String, dynamic> json) {
    return BusinessSearchResponse(
      success: json['success'] ?? false,
      data: json['data'] is List
          ? (json['data'] as List).map((e) => Business.fromJson(e)).toList()
          : [],
      message: json['message'],
    );
  }
}

class Business {
  final int id;
  final String name;
  final String description;
  final String? profileImage;
  final String? bannerImage;
  final String? category;
  final List<Service> services;
  final List<Address> addresses;
  final String? phone;
  final String? website;
  final String? url;
  final String? instagramHandle;

  Business({
    required this.id,
    required this.name,
    required this.description,
    this.profileImage,
    this.bannerImage,
    this.category,
    required this.services,
    required this.addresses,
    this.phone,

    this.website,
    this.url,
    this.instagramHandle,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      profileImage: json['profile_image'],
      bannerImage: json['banner_image'],
      category: json['category'],
      services: json['services'] is List
          ? (json['services'] as List).map((e) => Service.fromJson(e)).toList()
          : [],
      addresses: json['addresses'] is List
          ? (json['addresses'] as List).map((e) => Address.fromJson(e)).toList()
          : [],
      phone: json['phone']?.toString(),
      website: json['website'],
      url: json['url'],
      instagramHandle: json['instagram_handle'],
    );
  }
}

class Service {
  final int id;
  final String name;
  final double price;
  final String? image;
  final List<Map<String, dynamic>>? customForm;

  Service({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.customForm,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price:
          (json['price'] as num?)?.toDouble() ??
          ((json['price_cents'] as num?)?.toDouble() ?? 0.0) / 100,
      image: json['image'],
      customForm: json['custom_form'] != null
          ? List<Map<String, dynamic>>.from(json['custom_form'])
          : null,
    );
  }
}

class Address {
  final String city;
  final String address;

  Address({required this.city, required this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(city: json['city'] ?? '', address: json['address'] ?? '');
  }
}
