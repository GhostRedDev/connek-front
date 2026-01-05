import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/index.dart';
import 'create_business8_widget.dart' show CreateBusiness8Widget;
import 'package:flutter/material.dart';

class CreateBusiness8Model extends FlutterFlowModel<CreateBusiness8Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    mobileAppBarModel.dispose();
    mobileNavBarModel.dispose();
  }
}
