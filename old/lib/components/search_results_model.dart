import '/backend/schema/enums/enums.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/search_bar_widget.dart';
import '/components/search_result_business_card_widget.dart';
import '/components/search_result_service_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_results_widget.dart' show SearchResultsWidget;
import 'package:flutter/material.dart';

class SearchResultsModel extends FlutterFlowModel<SearchResultsWidget> {
  ///  Local state fields for this component.

  SearchResultTypes? filter = SearchResultTypes.business;

  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for SearchBar component.
  late SearchBarModel searchBarModel;
  // Models for SearchResultBusinessCard dynamic component.
  late FlutterFlowDynamicModels<SearchResultBusinessCardModel>
      searchResultBusinessCardModels;
  // Models for SearchResultServiceCard dynamic component.
  late FlutterFlowDynamicModels<SearchResultServiceCardModel>
      searchResultServiceCardModels;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    searchBarModel = createModel(context, () => SearchBarModel());
    searchResultBusinessCardModels =
        FlutterFlowDynamicModels(() => SearchResultBusinessCardModel());
    searchResultServiceCardModels =
        FlutterFlowDynamicModels(() => SearchResultServiceCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    searchBarModel.dispose();
    searchResultBusinessCardModels.dispose();
    searchResultServiceCardModels.dispose();
    emptySpaceModel.dispose();
  }
}
