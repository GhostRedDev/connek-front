import '/flutter_flow/flutter_flow_util.dart';
import 'home_search_widget.dart' show HomeSearchWidget;
import 'package:flutter/material.dart';

class HomeSearchModel extends FlutterFlowModel<HomeSearchWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();
  }
}
