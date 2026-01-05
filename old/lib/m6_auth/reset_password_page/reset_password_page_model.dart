import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_password_page_widget.dart' show ResetPasswordPageWidget;
import 'package:flutter/material.dart';

class ResetPasswordPageModel extends FlutterFlowModel<ResetPasswordPageWidget> {
  ///  Local state fields for this page.

  bool remember = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for newPasswordField widget.
  FocusNode? newPasswordFieldFocusNode;
  TextEditingController? newPasswordFieldTextController;
  late bool newPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      newPasswordFieldTextControllerValidator;
  String? _newPasswordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for newPasswordField2 widget.
  FocusNode? newPasswordField2FocusNode;
  TextEditingController? newPasswordField2TextController;
  late bool newPasswordField2Visibility;
  String? Function(BuildContext, String?)?
      newPasswordField2TextControllerValidator;

  @override
  void initState(BuildContext context) {
    newPasswordFieldVisibility = false;
    newPasswordFieldTextControllerValidator =
        _newPasswordFieldTextControllerValidator;
    newPasswordField2Visibility = false;
  }

  @override
  void dispose() {
    newPasswordFieldFocusNode?.dispose();
    newPasswordFieldTextController?.dispose();

    newPasswordField2FocusNode?.dispose();
    newPasswordField2TextController?.dispose();
  }
}
