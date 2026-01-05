import '/components/office_analytics_widget.dart';
import '/components/office_marketplace_widget.dart';
import '/components/office_my_bots_widget.dart';
import '/components/office_overview_widget.dart';
import '/components/office_settings_greg_widget.dart';
import '/components/office_train_greg_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/office_menu/office_menu_widget.dart';
import 'office_page_widget.dart' show OfficePageWidget;
import 'package:flutter/material.dart';

class OfficePageModel extends FlutterFlowModel<OfficePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for OfficeOverview component.
  late OfficeOverviewModel officeOverviewModel;
  // Model for OfficeMyBots component.
  late OfficeMyBotsModel officeMyBotsModel;
  // Model for OfficeMarketplace component.
  late OfficeMarketplaceModel officeMarketplaceModel;
  // Model for OfficeAnalytics component.
  late OfficeAnalyticsModel officeAnalyticsModel;
  // Model for OfficeSettingsGreg component.
  late OfficeSettingsGregModel officeSettingsGregModel;
  // Model for OfficeTrainGreg component.
  late OfficeTrainGregModel officeTrainGregModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for OfficeMenu component.
  late OfficeMenuModel officeMenuModel;

  @override
  void initState(BuildContext context) {
    officeOverviewModel = createModel(context, () => OfficeOverviewModel());
    officeMyBotsModel = createModel(context, () => OfficeMyBotsModel());
    officeMarketplaceModel =
        createModel(context, () => OfficeMarketplaceModel());
    officeAnalyticsModel = createModel(context, () => OfficeAnalyticsModel());
    officeSettingsGregModel =
        createModel(context, () => OfficeSettingsGregModel());
    officeTrainGregModel = createModel(context, () => OfficeTrainGregModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    officeMenuModel = createModel(context, () => OfficeMenuModel());
  }

  @override
  void dispose() {
    officeOverviewModel.dispose();
    officeMyBotsModel.dispose();
    officeMarketplaceModel.dispose();
    officeAnalyticsModel.dispose();
    officeSettingsGregModel.dispose();
    officeTrainGregModel.dispose();
    mobileNavBar2Model.dispose();
    mobileAppBarModel.dispose();
    officeMenuModel.dispose();
  }
}
