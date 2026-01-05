// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessClientsDataStruct extends BaseStruct {
  BusinessClientsDataStruct({
    int? id,
    DateTime? createdAt,
    int? businessId,
    int? clientId,
    int? forBusinessId,
    String? name,
    int? phone,
  })  : _id = id,
        _createdAt = createdAt,
        _businessId = businessId,
        _clientId = clientId,
        _forBusinessId = forBusinessId,
        _name = name,
        _phone = phone;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "forBusinessId" field.
  int? _forBusinessId;
  int get forBusinessId => _forBusinessId ?? 0;
  set forBusinessId(int? val) => _forBusinessId = val;

  void incrementForBusinessId(int amount) =>
      forBusinessId = forBusinessId + amount;

  bool hasForBusinessId() => _forBusinessId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "phone" field.
  int? _phone;
  int get phone => _phone ?? 0;
  set phone(int? val) => _phone = val;

  void incrementPhone(int amount) => phone = phone + amount;

  bool hasPhone() => _phone != null;

  static BusinessClientsDataStruct fromMap(Map<String, dynamic> data) =>
      BusinessClientsDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        businessId: castToType<int>(data['businessId']),
        clientId: castToType<int>(data['clientId']),
        forBusinessId: castToType<int>(data['forBusinessId']),
        name: data['name'] as String?,
        phone: castToType<int>(data['phone']),
      );

  static BusinessClientsDataStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessClientsDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'businessId': _businessId,
        'clientId': _clientId,
        'forBusinessId': _forBusinessId,
        'name': _name,
        'phone': _phone,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'forBusinessId': serializeParam(
          _forBusinessId,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.int,
        ),
      }.withoutNulls;

  static BusinessClientsDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessClientsDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        forBusinessId: deserializeParam(
          data['forBusinessId'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'BusinessClientsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessClientsDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        businessId == other.businessId &&
        clientId == other.clientId &&
        forBusinessId == other.forBusinessId &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, createdAt, businessId, clientId, forBusinessId, name, phone]);
}

BusinessClientsDataStruct createBusinessClientsDataStruct({
  int? id,
  DateTime? createdAt,
  int? businessId,
  int? clientId,
  int? forBusinessId,
  String? name,
  int? phone,
}) =>
    BusinessClientsDataStruct(
      id: id,
      createdAt: createdAt,
      businessId: businessId,
      clientId: clientId,
      forBusinessId: forBusinessId,
      name: name,
      phone: phone,
    );
