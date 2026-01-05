import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import 'chat_user_profile_d_e_p_r_e_widget.dart'
    show ChatUserProfileDEPREWidget;
import 'package:flutter/material.dart';

class ChatUserProfileDEPREModel
    extends FlutterFlowModel<ChatUserProfileDEPREWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    mobileNavBarModel.dispose();
  }
}
