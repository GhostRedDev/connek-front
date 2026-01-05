import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/milestone1/components/search_result_service/search_result_service_widget.dart';
import '/index.dart';
import 'search_results_page_widget.dart' show SearchResultsPageWidget;
import 'package:flutter/material.dart';

class SearchResultsPageModel extends FlutterFlowModel<SearchResultsPageWidget> {
  ///  Local state fields for this page.
  /// Show businesses or services?
  SearchResultTypes? filter = SearchResultTypes.service;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for SearchResultService dynamic component.
  late FlutterFlowDynamicModels<SearchResultServiceModel>
      searchResultServiceModels;

  @override
  void initState(BuildContext context) {
    searchResultServiceModels =
        FlutterFlowDynamicModels(() => SearchResultServiceModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    searchResultServiceModels.dispose();
  }
}
