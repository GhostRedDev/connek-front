// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DepositDataStruct extends BaseStruct {
  DepositDataStruct({
    int? transit,
    int? institution,
    int? accountNumber,
  })  : _transit = transit,
        _institution = institution,
        _accountNumber = accountNumber;

  // "transit" field.
  int? _transit;
  int get transit => _transit ?? 0;
  set transit(int? val) => _transit = val;

  void incrementTransit(int amount) => transit = transit + amount;

  bool hasTransit() => _transit != null;

  // "institution" field.
  int? _institution;
  int get institution => _institution ?? 0;
  set institution(int? val) => _institution = val;

  void incrementInstitution(int amount) => institution = institution + amount;

  bool hasInstitution() => _institution != null;

  // "accountNumber" field.
  int? _accountNumber;
  int get accountNumber => _accountNumber ?? 0;
  set accountNumber(int? val) => _accountNumber = val;

  void incrementAccountNumber(int amount) =>
      accountNumber = accountNumber + amount;

  bool hasAccountNumber() => _accountNumber != null;

  static DepositDataStruct fromMap(Map<String, dynamic> data) =>
      DepositDataStruct(
        transit: castToType<int>(data['transit']),
        institution: castToType<int>(data['institution']),
        accountNumber: castToType<int>(data['accountNumber']),
      );

  static DepositDataStruct? maybeFromMap(dynamic data) => data is Map
      ? DepositDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'transit': _transit,
        'institution': _institution,
        'accountNumber': _accountNumber,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'transit': serializeParam(
          _transit,
          ParamType.int,
        ),
        'institution': serializeParam(
          _institution,
          ParamType.int,
        ),
        'accountNumber': serializeParam(
          _accountNumber,
          ParamType.int,
        ),
      }.withoutNulls;

  static DepositDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DepositDataStruct(
        transit: deserializeParam(
          data['transit'],
          ParamType.int,
          false,
        ),
        institution: deserializeParam(
          data['institution'],
          ParamType.int,
          false,
        ),
        accountNumber: deserializeParam(
          data['accountNumber'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'DepositDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DepositDataStruct &&
        transit == other.transit &&
        institution == other.institution &&
        accountNumber == other.accountNumber;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([transit, institution, accountNumber]);
}

DepositDataStruct createDepositDataStruct({
  int? transit,
  int? institution,
  int? accountNumber,
}) =>
    DepositDataStruct(
      transit: transit,
      institution: institution,
      accountNumber: accountNumber,
    );
