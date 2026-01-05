// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessStruct extends BaseStruct {
  BusinessStruct({
    int? id,
    String? createdAt,
    int? ownerClientId,
    String? ownerUser,
    String? name,
    String? category,
    String? description,
    String? businessEmail,
    String? url,
    int? phone,
    int? addressId,
    BusinessOpeningHoursStruct? openingHours,
    String? profileImage,
    String? bannerImage,
    String? googleBusinessId,
    String? stripeId,
    String? instagramHandle,
    String? tiktokHandle,
    String? facebookHandle,
    String? whatsappHandle,
    bool? payments,
    bool? validated,
  })  : _id = id,
        _createdAt = createdAt,
        _ownerClientId = ownerClientId,
        _ownerUser = ownerUser,
        _name = name,
        _category = category,
        _description = description,
        _businessEmail = businessEmail,
        _url = url,
        _phone = phone,
        _addressId = addressId,
        _openingHours = openingHours,
        _profileImage = profileImage,
        _bannerImage = bannerImage,
        _googleBusinessId = googleBusinessId,
        _stripeId = stripeId,
        _instagramHandle = instagramHandle,
        _tiktokHandle = tiktokHandle,
        _facebookHandle = facebookHandle,
        _whatsappHandle = whatsappHandle,
        _payments = payments,
        _validated = validated;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "owner_client_id" field.
  int? _ownerClientId;
  int get ownerClientId => _ownerClientId ?? 0;
  set ownerClientId(int? val) => _ownerClientId = val;

  void incrementOwnerClientId(int amount) =>
      ownerClientId = ownerClientId + amount;

  bool hasOwnerClientId() => _ownerClientId != null;

  // "owner_user" field.
  String? _ownerUser;
  String get ownerUser => _ownerUser ?? '';
  set ownerUser(String? val) => _ownerUser = val;

  bool hasOwnerUser() => _ownerUser != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "business_email" field.
  String? _businessEmail;
  String get businessEmail => _businessEmail ?? '';
  set businessEmail(String? val) => _businessEmail = val;

  bool hasBusinessEmail() => _businessEmail != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  // "phone" field.
  int? _phone;
  int get phone => _phone ?? 0;
  set phone(int? val) => _phone = val;

  void incrementPhone(int amount) => phone = phone + amount;

  bool hasPhone() => _phone != null;

  // "address_id" field.
  int? _addressId;
  int get addressId => _addressId ?? 0;
  set addressId(int? val) => _addressId = val;

  void incrementAddressId(int amount) => addressId = addressId + amount;

  bool hasAddressId() => _addressId != null;

  // "opening_hours" field.
  BusinessOpeningHoursStruct? _openingHours;
  BusinessOpeningHoursStruct get openingHours =>
      _openingHours ?? BusinessOpeningHoursStruct();
  set openingHours(BusinessOpeningHoursStruct? val) => _openingHours = val;

  void updateOpeningHours(Function(BusinessOpeningHoursStruct) updateFn) {
    updateFn(_openingHours ??= BusinessOpeningHoursStruct());
  }

  bool hasOpeningHours() => _openingHours != null;

  // "profile_image" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  set profileImage(String? val) => _profileImage = val;

  bool hasProfileImage() => _profileImage != null;

  // "banner_image" field.
  String? _bannerImage;
  String get bannerImage => _bannerImage ?? '';
  set bannerImage(String? val) => _bannerImage = val;

  bool hasBannerImage() => _bannerImage != null;

  // "google_business_id" field.
  String? _googleBusinessId;
  String get googleBusinessId => _googleBusinessId ?? '';
  set googleBusinessId(String? val) => _googleBusinessId = val;

  bool hasGoogleBusinessId() => _googleBusinessId != null;

  // "stripe_id" field.
  String? _stripeId;
  String get stripeId => _stripeId ?? '';
  set stripeId(String? val) => _stripeId = val;

  bool hasStripeId() => _stripeId != null;

  // "instagram_handle" field.
  String? _instagramHandle;
  String get instagramHandle => _instagramHandle ?? '';
  set instagramHandle(String? val) => _instagramHandle = val;

  bool hasInstagramHandle() => _instagramHandle != null;

  // "tiktok_handle" field.
  String? _tiktokHandle;
  String get tiktokHandle => _tiktokHandle ?? '';
  set tiktokHandle(String? val) => _tiktokHandle = val;

  bool hasTiktokHandle() => _tiktokHandle != null;

  // "facebook_handle" field.
  String? _facebookHandle;
  String get facebookHandle => _facebookHandle ?? '';
  set facebookHandle(String? val) => _facebookHandle = val;

  bool hasFacebookHandle() => _facebookHandle != null;

  // "whatsapp_handle" field.
  String? _whatsappHandle;
  String get whatsappHandle => _whatsappHandle ?? '';
  set whatsappHandle(String? val) => _whatsappHandle = val;

  bool hasWhatsappHandle() => _whatsappHandle != null;

  // "payments" field.
  bool? _payments;
  bool get payments => _payments ?? false;
  set payments(bool? val) => _payments = val;

  bool hasPayments() => _payments != null;

  // "validated" field.
  bool? _validated;
  bool get validated => _validated ?? false;
  set validated(bool? val) => _validated = val;

  bool hasValidated() => _validated != null;

  static BusinessStruct fromMap(Map<String, dynamic> data) => BusinessStruct(
        id: castToType<int>(data['id']),
        createdAt: data['created_at'] as String?,
        ownerClientId: castToType<int>(data['owner_client_id']),
        ownerUser: data['owner_user'] as String?,
        name: data['name'] as String?,
        category: data['category'] as String?,
        description: data['description'] as String?,
        businessEmail: data['business_email'] as String?,
        url: data['url'] as String?,
        phone: castToType<int>(data['phone']),
        addressId: castToType<int>(data['address_id']),
        openingHours: data['opening_hours'] is BusinessOpeningHoursStruct
            ? data['opening_hours']
            : BusinessOpeningHoursStruct.maybeFromMap(data['opening_hours']),
        profileImage: data['profile_image'] as String?,
        bannerImage: data['banner_image'] as String?,
        googleBusinessId: data['google_business_id'] as String?,
        stripeId: data['stripe_id'] as String?,
        instagramHandle: data['instagram_handle'] as String?,
        tiktokHandle: data['tiktok_handle'] as String?,
        facebookHandle: data['facebook_handle'] as String?,
        whatsappHandle: data['whatsapp_handle'] as String?,
        payments: data['payments'] as bool?,
        validated: data['validated'] as bool?,
      );

  static BusinessStruct? maybeFromMap(dynamic data) =>
      data is Map ? BusinessStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'created_at': _createdAt,
        'owner_client_id': _ownerClientId,
        'owner_user': _ownerUser,
        'name': _name,
        'category': _category,
        'description': _description,
        'business_email': _businessEmail,
        'url': _url,
        'phone': _phone,
        'address_id': _addressId,
        'opening_hours': _openingHours?.toMap(),
        'profile_image': _profileImage,
        'banner_image': _bannerImage,
        'google_business_id': _googleBusinessId,
        'stripe_id': _stripeId,
        'instagram_handle': _instagramHandle,
        'tiktok_handle': _tiktokHandle,
        'facebook_handle': _facebookHandle,
        'whatsapp_handle': _whatsappHandle,
        'payments': _payments,
        'validated': _validated,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'owner_client_id': serializeParam(
          _ownerClientId,
          ParamType.int,
        ),
        'owner_user': serializeParam(
          _ownerUser,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'business_email': serializeParam(
          _businessEmail,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.int,
        ),
        'address_id': serializeParam(
          _addressId,
          ParamType.int,
        ),
        'opening_hours': serializeParam(
          _openingHours,
          ParamType.DataStruct,
        ),
        'profile_image': serializeParam(
          _profileImage,
          ParamType.String,
        ),
        'banner_image': serializeParam(
          _bannerImage,
          ParamType.String,
        ),
        'google_business_id': serializeParam(
          _googleBusinessId,
          ParamType.String,
        ),
        'stripe_id': serializeParam(
          _stripeId,
          ParamType.String,
        ),
        'instagram_handle': serializeParam(
          _instagramHandle,
          ParamType.String,
        ),
        'tiktok_handle': serializeParam(
          _tiktokHandle,
          ParamType.String,
        ),
        'facebook_handle': serializeParam(
          _facebookHandle,
          ParamType.String,
        ),
        'whatsapp_handle': serializeParam(
          _whatsappHandle,
          ParamType.String,
        ),
        'payments': serializeParam(
          _payments,
          ParamType.bool,
        ),
        'validated': serializeParam(
          _validated,
          ParamType.bool,
        ),
      }.withoutNulls;

  static BusinessStruct fromSerializableMap(Map<String, dynamic> data) =>
      BusinessStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        ownerClientId: deserializeParam(
          data['owner_client_id'],
          ParamType.int,
          false,
        ),
        ownerUser: deserializeParam(
          data['owner_user'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        businessEmail: deserializeParam(
          data['business_email'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.int,
          false,
        ),
        addressId: deserializeParam(
          data['address_id'],
          ParamType.int,
          false,
        ),
        openingHours: deserializeStructParam(
          data['opening_hours'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessOpeningHoursStruct.fromSerializableMap,
        ),
        profileImage: deserializeParam(
          data['profile_image'],
          ParamType.String,
          false,
        ),
        bannerImage: deserializeParam(
          data['banner_image'],
          ParamType.String,
          false,
        ),
        googleBusinessId: deserializeParam(
          data['google_business_id'],
          ParamType.String,
          false,
        ),
        stripeId: deserializeParam(
          data['stripe_id'],
          ParamType.String,
          false,
        ),
        instagramHandle: deserializeParam(
          data['instagram_handle'],
          ParamType.String,
          false,
        ),
        tiktokHandle: deserializeParam(
          data['tiktok_handle'],
          ParamType.String,
          false,
        ),
        facebookHandle: deserializeParam(
          data['facebook_handle'],
          ParamType.String,
          false,
        ),
        whatsappHandle: deserializeParam(
          data['whatsapp_handle'],
          ParamType.String,
          false,
        ),
        payments: deserializeParam(
          data['payments'],
          ParamType.bool,
          false,
        ),
        validated: deserializeParam(
          data['validated'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'BusinessStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        ownerClientId == other.ownerClientId &&
        ownerUser == other.ownerUser &&
        name == other.name &&
        category == other.category &&
        description == other.description &&
        businessEmail == other.businessEmail &&
        url == other.url &&
        phone == other.phone &&
        addressId == other.addressId &&
        openingHours == other.openingHours &&
        profileImage == other.profileImage &&
        bannerImage == other.bannerImage &&
        googleBusinessId == other.googleBusinessId &&
        stripeId == other.stripeId &&
        instagramHandle == other.instagramHandle &&
        tiktokHandle == other.tiktokHandle &&
        facebookHandle == other.facebookHandle &&
        whatsappHandle == other.whatsappHandle &&
        payments == other.payments &&
        validated == other.validated;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        ownerClientId,
        ownerUser,
        name,
        category,
        description,
        businessEmail,
        url,
        phone,
        addressId,
        openingHours,
        profileImage,
        bannerImage,
        googleBusinessId,
        stripeId,
        instagramHandle,
        tiktokHandle,
        facebookHandle,
        whatsappHandle,
        payments,
        validated
      ]);
}

BusinessStruct createBusinessStruct({
  int? id,
  String? createdAt,
  int? ownerClientId,
  String? ownerUser,
  String? name,
  String? category,
  String? description,
  String? businessEmail,
  String? url,
  int? phone,
  int? addressId,
  BusinessOpeningHoursStruct? openingHours,
  String? profileImage,
  String? bannerImage,
  String? googleBusinessId,
  String? stripeId,
  String? instagramHandle,
  String? tiktokHandle,
  String? facebookHandle,
  String? whatsappHandle,
  bool? payments,
  bool? validated,
}) =>
    BusinessStruct(
      id: id,
      createdAt: createdAt,
      ownerClientId: ownerClientId,
      ownerUser: ownerUser,
      name: name,
      category: category,
      description: description,
      businessEmail: businessEmail,
      url: url,
      phone: phone,
      addressId: addressId,
      openingHours: openingHours ?? BusinessOpeningHoursStruct(),
      profileImage: profileImage,
      bannerImage: bannerImage,
      googleBusinessId: googleBusinessId,
      stripeId: stripeId,
      instagramHandle: instagramHandle,
      tiktokHandle: tiktokHandle,
      facebookHandle: facebookHandle,
      whatsappHandle: whatsappHandle,
      payments: payments,
      validated: validated,
    );
