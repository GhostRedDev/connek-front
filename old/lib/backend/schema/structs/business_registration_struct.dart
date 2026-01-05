// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessRegistrationStruct extends BaseStruct {
  BusinessRegistrationStruct({
    CompanyTypes? step1CompanyType,
    BusinessRegistration2Struct? step2BusinessInformation,
    BusinessRegistration3Struct? step3BusinessContact,
    AddedServiceStruct? step4FirstService,
    DepositDataStruct? step6Verification,
    BusinessFinStruct? step7Deposit,
  })  : _step1CompanyType = step1CompanyType,
        _step2BusinessInformation = step2BusinessInformation,
        _step3BusinessContact = step3BusinessContact,
        _step4FirstService = step4FirstService,
        _step6Verification = step6Verification,
        _step7Deposit = step7Deposit;

  // "step1_CompanyType" field.
  CompanyTypes? _step1CompanyType;
  CompanyTypes? get step1CompanyType => _step1CompanyType;
  set step1CompanyType(CompanyTypes? val) => _step1CompanyType = val;

  bool hasStep1CompanyType() => _step1CompanyType != null;

  // "step2_BusinessInformation" field.
  BusinessRegistration2Struct? _step2BusinessInformation;
  BusinessRegistration2Struct get step2BusinessInformation =>
      _step2BusinessInformation ?? BusinessRegistration2Struct();
  set step2BusinessInformation(BusinessRegistration2Struct? val) =>
      _step2BusinessInformation = val;

  void updateStep2BusinessInformation(
      Function(BusinessRegistration2Struct) updateFn) {
    updateFn(_step2BusinessInformation ??= BusinessRegistration2Struct());
  }

  bool hasStep2BusinessInformation() => _step2BusinessInformation != null;

  // "step3_BusinessContact" field.
  BusinessRegistration3Struct? _step3BusinessContact;
  BusinessRegistration3Struct get step3BusinessContact =>
      _step3BusinessContact ?? BusinessRegistration3Struct();
  set step3BusinessContact(BusinessRegistration3Struct? val) =>
      _step3BusinessContact = val;

  void updateStep3BusinessContact(
      Function(BusinessRegistration3Struct) updateFn) {
    updateFn(_step3BusinessContact ??= BusinessRegistration3Struct());
  }

  bool hasStep3BusinessContact() => _step3BusinessContact != null;

  // "step4_FirstService" field.
  AddedServiceStruct? _step4FirstService;
  AddedServiceStruct get step4FirstService =>
      _step4FirstService ?? AddedServiceStruct();
  set step4FirstService(AddedServiceStruct? val) => _step4FirstService = val;

  void updateStep4FirstService(Function(AddedServiceStruct) updateFn) {
    updateFn(_step4FirstService ??= AddedServiceStruct());
  }

  bool hasStep4FirstService() => _step4FirstService != null;

  // "step6_Verification" field.
  DepositDataStruct? _step6Verification;
  DepositDataStruct get step6Verification =>
      _step6Verification ?? DepositDataStruct();
  set step6Verification(DepositDataStruct? val) => _step6Verification = val;

  void updateStep6Verification(Function(DepositDataStruct) updateFn) {
    updateFn(_step6Verification ??= DepositDataStruct());
  }

  bool hasStep6Verification() => _step6Verification != null;

  // "step7_Deposit" field.
  BusinessFinStruct? _step7Deposit;
  BusinessFinStruct get step7Deposit => _step7Deposit ?? BusinessFinStruct();
  set step7Deposit(BusinessFinStruct? val) => _step7Deposit = val;

  void updateStep7Deposit(Function(BusinessFinStruct) updateFn) {
    updateFn(_step7Deposit ??= BusinessFinStruct());
  }

  bool hasStep7Deposit() => _step7Deposit != null;

  static BusinessRegistrationStruct fromMap(Map<String, dynamic> data) =>
      BusinessRegistrationStruct(
        step1CompanyType: data['step1_CompanyType'] is CompanyTypes
            ? data['step1_CompanyType']
            : deserializeEnum<CompanyTypes>(data['step1_CompanyType']),
        step2BusinessInformation:
            data['step2_BusinessInformation'] is BusinessRegistration2Struct
                ? data['step2_BusinessInformation']
                : BusinessRegistration2Struct.maybeFromMap(
                    data['step2_BusinessInformation']),
        step3BusinessContact:
            data['step3_BusinessContact'] is BusinessRegistration3Struct
                ? data['step3_BusinessContact']
                : BusinessRegistration3Struct.maybeFromMap(
                    data['step3_BusinessContact']),
        step4FirstService: data['step4_FirstService'] is AddedServiceStruct
            ? data['step4_FirstService']
            : AddedServiceStruct.maybeFromMap(data['step4_FirstService']),
        step6Verification: data['step6_Verification'] is DepositDataStruct
            ? data['step6_Verification']
            : DepositDataStruct.maybeFromMap(data['step6_Verification']),
        step7Deposit: data['step7_Deposit'] is BusinessFinStruct
            ? data['step7_Deposit']
            : BusinessFinStruct.maybeFromMap(data['step7_Deposit']),
      );

  static BusinessRegistrationStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessRegistrationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'step1_CompanyType': _step1CompanyType?.serialize(),
        'step2_BusinessInformation': _step2BusinessInformation?.toMap(),
        'step3_BusinessContact': _step3BusinessContact?.toMap(),
        'step4_FirstService': _step4FirstService?.toMap(),
        'step6_Verification': _step6Verification?.toMap(),
        'step7_Deposit': _step7Deposit?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'step1_CompanyType': serializeParam(
          _step1CompanyType,
          ParamType.Enum,
        ),
        'step2_BusinessInformation': serializeParam(
          _step2BusinessInformation,
          ParamType.DataStruct,
        ),
        'step3_BusinessContact': serializeParam(
          _step3BusinessContact,
          ParamType.DataStruct,
        ),
        'step4_FirstService': serializeParam(
          _step4FirstService,
          ParamType.DataStruct,
        ),
        'step6_Verification': serializeParam(
          _step6Verification,
          ParamType.DataStruct,
        ),
        'step7_Deposit': serializeParam(
          _step7Deposit,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static BusinessRegistrationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessRegistrationStruct(
        step1CompanyType: deserializeParam<CompanyTypes>(
          data['step1_CompanyType'],
          ParamType.Enum,
          false,
        ),
        step2BusinessInformation: deserializeStructParam(
          data['step2_BusinessInformation'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessRegistration2Struct.fromSerializableMap,
        ),
        step3BusinessContact: deserializeStructParam(
          data['step3_BusinessContact'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessRegistration3Struct.fromSerializableMap,
        ),
        step4FirstService: deserializeStructParam(
          data['step4_FirstService'],
          ParamType.DataStruct,
          false,
          structBuilder: AddedServiceStruct.fromSerializableMap,
        ),
        step6Verification: deserializeStructParam(
          data['step6_Verification'],
          ParamType.DataStruct,
          false,
          structBuilder: DepositDataStruct.fromSerializableMap,
        ),
        step7Deposit: deserializeStructParam(
          data['step7_Deposit'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessFinStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'BusinessRegistrationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessRegistrationStruct &&
        step1CompanyType == other.step1CompanyType &&
        step2BusinessInformation == other.step2BusinessInformation &&
        step3BusinessContact == other.step3BusinessContact &&
        step4FirstService == other.step4FirstService &&
        step6Verification == other.step6Verification &&
        step7Deposit == other.step7Deposit;
  }

  @override
  int get hashCode => const ListEquality().hash([
        step1CompanyType,
        step2BusinessInformation,
        step3BusinessContact,
        step4FirstService,
        step6Verification,
        step7Deposit
      ]);
}

BusinessRegistrationStruct createBusinessRegistrationStruct({
  CompanyTypes? step1CompanyType,
  BusinessRegistration2Struct? step2BusinessInformation,
  BusinessRegistration3Struct? step3BusinessContact,
  AddedServiceStruct? step4FirstService,
  DepositDataStruct? step6Verification,
  BusinessFinStruct? step7Deposit,
}) =>
    BusinessRegistrationStruct(
      step1CompanyType: step1CompanyType,
      step2BusinessInformation:
          step2BusinessInformation ?? BusinessRegistration2Struct(),
      step3BusinessContact:
          step3BusinessContact ?? BusinessRegistration3Struct(),
      step4FirstService: step4FirstService ?? AddedServiceStruct(),
      step6Verification: step6Verification ?? DepositDataStruct(),
      step7Deposit: step7Deposit ?? BusinessFinStruct(),
    );
