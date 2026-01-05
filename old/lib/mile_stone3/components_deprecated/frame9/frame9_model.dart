import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'frame9_widget.dart' show Frame9Widget;
import 'package:flutter/material.dart';

class Frame9Model extends FlutterFlowModel<Frame9Widget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Normal Search)] action in TextField widget.
  ApiCallResponse? searchAPIoutput;
  // Stores action output result for [Backend Call - API (Normal Search)] action in Button widget.
  ApiCallResponse? searchResultsFromButton;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
