import '/flutter_flow/flutter_flow_util.dart';
import 'edit_text_modal_widget.dart' show EditTextModalWidget;
import 'package:flutter/material.dart';

class EditTextModalModel extends FlutterFlowModel<EditTextModalWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for updated widget.
  FocusNode? updatedFocusNode;
  TextEditingController? updatedTextController;
  String? Function(BuildContext, String?)? updatedTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    updatedFocusNode?.dispose();
    updatedTextController?.dispose();
  }
}
