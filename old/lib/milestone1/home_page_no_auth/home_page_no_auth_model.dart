import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/no_auth_bar/no_auth_bar_widget.dart';
import '/milestone1/home_page_bottom_information/home_page_bottom_information_widget.dart';
import '/milestone1/home_search/home_search_widget.dart';
import 'home_page_no_auth_widget.dart' show HomePageNoAuthWidget;
import 'package:flutter/material.dart';

class HomePageNoAuthModel extends FlutterFlowModel<HomePageNoAuthWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NoAuthBar component.
  late NoAuthBarModel noAuthBarModel;
  // Model for HomeSearch component.
  late HomeSearchModel homeSearchModel;
  // Model for HomePageBottomInformation component.
  late HomePageBottomInformationModel homePageBottomInformationModel;

  @override
  void initState(BuildContext context) {
    noAuthBarModel = createModel(context, () => NoAuthBarModel());
    homeSearchModel = createModel(context, () => HomeSearchModel());
    homePageBottomInformationModel =
        createModel(context, () => HomePageBottomInformationModel());
  }

  @override
  void dispose() {
    noAuthBarModel.dispose();
    homeSearchModel.dispose();
    homePageBottomInformationModel.dispose();
  }
}
