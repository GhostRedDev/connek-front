import '/components/business_profile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/business_profile_profile/business_profile_profile_widget.dart';
import '/m10_profile/business_profile_settings/business_profile_settings_widget.dart';
import '/m10_profile/client_profile_profile/client_profile_profile_widget.dart';
import '/m10_profile/client_profile_settings/client_profile_settings_widget.dart';
import '/m10_profile/profile_media/profile_media_widget.dart';
import '/m10_profile/profile_menu/profile_menu_widget.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for BusinessProfileProfile component.
  late BusinessProfileProfileModel businessProfileProfileModel;
  // Model for BusinessProfile component.
  late BusinessProfileModel businessProfileModel;
  // Model for ProfileMedia component.
  late ProfileMediaModel profileMediaModel;
  // Model for ClientProfileProfile component.
  late ClientProfileProfileModel clientProfileProfileModel;
  // Model for BusinessProfileSettings component.
  late BusinessProfileSettingsModel businessProfileSettingsModel;
  // Model for ClientProfileSettings component.
  late ClientProfileSettingsModel clientProfileSettingsModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for ProfileMenu component.
  late ProfileMenuModel profileMenuModel;

  @override
  void initState(BuildContext context) {
    businessProfileProfileModel =
        createModel(context, () => BusinessProfileProfileModel());
    businessProfileModel = createModel(context, () => BusinessProfileModel());
    profileMediaModel = createModel(context, () => ProfileMediaModel());
    clientProfileProfileModel =
        createModel(context, () => ClientProfileProfileModel());
    businessProfileSettingsModel =
        createModel(context, () => BusinessProfileSettingsModel());
    clientProfileSettingsModel =
        createModel(context, () => ClientProfileSettingsModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    profileMenuModel = createModel(context, () => ProfileMenuModel());
  }

  @override
  void dispose() {
    businessProfileProfileModel.dispose();
    businessProfileModel.dispose();
    profileMediaModel.dispose();
    clientProfileProfileModel.dispose();
    businessProfileSettingsModel.dispose();
    clientProfileSettingsModel.dispose();
    mobileNavBar2Model.dispose();
    mobileAppBarModel.dispose();
    profileMenuModel.dispose();
  }
}
