import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_page_new_widget.dart' show LoginPageNewWidget;
import 'package:flutter/material.dart';

class LoginPageNewModel extends FlutterFlowModel<LoginPageNewWidget> {
  ///  Local state fields for this page.

  bool remember = false;

  ///  State fields for stateful widgets in this page.

  // Model for emailField.
  late TextFieldCompModel emailFieldModel;
  // State field(s) for passwordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    emailFieldModel = createModel(context, () => TextFieldCompModel());
    passwordFieldVisibility = false;
  }

  @override
  void dispose() {
    emailFieldModel.dispose();
    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();
  }
}
