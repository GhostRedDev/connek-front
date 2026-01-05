import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header_profile/content_header_profile_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import 'settings_page_widget.dart' show SettingsPageWidget;
import 'package:flutter/material.dart';

class SettingsPageModel extends FlutterFlowModel<SettingsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for ContentHeaderProfile component.
  late ContentHeaderProfileModel contentHeaderProfileModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    contentHeaderProfileModel =
        createModel(context, () => ContentHeaderProfileModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    contentHeaderProfileModel.dispose();
    mobileNavBar2Model.dispose();
  }
}
