import '/flutter_flow/flutter_flow_util.dart';
import '/milestone1/components/search_result_agents/search_result_agents_widget.dart';
import 'search_result_business_widget.dart' show SearchResultBusinessWidget;
import 'package:flutter/material.dart';

class SearchResultBusinessModel
    extends FlutterFlowModel<SearchResultBusinessWidget> {
  ///  Local state fields for this component.

  int maxHeightPx = 450;

  ///  State fields for stateful widgets in this component.

  // Models for SearchResultAgents dynamic component.
  late FlutterFlowDynamicModels<SearchResultAgentsModel>
      searchResultAgentsModels1;

  @override
  void initState(BuildContext context) {
    searchResultAgentsModels1 =
        FlutterFlowDynamicModels(() => SearchResultAgentsModel());
  }

  @override
  void dispose() {
    searchResultAgentsModels1.dispose();
  }
}
