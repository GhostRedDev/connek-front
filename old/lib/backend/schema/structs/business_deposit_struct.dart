// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessDepositStruct extends BaseStruct {
  BusinessDepositStruct({
    String? account,
    String? transit,
    String? institution,
    bool? automaticTransfers,
  })  : _account = account,
        _transit = transit,
        _institution = institution,
        _automaticTransfers = automaticTransfers;

  // "account" field.
  String? _account;
  String get account => _account ?? '';
  set account(String? val) => _account = val;

  bool hasAccount() => _account != null;

  // "transit" field.
  String? _transit;
  String get transit => _transit ?? '';
  set transit(String? val) => _transit = val;

  bool hasTransit() => _transit != null;

  // "institution" field.
  String? _institution;
  String get institution => _institution ?? '';
  set institution(String? val) => _institution = val;

  bool hasInstitution() => _institution != null;

  // "automaticTransfers" field.
  bool? _automaticTransfers;
  bool get automaticTransfers => _automaticTransfers ?? false;
  set automaticTransfers(bool? val) => _automaticTransfers = val;

  bool hasAutomaticTransfers() => _automaticTransfers != null;

  static BusinessDepositStruct fromMap(Map<String, dynamic> data) =>
      BusinessDepositStruct(
        account: data['account'] as String?,
        transit: data['transit'] as String?,
        institution: data['institution'] as String?,
        automaticTransfers: data['automaticTransfers'] as bool?,
      );

  static BusinessDepositStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessDepositStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'account': _account,
        'transit': _transit,
        'institution': _institution,
        'automaticTransfers': _automaticTransfers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'account': serializeParam(
          _account,
          ParamType.String,
        ),
        'transit': serializeParam(
          _transit,
          ParamType.String,
        ),
        'institution': serializeParam(
          _institution,
          ParamType.String,
        ),
        'automaticTransfers': serializeParam(
          _automaticTransfers,
          ParamType.bool,
        ),
      }.withoutNulls;

  static BusinessDepositStruct fromSerializableMap(Map<String, dynamic> data) =>
      BusinessDepositStruct(
        account: deserializeParam(
          data['account'],
          ParamType.String,
          false,
        ),
        transit: deserializeParam(
          data['transit'],
          ParamType.String,
          false,
        ),
        institution: deserializeParam(
          data['institution'],
          ParamType.String,
          false,
        ),
        automaticTransfers: deserializeParam(
          data['automaticTransfers'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'BusinessDepositStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessDepositStruct &&
        account == other.account &&
        transit == other.transit &&
        institution == other.institution &&
        automaticTransfers == other.automaticTransfers;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([account, transit, institution, automaticTransfers]);
}

BusinessDepositStruct createBusinessDepositStruct({
  String? account,
  String? transit,
  String? institution,
  bool? automaticTransfers,
}) =>
    BusinessDepositStruct(
      account: account,
      transit: transit,
      institution: institution,
      automaticTransfers: automaticTransfers,
    );
