// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactStruct extends BaseStruct {
  ContactStruct({
    int? clientId,
    int? businessId,
    bool? isBusiness,
    String? name,
    String? photoId,
  })  : _clientId = clientId,
        _businessId = businessId,
        _isBusiness = isBusiness,
        _name = name,
        _photoId = photoId;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "isBusiness" field.
  bool? _isBusiness;
  bool get isBusiness => _isBusiness ?? false;
  set isBusiness(bool? val) => _isBusiness = val;

  bool hasIsBusiness() => _isBusiness != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "photoId" field.
  String? _photoId;
  String get photoId => _photoId ?? '';
  set photoId(String? val) => _photoId = val;

  bool hasPhotoId() => _photoId != null;

  static ContactStruct fromMap(Map<String, dynamic> data) => ContactStruct(
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        isBusiness: data['isBusiness'] as bool?,
        name: data['name'] as String?,
        photoId: data['photoId'] as String?,
      );

  static ContactStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContactStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'clientId': _clientId,
        'businessId': _businessId,
        'isBusiness': _isBusiness,
        'name': _name,
        'photoId': _photoId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'isBusiness': serializeParam(
          _isBusiness,
          ParamType.bool,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'photoId': serializeParam(
          _photoId,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContactStruct(
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        isBusiness: deserializeParam(
          data['isBusiness'],
          ParamType.bool,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        photoId: deserializeParam(
          data['photoId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContactStruct &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        isBusiness == other.isBusiness &&
        name == other.name &&
        photoId == other.photoId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([clientId, businessId, isBusiness, name, photoId]);
}

ContactStruct createContactStruct({
  int? clientId,
  int? businessId,
  bool? isBusiness,
  String? name,
  String? photoId,
}) =>
    ContactStruct(
      clientId: clientId,
      businessId: businessId,
      isBusiness: isBusiness,
      name: name,
      photoId: photoId,
    );
