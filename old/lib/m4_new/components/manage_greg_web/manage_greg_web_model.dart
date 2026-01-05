import '/flutter_flow/flutter_flow_util.dart';
import 'manage_greg_web_widget.dart' show ManageGregWebWidget;
import 'package:flutter/material.dart';

class ManageGregWebModel extends FlutterFlowModel<ManageGregWebWidget> {
  ///  Local state fields for this component.

  List<String> questions = [];
  void addToQuestions(String item) => questions.add(item);
  void removeFromQuestions(String item) => questions.remove(item);
  void removeAtIndexFromQuestions(int index) => questions.removeAt(index);
  void insertAtIndexInQuestions(int index, String item) =>
      questions.insert(index, item);
  void updateQuestionsAtIndex(int index, Function(String) updateFn) =>
      questions[index] = updateFn(questions[index]);

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

  // Stores action output result for [Validate Form] action in IconButton widget.
  bool? val;

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
