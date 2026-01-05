import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/office_train_header_widget.dart';
import '/components/text_field_comp2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'office_train_greg_widget.dart' show OfficeTrainGregWidget;
import 'package:flutter/material.dart';

class OfficeTrainGregModel extends FlutterFlowModel<OfficeTrainGregWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for OfficeTrainHeader component.
  late OfficeTrainHeaderModel officeTrainHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for cancellationPolicyField.
  late TextFieldComp2Model cancellationPolicyFieldModel;
  // State field(s) for switchMotive widget.
  bool? switchMotiveValue1;
  // State field(s) for switchMotive widget.
  bool? switchMotiveValue2;
  // Model for escalationField.
  late TextFieldComp2Model escalationFieldModel;
  // State field(s) for paymentMethodsCheckbox widget.
  FormFieldController<List<String>>? paymentMethodsCheckboxValueController;
  List<String>? get paymentMethodsCheckboxValues =>
      paymentMethodsCheckboxValueController?.value;
  set paymentMethodsCheckboxValues(List<String>? v) =>
      paymentMethodsCheckboxValueController?.value = v;

  // Model for paymentPolicyField.
  late TextFieldComp2Model paymentPolicyFieldModel;
  // State field(s) for requirePaymentProofSwitch widget.
  bool? requirePaymentProofSwitchValue;
  // State field(s) for refundPolicyRadio widget.
  FormFieldController<String>? refundPolicyRadioValueController;
  // Model for refundPolicyField.
  late TextFieldComp2Model refundPolicyFieldModel;
  // State field(s) for procedure1 widget.
  FocusNode? procedure1FocusNode;
  TextEditingController? procedure1TextController;
  String? Function(BuildContext, String?)? procedure1TextControllerValidator;
  // State field(s) for procedure2 widget.
  FocusNode? procedure2FocusNode;
  TextEditingController? procedure2TextController;
  String? Function(BuildContext, String?)? procedure2TextControllerValidator;
  // State field(s) for procedure3 widget.
  FocusNode? procedure3FocusNode;
  TextEditingController? procedure3TextController;
  String? Function(BuildContext, String?)? procedure3TextControllerValidator;
  // Model for proceduresDetailsField.
  late TextFieldComp2Model proceduresDetailsFieldModel;
  // Model for postBookingProceduresField.
  late TextFieldComp2Model postBookingProceduresFieldModel;
  // State field(s) for saveInformationField widget.
  FormFieldController<String>? saveInformationFieldValueController;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Model for privacyPolicyField.
  late TextFieldComp2Model privacyPolicyFieldModel;
  // State field(s) for informationNotToShareField widget.
  FocusNode? informationNotToShareFieldFocusNode;
  TextEditingController? informationNotToShareFieldTextController;
  String? Function(BuildContext, String?)?
      informationNotToShareFieldTextControllerValidator;
  // Models for policyNameField.
  late FlutterFlowDynamicModels<TextFieldComp2Model> policyNameFieldModels;
  // Models for policyDescriptionField.
  late FlutterFlowDynamicModels<TextFieldComp2Model>
      policyDescriptionFieldModels;
  // Model for policyNameNewField.
  late TextFieldComp2Model policyNameNewFieldModel;
  // Model for policyDescriptionNewField.
  late TextFieldComp2Model policyDescriptionNewFieldModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    officeTrainHeaderModel =
        createModel(context, () => OfficeTrainHeaderModel());
    cancellationPolicyFieldModel =
        createModel(context, () => TextFieldComp2Model());
    escalationFieldModel = createModel(context, () => TextFieldComp2Model());
    paymentPolicyFieldModel = createModel(context, () => TextFieldComp2Model());
    refundPolicyFieldModel = createModel(context, () => TextFieldComp2Model());
    proceduresDetailsFieldModel =
        createModel(context, () => TextFieldComp2Model());
    postBookingProceduresFieldModel =
        createModel(context, () => TextFieldComp2Model());
    privacyPolicyFieldModel = createModel(context, () => TextFieldComp2Model());
    policyNameFieldModels =
        FlutterFlowDynamicModels(() => TextFieldComp2Model());
    policyDescriptionFieldModels =
        FlutterFlowDynamicModels(() => TextFieldComp2Model());
    policyNameNewFieldModel = createModel(context, () => TextFieldComp2Model());
    policyDescriptionNewFieldModel =
        createModel(context, () => TextFieldComp2Model());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    officeTrainHeaderModel.dispose();
    tabBarController?.dispose();
    cancellationPolicyFieldModel.dispose();
    escalationFieldModel.dispose();
    paymentPolicyFieldModel.dispose();
    refundPolicyFieldModel.dispose();
    procedure1FocusNode?.dispose();
    procedure1TextController?.dispose();

    procedure2FocusNode?.dispose();
    procedure2TextController?.dispose();

    procedure3FocusNode?.dispose();
    procedure3TextController?.dispose();

    proceduresDetailsFieldModel.dispose();
    postBookingProceduresFieldModel.dispose();
    privacyPolicyFieldModel.dispose();
    informationNotToShareFieldFocusNode?.dispose();
    informationNotToShareFieldTextController?.dispose();

    policyNameFieldModels.dispose();
    policyDescriptionFieldModels.dispose();
    policyNameNewFieldModel.dispose();
    policyDescriptionNewFieldModel.dispose();
    emptySpaceModel.dispose();
  }

  /// Additional helper methods.
  String? get refundPolicyRadioValue => refundPolicyRadioValueController?.value;
  String? get saveInformationFieldValue =>
      saveInformationFieldValueController?.value;
}
