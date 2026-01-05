import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'direct_request_dialog_widget.dart' show DirectRequestDialogWidget;
import 'package:flutter/material.dart';

class DirectRequestDialogModel
    extends FlutterFlowModel<DirectRequestDialogWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  RequestsRow? request;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  LeadsRow? lead;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
