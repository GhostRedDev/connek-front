import 'dart:convert';

class UserProfile {
  final int id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone; // Changed to String to handle formatting flexibility
  final String? aboutMe;
  final String? photoId; // URL or path
  final String? bannerUrl;
  final bool hasBusiness;
  final List<String> images;
  final String? dob;
  final String? businessProfileImage;
  final String? businessName;
  final int? businessId;

  UserProfile({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.aboutMe,
    this.photoId,
    this.bannerUrl,
    this.hasBusiness = false,
    this.images = const [],
    this.dob,
    this.businessProfileImage,
    this.businessName,
    this.businessId,
  });

  // Factory to create from JSON (Supabase response)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone']?.toString(), // Handle int or string from DB
      aboutMe: json['about_me'] as String?,
      photoId: json['photo_id'] as String?,
      bannerUrl: json['banner_url'] as String?,
      hasBusiness: json['has_business'] as bool? ?? false,
      images: (json['images'] != null && json['images'] is String)
          ? List<String>.from(jsonDecode(json['images']))
          : (json['images'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ??
                [],
      dob: json['dob'] as String?,
      businessProfileImage: json['business_profile_image'] as String?,
      businessName: json['business_name'] as String?,
      businessId: json['business_id'] as int?,
    );
  }

  // To JSON for updates
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone, // Ensure DB accepts string or convert to int if strict
      'about_me': aboutMe,
      'photo_id': photoId,
      'banner_url': bannerUrl,
      'images': jsonEncode(images),
      'dob': dob,
      // Note: we don't usually update business fields via Client Profile update, so excluding them here is safe for now unless specifically requested.
    };
  }

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? aboutMe,
    String? photoId,
    String? bannerUrl,
    List<String>? images,
    String? dob,
    String? businessProfileImage,
    String? businessName,
  }) {
    return UserProfile(
      id: id,
      userId: userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email, // Email usually not changeable here
      phone: phone ?? this.phone,
      aboutMe: aboutMe ?? this.aboutMe,
      photoId: photoId ?? this.photoId,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      hasBusiness: hasBusiness,
      images: images ?? this.images,
      dob: dob ?? this.dob,
      businessProfileImage: businessProfileImage ?? this.businessProfileImage,
      businessName: businessName ?? this.businessName,
      businessId: businessId ?? this.businessId,
    );
  }
}
