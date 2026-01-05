import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'forgot_password_widget.dart' show ForgotPasswordWidget;
import 'package:flutter/material.dart';

class ForgotPasswordModel extends FlutterFlowModel<ForgotPasswordWidget> {
  ///  Local state fields for this page.

  bool remember = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for emailField.
  late TextFieldCompModel emailFieldModel;

  @override
  void initState(BuildContext context) {
    emailFieldModel = createModel(context, () => TextFieldCompModel());
    emailFieldModel.textFieldTextControllerValidator = _formTextFieldValidator;
  }

  @override
  void dispose() {
    emailFieldModel.dispose();
  }

  /// Additional helper methods.

  String? _formTextFieldValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Email is required';
    }
    return null;
  }
}
