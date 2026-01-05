// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientDataProfileStruct extends BaseStruct {
  ClientDataProfileStruct({
    String? firstName,
    String? lastName,
    String? email,
    int? phone,
    bool? hasBusiness,
    String? stripeId,
    DateTime? dob,
    String? aboutMe,
    String? profileUrl,
    String? bannerUrl,
    int? clientId,
    String? images,
  })  : _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _phone = phone,
        _hasBusiness = hasBusiness,
        _stripeId = stripeId,
        _dob = dob,
        _aboutMe = aboutMe,
        _profileUrl = profileUrl,
        _bannerUrl = bannerUrl,
        _clientId = clientId,
        _images = images;

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "lastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "phone" field.
  int? _phone;
  int get phone => _phone ?? 0;
  set phone(int? val) => _phone = val;

  void incrementPhone(int amount) => phone = phone + amount;

  bool hasPhone() => _phone != null;

  // "hasBusiness" field.
  bool? _hasBusiness;
  bool get hasBusiness => _hasBusiness ?? false;
  set hasBusiness(bool? val) => _hasBusiness = val;

  bool hasHasBusiness() => _hasBusiness != null;

  // "stripeId" field.
  String? _stripeId;
  String get stripeId => _stripeId ?? '';
  set stripeId(String? val) => _stripeId = val;

  bool hasStripeId() => _stripeId != null;

  // "dob" field.
  DateTime? _dob;
  DateTime? get dob => _dob;
  set dob(DateTime? val) => _dob = val;

  bool hasDob() => _dob != null;

  // "aboutMe" field.
  String? _aboutMe;
  String get aboutMe => _aboutMe ?? '';
  set aboutMe(String? val) => _aboutMe = val;

  bool hasAboutMe() => _aboutMe != null;

  // "profileUrl" field.
  String? _profileUrl;
  String get profileUrl => _profileUrl ?? '';
  set profileUrl(String? val) => _profileUrl = val;

  bool hasProfileUrl() => _profileUrl != null;

  // "bannerUrl" field.
  String? _bannerUrl;
  String get bannerUrl => _bannerUrl ?? '';
  set bannerUrl(String? val) => _bannerUrl = val;

  bool hasBannerUrl() => _bannerUrl != null;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "images" field.
  String? _images;
  String get images => _images ?? '';
  set images(String? val) => _images = val;

  bool hasImages() => _images != null;

  static ClientDataProfileStruct fromMap(Map<String, dynamic> data) =>
      ClientDataProfileStruct(
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        email: data['email'] as String?,
        phone: castToType<int>(data['phone']),
        hasBusiness: data['hasBusiness'] as bool?,
        stripeId: data['stripeId'] as String?,
        dob: data['dob'] as DateTime?,
        aboutMe: data['aboutMe'] as String?,
        profileUrl: data['profileUrl'] as String?,
        bannerUrl: data['bannerUrl'] as String?,
        clientId: castToType<int>(data['clientId']),
        images: data['images'] as String?,
      );

  static ClientDataProfileStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientDataProfileStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'firstName': _firstName,
        'lastName': _lastName,
        'email': _email,
        'phone': _phone,
        'hasBusiness': _hasBusiness,
        'stripeId': _stripeId,
        'dob': _dob,
        'aboutMe': _aboutMe,
        'profileUrl': _profileUrl,
        'bannerUrl': _bannerUrl,
        'clientId': _clientId,
        'images': _images,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'firstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'lastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.int,
        ),
        'hasBusiness': serializeParam(
          _hasBusiness,
          ParamType.bool,
        ),
        'stripeId': serializeParam(
          _stripeId,
          ParamType.String,
        ),
        'dob': serializeParam(
          _dob,
          ParamType.DateTime,
        ),
        'aboutMe': serializeParam(
          _aboutMe,
          ParamType.String,
        ),
        'profileUrl': serializeParam(
          _profileUrl,
          ParamType.String,
        ),
        'bannerUrl': serializeParam(
          _bannerUrl,
          ParamType.String,
        ),
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClientDataProfileStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientDataProfileStruct(
        firstName: deserializeParam(
          data['firstName'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['lastName'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.int,
          false,
        ),
        hasBusiness: deserializeParam(
          data['hasBusiness'],
          ParamType.bool,
          false,
        ),
        stripeId: deserializeParam(
          data['stripeId'],
          ParamType.String,
          false,
        ),
        dob: deserializeParam(
          data['dob'],
          ParamType.DateTime,
          false,
        ),
        aboutMe: deserializeParam(
          data['aboutMe'],
          ParamType.String,
          false,
        ),
        profileUrl: deserializeParam(
          data['profileUrl'],
          ParamType.String,
          false,
        ),
        bannerUrl: deserializeParam(
          data['bannerUrl'],
          ParamType.String,
          false,
        ),
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        images: deserializeParam(
          data['images'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClientDataProfileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientDataProfileStruct &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        phone == other.phone &&
        hasBusiness == other.hasBusiness &&
        stripeId == other.stripeId &&
        dob == other.dob &&
        aboutMe == other.aboutMe &&
        profileUrl == other.profileUrl &&
        bannerUrl == other.bannerUrl &&
        clientId == other.clientId &&
        images == other.images;
  }

  @override
  int get hashCode => const ListEquality().hash([
        firstName,
        lastName,
        email,
        phone,
        hasBusiness,
        stripeId,
        dob,
        aboutMe,
        profileUrl,
        bannerUrl,
        clientId,
        images
      ]);
}

ClientDataProfileStruct createClientDataProfileStruct({
  String? firstName,
  String? lastName,
  String? email,
  int? phone,
  bool? hasBusiness,
  String? stripeId,
  DateTime? dob,
  String? aboutMe,
  String? profileUrl,
  String? bannerUrl,
  int? clientId,
  String? images,
}) =>
    ClientDataProfileStruct(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      hasBusiness: hasBusiness,
      stripeId: stripeId,
      dob: dob,
      aboutMe: aboutMe,
      profileUrl: profileUrl,
      bannerUrl: bannerUrl,
      clientId: clientId,
      images: images,
    );
