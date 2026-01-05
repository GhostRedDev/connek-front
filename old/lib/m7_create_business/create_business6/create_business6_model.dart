import '/backend/api_requests/api_calls.dart';
import '/components/back_button_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_business6_widget.dart' show CreateBusiness6Widget;
import 'package:flutter/material.dart';

class CreateBusiness6Model extends FlutterFlowModel<CreateBusiness6Widget> {
  ///  Local state fields for this page.

  bool checkedTOS = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for TransitField.
  late TextFieldCompModel transitFieldModel;
  // Model for InstField.
  late TextFieldCompModel instFieldModel;
  // Model for AccountField.
  late TextFieldCompModel accountFieldModel;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Backend Call - API (Create Business)] action in Button widget.
  ApiCallResponse? createdBusiness;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    transitFieldModel = createModel(context, () => TextFieldCompModel());
    instFieldModel = createModel(context, () => TextFieldCompModel());
    accountFieldModel = createModel(context, () => TextFieldCompModel());
    transitFieldModel.textFieldTextControllerValidator =
        _formTextFieldValidator1;
    instFieldModel.textFieldTextControllerValidator = _formTextFieldValidator2;
    accountFieldModel.textFieldTextControllerValidator =
        _formTextFieldValidator3;
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    transitFieldModel.dispose();
    instFieldModel.dispose();
    accountFieldModel.dispose();
  }

  /// Additional helper methods.

  String? _formTextFieldValidator1(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'initialValue is required';
    }

    if (val.length < 5) {
      return 'Transit number must be 5 digits long.';
    }
    if (val.length > 5) {
      return 'Transit number must be 5 digits long.';
    }
    if (!RegExp('^\\d{5}\$').hasMatch(val)) {
      return 'Transit number must be 5 digits long.';
    }
    return null;
  }

  String? _formTextFieldValidator2(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'initialValue is required';
    }

    if (val.length < 3) {
      return 'Transit number must be 3 digits long.';
    }
    if (val.length > 3) {
      return 'Transit number must be 3 digits long.';
    }
    if (!RegExp('^\\d{3}\$').hasMatch(val)) {
      return 'Institution number must be 3 digits long.';
    }
    return null;
  }

  String? _formTextFieldValidator3(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'initialValue is required';
    }

    if (!RegExp('^\\d{6,12}\$').hasMatch(val)) {
      return 'Account number must be between 6 and 12 digits.';
    }
    return null;
  }
}
