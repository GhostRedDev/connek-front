// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessFinStruct extends BaseStruct {
  BusinessFinStruct({
    String? accountNumber,
    String? institutionNumber,
    String? transitNumber,
  })  : _accountNumber = accountNumber,
        _institutionNumber = institutionNumber,
        _transitNumber = transitNumber;

  // "accountNumber" field.
  String? _accountNumber;
  String get accountNumber => _accountNumber ?? '';
  set accountNumber(String? val) => _accountNumber = val;

  bool hasAccountNumber() => _accountNumber != null;

  // "institutionNumber" field.
  String? _institutionNumber;
  String get institutionNumber => _institutionNumber ?? '';
  set institutionNumber(String? val) => _institutionNumber = val;

  bool hasInstitutionNumber() => _institutionNumber != null;

  // "transitNumber" field.
  String? _transitNumber;
  String get transitNumber => _transitNumber ?? '';
  set transitNumber(String? val) => _transitNumber = val;

  bool hasTransitNumber() => _transitNumber != null;

  static BusinessFinStruct fromMap(Map<String, dynamic> data) =>
      BusinessFinStruct(
        accountNumber: data['accountNumber'] as String?,
        institutionNumber: data['institutionNumber'] as String?,
        transitNumber: data['transitNumber'] as String?,
      );

  static BusinessFinStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessFinStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'accountNumber': _accountNumber,
        'institutionNumber': _institutionNumber,
        'transitNumber': _transitNumber,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'accountNumber': serializeParam(
          _accountNumber,
          ParamType.String,
        ),
        'institutionNumber': serializeParam(
          _institutionNumber,
          ParamType.String,
        ),
        'transitNumber': serializeParam(
          _transitNumber,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessFinStruct fromSerializableMap(Map<String, dynamic> data) =>
      BusinessFinStruct(
        accountNumber: deserializeParam(
          data['accountNumber'],
          ParamType.String,
          false,
        ),
        institutionNumber: deserializeParam(
          data['institutionNumber'],
          ParamType.String,
          false,
        ),
        transitNumber: deserializeParam(
          data['transitNumber'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessFinStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessFinStruct &&
        accountNumber == other.accountNumber &&
        institutionNumber == other.institutionNumber &&
        transitNumber == other.transitNumber;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([accountNumber, institutionNumber, transitNumber]);
}

BusinessFinStruct createBusinessFinStruct({
  String? accountNumber,
  String? institutionNumber,
  String? transitNumber,
}) =>
    BusinessFinStruct(
      accountNumber: accountNumber,
      institutionNumber: institutionNumber,
      transitNumber: transitNumber,
    );
