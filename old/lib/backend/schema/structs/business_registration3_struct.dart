// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessRegistration3Struct extends BaseStruct {
  BusinessRegistration3Struct({
    int? phone,
    String? websiteUrl,
    String? businessEmail,
    String? instagramHandle,
    String? xHandle,
    String? fbHandle,
  })  : _phone = phone,
        _websiteUrl = websiteUrl,
        _businessEmail = businessEmail,
        _instagramHandle = instagramHandle,
        _xHandle = xHandle,
        _fbHandle = fbHandle;

  // "phone" field.
  int? _phone;
  int get phone => _phone ?? 0;
  set phone(int? val) => _phone = val;

  void incrementPhone(int amount) => phone = phone + amount;

  bool hasPhone() => _phone != null;

  // "websiteUrl" field.
  String? _websiteUrl;
  String get websiteUrl => _websiteUrl ?? '';
  set websiteUrl(String? val) => _websiteUrl = val;

  bool hasWebsiteUrl() => _websiteUrl != null;

  // "businessEmail" field.
  String? _businessEmail;
  String get businessEmail => _businessEmail ?? '';
  set businessEmail(String? val) => _businessEmail = val;

  bool hasBusinessEmail() => _businessEmail != null;

  // "instagramHandle" field.
  String? _instagramHandle;
  String get instagramHandle => _instagramHandle ?? '';
  set instagramHandle(String? val) => _instagramHandle = val;

  bool hasInstagramHandle() => _instagramHandle != null;

  // "xHandle" field.
  String? _xHandle;
  String get xHandle => _xHandle ?? '';
  set xHandle(String? val) => _xHandle = val;

  bool hasXHandle() => _xHandle != null;

  // "fbHandle" field.
  String? _fbHandle;
  String get fbHandle => _fbHandle ?? '';
  set fbHandle(String? val) => _fbHandle = val;

  bool hasFbHandle() => _fbHandle != null;

  static BusinessRegistration3Struct fromMap(Map<String, dynamic> data) =>
      BusinessRegistration3Struct(
        phone: castToType<int>(data['phone']),
        websiteUrl: data['websiteUrl'] as String?,
        businessEmail: data['businessEmail'] as String?,
        instagramHandle: data['instagramHandle'] as String?,
        xHandle: data['xHandle'] as String?,
        fbHandle: data['fbHandle'] as String?,
      );

  static BusinessRegistration3Struct? maybeFromMap(dynamic data) => data is Map
      ? BusinessRegistration3Struct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'phone': _phone,
        'websiteUrl': _websiteUrl,
        'businessEmail': _businessEmail,
        'instagramHandle': _instagramHandle,
        'xHandle': _xHandle,
        'fbHandle': _fbHandle,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'phone': serializeParam(
          _phone,
          ParamType.int,
        ),
        'websiteUrl': serializeParam(
          _websiteUrl,
          ParamType.String,
        ),
        'businessEmail': serializeParam(
          _businessEmail,
          ParamType.String,
        ),
        'instagramHandle': serializeParam(
          _instagramHandle,
          ParamType.String,
        ),
        'xHandle': serializeParam(
          _xHandle,
          ParamType.String,
        ),
        'fbHandle': serializeParam(
          _fbHandle,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessRegistration3Struct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessRegistration3Struct(
        phone: deserializeParam(
          data['phone'],
          ParamType.int,
          false,
        ),
        websiteUrl: deserializeParam(
          data['websiteUrl'],
          ParamType.String,
          false,
        ),
        businessEmail: deserializeParam(
          data['businessEmail'],
          ParamType.String,
          false,
        ),
        instagramHandle: deserializeParam(
          data['instagramHandle'],
          ParamType.String,
          false,
        ),
        xHandle: deserializeParam(
          data['xHandle'],
          ParamType.String,
          false,
        ),
        fbHandle: deserializeParam(
          data['fbHandle'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessRegistration3Struct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessRegistration3Struct &&
        phone == other.phone &&
        websiteUrl == other.websiteUrl &&
        businessEmail == other.businessEmail &&
        instagramHandle == other.instagramHandle &&
        xHandle == other.xHandle &&
        fbHandle == other.fbHandle;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [phone, websiteUrl, businessEmail, instagramHandle, xHandle, fbHandle]);
}

BusinessRegistration3Struct createBusinessRegistration3Struct({
  int? phone,
  String? websiteUrl,
  String? businessEmail,
  String? instagramHandle,
  String? xHandle,
  String? fbHandle,
}) =>
    BusinessRegistration3Struct(
      phone: phone,
      websiteUrl: websiteUrl,
      businessEmail: businessEmail,
      instagramHandle: instagramHandle,
      xHandle: xHandle,
      fbHandle: fbHandle,
    );
