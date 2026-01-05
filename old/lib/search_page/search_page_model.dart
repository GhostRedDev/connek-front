import '/backend/schema/enums/enums.dart';
import '/components/search_results_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import 'search_page_widget.dart' show SearchPageWidget;
import 'package:flutter/material.dart';

class SearchPageModel extends FlutterFlowModel<SearchPageWidget> {
  ///  Local state fields for this page.

  SearchResultTypes? filter = SearchResultTypes.business;

  ///  State fields for stateful widgets in this page.

  // Model for SearchResults component.
  late SearchResultsModel searchResultsModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;

  @override
  void initState(BuildContext context) {
    searchResultsModel = createModel(context, () => SearchResultsModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
  }

  @override
  void dispose() {
    searchResultsModel.dispose();
    mobileNavBar2Model.dispose();
    mobileAppBarModel.dispose();
  }
}
