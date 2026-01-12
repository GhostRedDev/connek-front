class ContactModel {
  final int id;
  final DateTime createdAt;
  final ContactDetails contact;
  final bool isBusiness;
  final int? businessId;
  final bool youIsBusiness;
  final int? youBusinessId;
  final String? lastMessage;

  ContactModel({
    required this.id,
    required this.createdAt,
    required this.contact,
    required this.isBusiness,
    this.businessId,
    required this.youIsBusiness,
    this.youBusinessId,
    this.lastMessage,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      contact: ContactDetails.fromJson(json['contact']),
      isBusiness: json['is_business'],
      businessId: json['business_id'],
      youIsBusiness: json['you_is_business'],
      youBusinessId: json['you_business_id'],
      lastMessage: json['last_message'],
    );
  }
}

class ContactDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String? profileUrl;
  final String? bannerUrl;
  final bool hasBusiness;
  final bool verifiedIdentity;
  final String? aboutMe;

  ContactDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profileUrl,
    this.bannerUrl,
    required this.hasBusiness,
    required this.verifiedIdentity,
    this.aboutMe,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileUrl: json['profile_url'],
      bannerUrl: json['banner_url'],
      hasBusiness: json['has_business'] ?? false,
      verifiedIdentity: json['verified_identity'] ?? false,
      aboutMe: json['about_me'],
    );
  }

  String get fullName => '$firstName $lastName'.trim();
}
