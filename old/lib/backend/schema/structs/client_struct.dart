// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientStruct extends BaseStruct {
  ClientStruct({
    int? id,
    String? userId,
    String? createdAt,
    String? firstName,
    String? lastName,
    String? dob,
    String? email,
    int? phone,
    bool? hasBusiness,
    String? photoId,
    String? stripeId,
    String? aboutMe,
    String? workingAt,
    String? profileUrl,
    String? bannerUrl,
  })  : _id = id,
        _userId = userId,
        _createdAt = createdAt,
        _firstName = firstName,
        _lastName = lastName,
        _dob = dob,
        _email = email,
        _phone = phone,
        _hasBusiness = hasBusiness,
        _photoId = photoId,
        _stripeId = stripeId,
        _aboutMe = aboutMe,
        _workingAt = workingAt,
        _profileUrl = profileUrl,
        _bannerUrl = bannerUrl;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "first_name" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "dob" field.
  String? _dob;
  String get dob => _dob ?? '';
  set dob(String? val) => _dob = val;

  bool hasDob() => _dob != null;

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

  // "has_business" field.
  bool? _hasBusiness;
  bool get hasBusiness => _hasBusiness ?? false;
  set hasBusiness(bool? val) => _hasBusiness = val;

  bool hasHasBusiness() => _hasBusiness != null;

  // "photo_id" field.
  String? _photoId;
  String get photoId => _photoId ?? '';
  set photoId(String? val) => _photoId = val;

  bool hasPhotoId() => _photoId != null;

  // "stripe_id" field.
  String? _stripeId;
  String get stripeId => _stripeId ?? '';
  set stripeId(String? val) => _stripeId = val;

  bool hasStripeId() => _stripeId != null;

  // "about_me" field.
  String? _aboutMe;
  String get aboutMe => _aboutMe ?? '';
  set aboutMe(String? val) => _aboutMe = val;

  bool hasAboutMe() => _aboutMe != null;

  // "working_at" field.
  String? _workingAt;
  String get workingAt => _workingAt ?? '';
  set workingAt(String? val) => _workingAt = val;

  bool hasWorkingAt() => _workingAt != null;

  // "profile_url" field.
  String? _profileUrl;
  String get profileUrl => _profileUrl ?? '';
  set profileUrl(String? val) => _profileUrl = val;

  bool hasProfileUrl() => _profileUrl != null;

  // "banner_url" field.
  String? _bannerUrl;
  String get bannerUrl => _bannerUrl ?? '';
  set bannerUrl(String? val) => _bannerUrl = val;

  bool hasBannerUrl() => _bannerUrl != null;

  static ClientStruct fromMap(Map<String, dynamic> data) => ClientStruct(
        id: castToType<int>(data['id']),
        userId: data['user_id'] as String?,
        createdAt: data['created_at'] as String?,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        dob: data['dob'] as String?,
        email: data['email'] as String?,
        phone: castToType<int>(data['phone']),
        hasBusiness: data['has_business'] as bool?,
        photoId: data['photo_id'] as String?,
        stripeId: data['stripe_id'] as String?,
        aboutMe: data['about_me'] as String?,
        workingAt: data['working_at'] as String?,
        profileUrl: data['profile_url'] as String?,
        bannerUrl: data['banner_url'] as String?,
      );

  static ClientStruct? maybeFromMap(dynamic data) =>
      data is Map ? ClientStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'user_id': _userId,
        'created_at': _createdAt,
        'first_name': _firstName,
        'last_name': _lastName,
        'dob': _dob,
        'email': _email,
        'phone': _phone,
        'has_business': _hasBusiness,
        'photo_id': _photoId,
        'stripe_id': _stripeId,
        'about_me': _aboutMe,
        'working_at': _workingAt,
        'profile_url': _profileUrl,
        'banner_url': _bannerUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'first_name': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'last_name': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'dob': serializeParam(
          _dob,
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
        'has_business': serializeParam(
          _hasBusiness,
          ParamType.bool,
        ),
        'photo_id': serializeParam(
          _photoId,
          ParamType.String,
        ),
        'stripe_id': serializeParam(
          _stripeId,
          ParamType.String,
        ),
        'about_me': serializeParam(
          _aboutMe,
          ParamType.String,
        ),
        'working_at': serializeParam(
          _workingAt,
          ParamType.String,
        ),
        'profile_url': serializeParam(
          _profileUrl,
          ParamType.String,
        ),
        'banner_url': serializeParam(
          _bannerUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClientStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClientStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        firstName: deserializeParam(
          data['first_name'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['last_name'],
          ParamType.String,
          false,
        ),
        dob: deserializeParam(
          data['dob'],
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
          data['has_business'],
          ParamType.bool,
          false,
        ),
        photoId: deserializeParam(
          data['photo_id'],
          ParamType.String,
          false,
        ),
        stripeId: deserializeParam(
          data['stripe_id'],
          ParamType.String,
          false,
        ),
        aboutMe: deserializeParam(
          data['about_me'],
          ParamType.String,
          false,
        ),
        workingAt: deserializeParam(
          data['working_at'],
          ParamType.String,
          false,
        ),
        profileUrl: deserializeParam(
          data['profile_url'],
          ParamType.String,
          false,
        ),
        bannerUrl: deserializeParam(
          data['banner_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClientStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientStruct &&
        id == other.id &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        dob == other.dob &&
        email == other.email &&
        phone == other.phone &&
        hasBusiness == other.hasBusiness &&
        photoId == other.photoId &&
        stripeId == other.stripeId &&
        aboutMe == other.aboutMe &&
        workingAt == other.workingAt &&
        profileUrl == other.profileUrl &&
        bannerUrl == other.bannerUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        userId,
        createdAt,
        firstName,
        lastName,
        dob,
        email,
        phone,
        hasBusiness,
        photoId,
        stripeId,
        aboutMe,
        workingAt,
        profileUrl,
        bannerUrl
      ]);
}

ClientStruct createClientStruct({
  int? id,
  String? userId,
  String? createdAt,
  String? firstName,
  String? lastName,
  String? dob,
  String? email,
  int? phone,
  bool? hasBusiness,
  String? photoId,
  String? stripeId,
  String? aboutMe,
  String? workingAt,
  String? profileUrl,
  String? bannerUrl,
}) =>
    ClientStruct(
      id: id,
      userId: userId,
      createdAt: createdAt,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      email: email,
      phone: phone,
      hasBusiness: hasBusiness,
      photoId: photoId,
      stripeId: stripeId,
      aboutMe: aboutMe,
      workingAt: workingAt,
      profileUrl: profileUrl,
      bannerUrl: bannerUrl,
    );
