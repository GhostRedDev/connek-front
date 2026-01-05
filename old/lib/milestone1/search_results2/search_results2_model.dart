import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/milestone1/components/search_business_result2/search_business_result2_widget.dart';
import '/milestone1/components/search_services_result2/search_services_result2_widget.dart';
import 'search_results2_widget.dart' show SearchResults2Widget;
import 'package:flutter/material.dart';

class SearchResults2Model extends FlutterFlowModel<SearchResults2Widget> {
  ///  Local state fields for this page.

  SearchResultTypes? filter = SearchResultTypes.business;

  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for SearchBusinessResult2 dynamic component.
  late FlutterFlowDynamicModels<SearchBusinessResult2Model>
      searchBusinessResult2Models;
  // Models for SearchServicesResult2 dynamic component.
  late FlutterFlowDynamicModels<SearchServicesResult2Model>
      searchServicesResult2Models;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    searchBusinessResult2Models =
        FlutterFlowDynamicModels(() => SearchBusinessResult2Model());
    searchServicesResult2Models =
        FlutterFlowDynamicModels(() => SearchServicesResult2Model());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    searchBusinessResult2Models.dispose();
    searchServicesResult2Models.dispose();
    mobileNavBarModel.dispose();
  }
}
