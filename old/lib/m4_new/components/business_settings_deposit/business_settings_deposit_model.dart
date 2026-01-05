import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_settings_deposit_widget.dart'
    show BusinessSettingsDepositWidget;
import 'package:flutter/material.dart';

class BusinessSettingsDepositModel
    extends FlutterFlowModel<BusinessSettingsDepositWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for accountField widget.
  FocusNode? accountFieldFocusNode;
  TextEditingController? accountFieldTextController;
  String? Function(BuildContext, String?)? accountFieldTextControllerValidator;
  // State field(s) for institutionField widget.
  FocusNode? institutionFieldFocusNode;
  TextEditingController? institutionFieldTextController;
  String? Function(BuildContext, String?)?
      institutionFieldTextControllerValidator;
  // State field(s) for transitField widget.
  FocusNode? transitFieldFocusNode;
  TextEditingController? transitFieldTextController;
  String? Function(BuildContext, String?)? transitFieldTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<BusinessDepositsRow>? updatedBusiness;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    accountFieldFocusNode?.dispose();
    accountFieldTextController?.dispose();

    institutionFieldFocusNode?.dispose();
    institutionFieldTextController?.dispose();

    transitFieldFocusNode?.dispose();
    transitFieldTextController?.dispose();
  }
}
