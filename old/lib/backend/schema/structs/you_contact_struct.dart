// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class YouContactStruct extends BaseStruct {
  YouContactStruct({
    int? clientId,
    int? businessId,
    bool? isBusiness,
  })  : _clientId = clientId,
        _businessId = businessId,
        _isBusiness = isBusiness;

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

  static YouContactStruct fromMap(Map<String, dynamic> data) =>
      YouContactStruct(
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        isBusiness: data['isBusiness'] as bool?,
      );

  static YouContactStruct? maybeFromMap(dynamic data) => data is Map
      ? YouContactStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'clientId': _clientId,
        'businessId': _businessId,
        'isBusiness': _isBusiness,
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
      }.withoutNulls;

  static YouContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      YouContactStruct(
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
      );

  @override
  String toString() => 'YouContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is YouContactStruct &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        isBusiness == other.isBusiness;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([clientId, businessId, isBusiness]);
}

YouContactStruct createYouContactStruct({
  int? clientId,
  int? businessId,
  bool? isBusiness,
}) =>
    YouContactStruct(
      clientId: clientId,
      businessId: businessId,
      isBusiness: isBusiness,
    );
