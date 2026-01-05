import '/flutter_flow/flutter_flow_util.dart';
import '/m6_auth/sign_up_form/sign_up_form_widget.dart';
import 'ask_for_register_dialog_widget.dart' show AskForRegisterDialogWidget;
import 'package:flutter/material.dart';

class AskForRegisterDialogModel
    extends FlutterFlowModel<AskForRegisterDialogWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SignUpForm component.
  late SignUpFormModel signUpFormModel;

  @override
  void initState(BuildContext context) {
    signUpFormModel = createModel(context, () => SignUpFormModel());
  }

  @override
  void dispose() {
    signUpFormModel.dispose();
  }
}
