import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/index.dart';
import 'checkout_success_widget.dart' show CheckoutSuccessWidget;
import 'package:flutter/material.dart';

class CheckoutSuccessModel extends FlutterFlowModel<CheckoutSuccessWidget> {
  ///  Local state fields for this page.

  double currentX = 0.0;

  bool isLocked = true;

  String buttontext = 'Proceed to Payment';

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
