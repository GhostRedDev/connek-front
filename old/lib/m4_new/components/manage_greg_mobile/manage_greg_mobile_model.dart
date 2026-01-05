import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'manage_greg_mobile_widget.dart' show ManageGregMobileWidget;
import 'package:flutter/material.dart';

class ManageGregMobileModel extends FlutterFlowModel<ManageGregMobileWidget> {
  ///  Local state fields for this component.

  List<String> formFields = [];
  void addToFormFields(String item) => formFields.add(item);
  void removeFromFormFields(String item) => formFields.remove(item);
  void removeAtIndexFromFormFields(int index) => formFields.removeAt(index);
  void insertAtIndexInFormFields(int index, String item) =>
      formFields.insert(index, item);
  void updateFormFieldsAtIndex(int index, Function(String) updateFn) =>
      formFields[index] = updateFn(formFields[index]);

  List<String> instructions = [];
  void addToInstructions(String item) => instructions.add(item);
  void removeFromInstructions(String item) => instructions.remove(item);
  void removeAtIndexFromInstructions(int index) => instructions.removeAt(index);
  void insertAtIndexInInstructions(int index, String item) =>
      instructions.insert(index, item);
  void updateInstructionsAtIndex(int index, Function(String) updateFn) =>
      instructions[index] = updateFn(instructions[index]);

  ///  State fields for stateful widgets in this component.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for question widget.
  FocusNode? questionFocusNode;
  TextEditingController? questionTextController;
  String? Function(BuildContext, String?)? questionTextControllerValidator;
  String? _questionTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in IconButton widget.
  bool? val1;
  // State field(s) for instruction widget.
  FocusNode? instructionFocusNode;
  TextEditingController? instructionTextController;
  String? Function(BuildContext, String?)? instructionTextControllerValidator;
  String? _instructionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Create Employee)] action in Button widget.
  ApiCallResponse? createChatbotQuery;

  @override
  void initState(BuildContext context) {
    questionTextControllerValidator = _questionTextControllerValidator;
    instructionTextControllerValidator = _instructionTextControllerValidator;
  }

  @override
  void dispose() {
    questionFocusNode?.dispose();
    questionTextController?.dispose();

    instructionFocusNode?.dispose();
    instructionTextController?.dispose();
  }
}
