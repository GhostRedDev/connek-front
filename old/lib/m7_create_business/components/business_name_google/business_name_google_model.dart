import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_name_google_widget.dart' show BusinessNameGoogleWidget;
import 'package:flutter/material.dart';

class BusinessNameGoogleModel
    extends FlutterFlowModel<BusinessNameGoogleWidget> {
  ///  Local state fields for this component.

  String stage = 'search';

  List<dynamic> results = [];
  void addToResults(dynamic item) => results.add(item);
  void removeFromResults(dynamic item) => results.remove(item);
  void removeAtIndexFromResults(int index) => results.removeAt(index);
  void insertAtIndexInResults(int index, dynamic item) =>
      results.insert(index, item);
  void updateResultsAtIndex(int index, Function(dynamic) updateFn) =>
      results[index] = updateFn(results[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for Googlename widget.
  FocusNode? googlenameFocusNode;
  TextEditingController? googlenameTextController;
  String? Function(BuildContext, String?)? googlenameTextControllerValidator;
  // Stores action output result for [Backend Call - API (Google Places API)] action in Button widget.
  ApiCallResponse? apiResultfcc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    googlenameFocusNode?.dispose();
    googlenameTextController?.dispose();
  }
}
