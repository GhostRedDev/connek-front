// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessDataStruct extends BaseStruct {
  BusinessDataStruct({
    int? id,
    int? ownerClientId,
    String? name,
    String? category,
    String? description,
    String? businessEmail,
    String? url,
    int? addressId,
    int? businessPhone,
    String? googleBusinessId,
    String? stripeId,
    bool? payments,
    bool? validated,
    List<ServiceDataStruct>? services,
    List<AddressDataStruct>? addresses,
    String? profileImage,
    String? bannerImage,
    String? instagramHandle,
    String? facebookHandle,
    String? tiktokHandle,
    String? whatsappHandle,
    String? images,
    BusinessOpeningHoursStruct? openingHours,
    String? stripeCustomerId,
  })  : _id = id,
        _ownerClientId = ownerClientId,
        _name = name,
        _category = category,
        _description = description,
        _businessEmail = businessEmail,
        _url = url,
        _addressId = addressId,
        _businessPhone = businessPhone,
        _googleBusinessId = googleBusinessId,
        _stripeId = stripeId,
        _payments = payments,
        _validated = validated,
        _services = services,
        _addresses = addresses,
        _profileImage = profileImage,
        _bannerImage = bannerImage,
        _instagramHandle = instagramHandle,
        _facebookHandle = facebookHandle,
        _tiktokHandle = tiktokHandle,
        _whatsappHandle = whatsappHandle,
        _images = images,
        _openingHours = openingHours,
        _stripeCustomerId = stripeCustomerId;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "ownerClientId" field.
  int? _ownerClientId;
  int get ownerClientId => _ownerClientId ?? 0;
  set ownerClientId(int? val) => _ownerClientId = val;

  void incrementOwnerClientId(int amount) =>
      ownerClientId = ownerClientId + amount;

  bool hasOwnerClientId() => _ownerClientId != null;

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

  // "businessEmail" field.
  String? _businessEmail;
  String get businessEmail => _businessEmail ?? '';
  set businessEmail(String? val) => _businessEmail = val;

  bool hasBusinessEmail() => _businessEmail != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  // "addressId" field.
  int? _addressId;
  int get addressId => _addressId ?? 0;
  set addressId(int? val) => _addressId = val;

  void incrementAddressId(int amount) => addressId = addressId + amount;

  bool hasAddressId() => _addressId != null;

  // "businessPhone" field.
  int? _businessPhone;
  int get businessPhone => _businessPhone ?? 0;
  set businessPhone(int? val) => _businessPhone = val;

  void incrementBusinessPhone(int amount) =>
      businessPhone = businessPhone + amount;

  bool hasBusinessPhone() => _businessPhone != null;

  // "googleBusinessId" field.
  String? _googleBusinessId;
  String get googleBusinessId => _googleBusinessId ?? '';
  set googleBusinessId(String? val) => _googleBusinessId = val;

  bool hasGoogleBusinessId() => _googleBusinessId != null;

  // "stripeId" field.
  String? _stripeId;
  String get stripeId => _stripeId ?? '';
  set stripeId(String? val) => _stripeId = val;

  bool hasStripeId() => _stripeId != null;

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

  // "services" field.
  List<ServiceDataStruct>? _services;
  List<ServiceDataStruct> get services => _services ?? const [];
  set services(List<ServiceDataStruct>? val) => _services = val;

  void updateServices(Function(List<ServiceDataStruct>) updateFn) {
    updateFn(_services ??= []);
  }

  bool hasServices() => _services != null;

  // "addresses" field.
  List<AddressDataStruct>? _addresses;
  List<AddressDataStruct> get addresses => _addresses ?? const [];
  set addresses(List<AddressDataStruct>? val) => _addresses = val;

  void updateAddresses(Function(List<AddressDataStruct>) updateFn) {
    updateFn(_addresses ??= []);
  }

  bool hasAddresses() => _addresses != null;

  // "profileImage" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  set profileImage(String? val) => _profileImage = val;

  bool hasProfileImage() => _profileImage != null;

  // "bannerImage" field.
  String? _bannerImage;
  String get bannerImage => _bannerImage ?? '';
  set bannerImage(String? val) => _bannerImage = val;

  bool hasBannerImage() => _bannerImage != null;

  // "instagramHandle" field.
  String? _instagramHandle;
  String get instagramHandle => _instagramHandle ?? '';
  set instagramHandle(String? val) => _instagramHandle = val;

  bool hasInstagramHandle() => _instagramHandle != null;

  // "facebookHandle" field.
  String? _facebookHandle;
  String get facebookHandle => _facebookHandle ?? '';
  set facebookHandle(String? val) => _facebookHandle = val;

  bool hasFacebookHandle() => _facebookHandle != null;

  // "tiktokHandle" field.
  String? _tiktokHandle;
  String get tiktokHandle => _tiktokHandle ?? '';
  set tiktokHandle(String? val) => _tiktokHandle = val;

  bool hasTiktokHandle() => _tiktokHandle != null;

  // "whatsappHandle" field.
  String? _whatsappHandle;
  String get whatsappHandle => _whatsappHandle ?? '';
  set whatsappHandle(String? val) => _whatsappHandle = val;

  bool hasWhatsappHandle() => _whatsappHandle != null;

  // "images" field.
  String? _images;
  String get images => _images ?? '';
  set images(String? val) => _images = val;

  bool hasImages() => _images != null;

  // "openingHours" field.
  BusinessOpeningHoursStruct? _openingHours;
  BusinessOpeningHoursStruct get openingHours =>
      _openingHours ?? BusinessOpeningHoursStruct();
  set openingHours(BusinessOpeningHoursStruct? val) => _openingHours = val;

  void updateOpeningHours(Function(BusinessOpeningHoursStruct) updateFn) {
    updateFn(_openingHours ??= BusinessOpeningHoursStruct());
  }

  bool hasOpeningHours() => _openingHours != null;

  // "stripeCustomerId" field.
  String? _stripeCustomerId;
  String get stripeCustomerId => _stripeCustomerId ?? '';
  set stripeCustomerId(String? val) => _stripeCustomerId = val;

  bool hasStripeCustomerId() => _stripeCustomerId != null;

  static BusinessDataStruct fromMap(Map<String, dynamic> data) =>
      BusinessDataStruct(
        id: castToType<int>(data['id']),
        ownerClientId: castToType<int>(data['ownerClientId']),
        name: data['name'] as String?,
        category: data['category'] as String?,
        description: data['description'] as String?,
        businessEmail: data['businessEmail'] as String?,
        url: data['url'] as String?,
        addressId: castToType<int>(data['addressId']),
        businessPhone: castToType<int>(data['businessPhone']),
        googleBusinessId: data['googleBusinessId'] as String?,
        stripeId: data['stripeId'] as String?,
        payments: data['payments'] as bool?,
        validated: data['validated'] as bool?,
        services: getStructList(
          data['services'],
          ServiceDataStruct.fromMap,
        ),
        addresses: getStructList(
          data['addresses'],
          AddressDataStruct.fromMap,
        ),
        profileImage: data['profileImage'] as String?,
        bannerImage: data['bannerImage'] as String?,
        instagramHandle: data['instagramHandle'] as String?,
        facebookHandle: data['facebookHandle'] as String?,
        tiktokHandle: data['tiktokHandle'] as String?,
        whatsappHandle: data['whatsappHandle'] as String?,
        images: data['images'] as String?,
        openingHours: data['openingHours'] is BusinessOpeningHoursStruct
            ? data['openingHours']
            : BusinessOpeningHoursStruct.maybeFromMap(data['openingHours']),
        stripeCustomerId: data['stripeCustomerId'] as String?,
      );

  static BusinessDataStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'ownerClientId': _ownerClientId,
        'name': _name,
        'category': _category,
        'description': _description,
        'businessEmail': _businessEmail,
        'url': _url,
        'addressId': _addressId,
        'businessPhone': _businessPhone,
        'googleBusinessId': _googleBusinessId,
        'stripeId': _stripeId,
        'payments': _payments,
        'validated': _validated,
        'services': _services?.map((e) => e.toMap()).toList(),
        'addresses': _addresses?.map((e) => e.toMap()).toList(),
        'profileImage': _profileImage,
        'bannerImage': _bannerImage,
        'instagramHandle': _instagramHandle,
        'facebookHandle': _facebookHandle,
        'tiktokHandle': _tiktokHandle,
        'whatsappHandle': _whatsappHandle,
        'images': _images,
        'openingHours': _openingHours?.toMap(),
        'stripeCustomerId': _stripeCustomerId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'ownerClientId': serializeParam(
          _ownerClientId,
          ParamType.int,
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
        'businessEmail': serializeParam(
          _businessEmail,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'addressId': serializeParam(
          _addressId,
          ParamType.int,
        ),
        'businessPhone': serializeParam(
          _businessPhone,
          ParamType.int,
        ),
        'googleBusinessId': serializeParam(
          _googleBusinessId,
          ParamType.String,
        ),
        'stripeId': serializeParam(
          _stripeId,
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
        'services': serializeParam(
          _services,
          ParamType.DataStruct,
          isList: true,
        ),
        'addresses': serializeParam(
          _addresses,
          ParamType.DataStruct,
          isList: true,
        ),
        'profileImage': serializeParam(
          _profileImage,
          ParamType.String,
        ),
        'bannerImage': serializeParam(
          _bannerImage,
          ParamType.String,
        ),
        'instagramHandle': serializeParam(
          _instagramHandle,
          ParamType.String,
        ),
        'facebookHandle': serializeParam(
          _facebookHandle,
          ParamType.String,
        ),
        'tiktokHandle': serializeParam(
          _tiktokHandle,
          ParamType.String,
        ),
        'whatsappHandle': serializeParam(
          _whatsappHandle,
          ParamType.String,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
        ),
        'openingHours': serializeParam(
          _openingHours,
          ParamType.DataStruct,
        ),
        'stripeCustomerId': serializeParam(
          _stripeCustomerId,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      BusinessDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        ownerClientId: deserializeParam(
          data['ownerClientId'],
          ParamType.int,
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
          data['businessEmail'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        addressId: deserializeParam(
          data['addressId'],
          ParamType.int,
          false,
        ),
        businessPhone: deserializeParam(
          data['businessPhone'],
          ParamType.int,
          false,
        ),
        googleBusinessId: deserializeParam(
          data['googleBusinessId'],
          ParamType.String,
          false,
        ),
        stripeId: deserializeParam(
          data['stripeId'],
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
        services: deserializeStructParam<ServiceDataStruct>(
          data['services'],
          ParamType.DataStruct,
          true,
          structBuilder: ServiceDataStruct.fromSerializableMap,
        ),
        addresses: deserializeStructParam<AddressDataStruct>(
          data['addresses'],
          ParamType.DataStruct,
          true,
          structBuilder: AddressDataStruct.fromSerializableMap,
        ),
        profileImage: deserializeParam(
          data['profileImage'],
          ParamType.String,
          false,
        ),
        bannerImage: deserializeParam(
          data['bannerImage'],
          ParamType.String,
          false,
        ),
        instagramHandle: deserializeParam(
          data['instagramHandle'],
          ParamType.String,
          false,
        ),
        facebookHandle: deserializeParam(
          data['facebookHandle'],
          ParamType.String,
          false,
        ),
        tiktokHandle: deserializeParam(
          data['tiktokHandle'],
          ParamType.String,
          false,
        ),
        whatsappHandle: deserializeParam(
          data['whatsappHandle'],
          ParamType.String,
          false,
        ),
        images: deserializeParam(
          data['images'],
          ParamType.String,
          false,
        ),
        openingHours: deserializeStructParam(
          data['openingHours'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessOpeningHoursStruct.fromSerializableMap,
        ),
        stripeCustomerId: deserializeParam(
          data['stripeCustomerId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BusinessDataStruct &&
        id == other.id &&
        ownerClientId == other.ownerClientId &&
        name == other.name &&
        category == other.category &&
        description == other.description &&
        businessEmail == other.businessEmail &&
        url == other.url &&
        addressId == other.addressId &&
        businessPhone == other.businessPhone &&
        googleBusinessId == other.googleBusinessId &&
        stripeId == other.stripeId &&
        payments == other.payments &&
        validated == other.validated &&
        listEquality.equals(services, other.services) &&
        listEquality.equals(addresses, other.addresses) &&
        profileImage == other.profileImage &&
        bannerImage == other.bannerImage &&
        instagramHandle == other.instagramHandle &&
        facebookHandle == other.facebookHandle &&
        tiktokHandle == other.tiktokHandle &&
        whatsappHandle == other.whatsappHandle &&
        images == other.images &&
        openingHours == other.openingHours &&
        stripeCustomerId == other.stripeCustomerId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        ownerClientId,
        name,
        category,
        description,
        businessEmail,
        url,
        addressId,
        businessPhone,
        googleBusinessId,
        stripeId,
        payments,
        validated,
        services,
        addresses,
        profileImage,
        bannerImage,
        instagramHandle,
        facebookHandle,
        tiktokHandle,
        whatsappHandle,
        images,
        openingHours,
        stripeCustomerId
      ]);
}

BusinessDataStruct createBusinessDataStruct({
  int? id,
  int? ownerClientId,
  String? name,
  String? category,
  String? description,
  String? businessEmail,
  String? url,
  int? addressId,
  int? businessPhone,
  String? googleBusinessId,
  String? stripeId,
  bool? payments,
  bool? validated,
  String? profileImage,
  String? bannerImage,
  String? instagramHandle,
  String? facebookHandle,
  String? tiktokHandle,
  String? whatsappHandle,
  String? images,
  BusinessOpeningHoursStruct? openingHours,
  String? stripeCustomerId,
}) =>
    BusinessDataStruct(
      id: id,
      ownerClientId: ownerClientId,
      name: name,
      category: category,
      description: description,
      businessEmail: businessEmail,
      url: url,
      addressId: addressId,
      businessPhone: businessPhone,
      googleBusinessId: googleBusinessId,
      stripeId: stripeId,
      payments: payments,
      validated: validated,
      profileImage: profileImage,
      bannerImage: bannerImage,
      instagramHandle: instagramHandle,
      facebookHandle: facebookHandle,
      tiktokHandle: tiktokHandle,
      whatsappHandle: whatsappHandle,
      images: images,
      openingHours: openingHours ?? BusinessOpeningHoursStruct(),
      stripeCustomerId: stripeCustomerId,
    );
