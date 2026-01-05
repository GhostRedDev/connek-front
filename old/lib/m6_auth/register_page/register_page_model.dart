import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/numbers_field_comp_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'register_page_widget.dart' show RegisterPageWidget;
import 'package:flutter/material.dart';

class RegisterPageModel extends FlutterFlowModel<RegisterPageWidget> {
  ///  Local state fields for this page.

  bool remember = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for firstNameField.
  late TextFieldCompModel firstNameFieldModel;
  // Model for lastNameField.
  late TextFieldCompModel lastNameFieldModel;
  // Model for emailField.
  late TextFieldCompModel emailFieldModel;
  // Model for phoneField.
  late NumbersFieldCompModel phoneFieldModel;
  // State field(s) for yearField widget.
  FocusNode? yearFieldFocusNode;
  TextEditingController? yearFieldTextController;
  String? Function(BuildContext, String?)? yearFieldTextControllerValidator;
  // State field(s) for monthField widget.
  FocusNode? monthFieldFocusNode;
  TextEditingController? monthFieldTextController;
  String? Function(BuildContext, String?)? monthFieldTextControllerValidator;
  // State field(s) for dayField widget.
  FocusNode? dayFieldFocusNode;
  TextEditingController? dayFieldTextController;
  String? Function(BuildContext, String?)? dayFieldTextControllerValidator;
  // State field(s) for passwordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;
  String? _passwordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }

    if (val.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}\$')
        .hasMatch(val)) {
      return 'Must include at least one uppercase letter, one lowercase letter, one number, and one special character.';
    }
    return null;
  }

  // State field(s) for confirmPasswordField widget.
  FocusNode? confirmPasswordFieldFocusNode;
  TextEditingController? confirmPasswordFieldTextController;
  late bool confirmPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordFieldTextControllerValidator;
  String? _confirmPasswordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Confirm password is required';
    }

    if (val.length < 10) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}\$')
        .hasMatch(val)) {
      return 'Must include at least one uppercase letter, one lowercase letter, one number, and one special character.';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in ButtonMbile widget.
  bool? formValidate;
  // Stores action output result for [Backend Call - API (Create Stripe Customer Connek)] action in ButtonMbile widget.
  ApiCallResponse? newStripeCustomer;
  // Stores action output result for [Backend Call - Insert Row] action in ButtonMbile widget.
  ClientRow? newClient;

  @override
  void initState(BuildContext context) {
    firstNameFieldModel = createModel(context, () => TextFieldCompModel());
    lastNameFieldModel = createModel(context, () => TextFieldCompModel());
    emailFieldModel = createModel(context, () => TextFieldCompModel());
    phoneFieldModel = createModel(context, () => NumbersFieldCompModel());
    passwordFieldVisibility = false;
    passwordFieldTextControllerValidator =
        _passwordFieldTextControllerValidator;
    confirmPasswordFieldVisibility = false;
    confirmPasswordFieldTextControllerValidator =
        _confirmPasswordFieldTextControllerValidator;
    firstNameFieldModel.textFieldTextControllerValidator =
        _formTextFieldValidator1;
    lastNameFieldModel.textFieldTextControllerValidator =
        _formTextFieldValidator2;
    emailFieldModel.textFieldTextControllerValidator = _formTextFieldValidator3;
    phoneFieldModel.textFieldTextControllerValidator = _formTextFieldValidator4;
  }

  @override
  void dispose() {
    firstNameFieldModel.dispose();
    lastNameFieldModel.dispose();
    emailFieldModel.dispose();
    phoneFieldModel.dispose();
    yearFieldFocusNode?.dispose();
    yearFieldTextController?.dispose();

    monthFieldFocusNode?.dispose();
    monthFieldTextController?.dispose();

    dayFieldFocusNode?.dispose();
    dayFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();

    confirmPasswordFieldFocusNode?.dispose();
    confirmPasswordFieldTextController?.dispose();
  }

  /// Additional helper methods.

  String? _formTextFieldValidator1(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Your first name is required';
    }

    if (val.isEmpty) {
      return 'Please enter a valid name.';
    }

    return null;
  }

  String? _formTextFieldValidator2(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Your last name is required';
    }

    if (val.isEmpty) {
      return 'Please enter a valid name.';
    }

    return null;
  }

  String? _formTextFieldValidator3(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? _formTextFieldValidator4(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Phone is required';
    }

    if (val.length < 10) {
      return 'Your number must have at least 10 numbers.';
    }

    return null;
  }
}
