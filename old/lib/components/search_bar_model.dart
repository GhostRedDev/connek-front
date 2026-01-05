import '/flutter_flow/flutter_flow_util.dart';
import 'search_bar_widget.dart' show SearchBarWidget;
import 'package:flutter/material.dart';

class SearchBarModel extends FlutterFlowModel<SearchBarWidget> {
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
