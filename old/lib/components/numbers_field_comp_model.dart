import '/flutter_flow/flutter_flow_util.dart';
import 'numbers_field_comp_widget.dart' show NumbersFieldCompWidget;
import 'package:flutter/material.dart';

class NumbersFieldCompModel extends FlutterFlowModel<NumbersFieldCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for textField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textFieldTextController;
  String? Function(BuildContext, String?)? textFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textFieldTextController?.dispose();
  }
}
