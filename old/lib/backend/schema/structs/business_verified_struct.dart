// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessVerifiedStruct extends BaseStruct {
  BusinessVerifiedStruct({
    String? status,
    bool? missingId,
    bool? missingPoa,
  })  : _status = status,
        _missingId = missingId,
        _missingPoa = missingPoa;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "missingId" field.
  bool? _missingId;
  bool get missingId => _missingId ?? false;
  set missingId(bool? val) => _missingId = val;

  bool hasMissingId() => _missingId != null;

  // "missingPoa" field.
  bool? _missingPoa;
  bool get missingPoa => _missingPoa ?? false;
  set missingPoa(bool? val) => _missingPoa = val;

  bool hasMissingPoa() => _missingPoa != null;

  static BusinessVerifiedStruct fromMap(Map<String, dynamic> data) =>
      BusinessVerifiedStruct(
        status: data['status'] as String?,
        missingId: data['missingId'] as bool?,
        missingPoa: data['missingPoa'] as bool?,
      );

  static BusinessVerifiedStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessVerifiedStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'missingId': _missingId,
        'missingPoa': _missingPoa,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'missingId': serializeParam(
          _missingId,
          ParamType.bool,
        ),
        'missingPoa': serializeParam(
          _missingPoa,
          ParamType.bool,
        ),
      }.withoutNulls;

  static BusinessVerifiedStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessVerifiedStruct(
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        missingId: deserializeParam(
          data['missingId'],
          ParamType.bool,
          false,
        ),
        missingPoa: deserializeParam(
          data['missingPoa'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'BusinessVerifiedStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessVerifiedStruct &&
        status == other.status &&
        missingId == other.missingId &&
        missingPoa == other.missingPoa;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([status, missingId, missingPoa]);
}

BusinessVerifiedStruct createBusinessVerifiedStruct({
  String? status,
  bool? missingId,
  bool? missingPoa,
}) =>
    BusinessVerifiedStruct(
      status: status,
      missingId: missingId,
      missingPoa: missingPoa,
    );
