import '/components/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_result_google_widget.dart' show SearchResultGoogleWidget;
import 'package:flutter/material.dart';

class SearchResultGoogleModel
    extends FlutterFlowModel<SearchResultGoogleWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SearchBar component.
  late SearchBarModel searchBarModel;

  @override
  void initState(BuildContext context) {
    searchBarModel = createModel(context, () => SearchBarModel());
  }

  @override
  void dispose() {
    searchBarModel.dispose();
  }
}
