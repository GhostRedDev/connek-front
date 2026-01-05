import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/milestone1/home_search/home_search_widget.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBa.
  late MobileAppBarModel mobileAppBaModel;
  // Model for HomeSearchh.
  late HomeSearchModel homeSearchhModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;

  @override
  void initState(BuildContext context) {
    mobileAppBaModel = createModel(context, () => MobileAppBarModel());
    homeSearchhModel = createModel(context, () => HomeSearchModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
  }

  @override
  void dispose() {
    mobileAppBaModel.dispose();
    homeSearchhModel.dispose();
    mobileNavBar2Model.dispose();
  }
}
