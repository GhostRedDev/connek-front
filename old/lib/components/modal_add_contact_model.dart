import '/flutter_flow/flutter_flow_util.dart';
import 'modal_add_contact_widget.dart' show ModalAddContactWidget;
import 'package:flutter/material.dart';

class ModalAddContactModel extends FlutterFlowModel<ModalAddContactWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for nameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldTextController;
  String? Function(BuildContext, String?)? nameFieldTextControllerValidator;
  // State field(s) for phoneField widget.
  FocusNode? phoneFieldFocusNode;
  TextEditingController? phoneFieldTextController;
  String? Function(BuildContext, String?)? phoneFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFieldFocusNode?.dispose();
    nameFieldTextController?.dispose();

    phoneFieldFocusNode?.dispose();
    phoneFieldTextController?.dispose();
  }
}
