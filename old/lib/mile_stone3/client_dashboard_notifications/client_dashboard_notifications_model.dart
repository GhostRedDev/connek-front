import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/business_draft/business_draft_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import '/mile_stone3/components3/social_client/social_client_widget.dart';
import '/mile_stone3/customer_dashboard_menu2/customer_dashboard_menu2_widget.dart';
import 'client_dashboard_notifications_widget.dart'
    show ClientDashboardNotificationsWidget;
import 'package:flutter/material.dart';

class ClientDashboardNotificationsModel
    extends FlutterFlowModel<ClientDashboardNotificationsWidget> {
  ///  Local state fields for this page.

  String leadsFilter = 'all';

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarClientDashboard component.
  late SideBarClientDashboardModel sideBarClientDashboardModel;
  // Model for SocialClient component.
  late SocialClientModel socialClientModel1;
  // Model for BusinessDraft component.
  late BusinessDraftModel businessDraftModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for CustomerDashboardMenu2 component.
  late CustomerDashboardMenu2Model customerDashboardMenu2Model;
  // Model for SocialClient component.
  late SocialClientModel socialClientModel2;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarClientDashboardModel =
        createModel(context, () => SideBarClientDashboardModel());
    socialClientModel1 = createModel(context, () => SocialClientModel());
    businessDraftModel = createModel(context, () => BusinessDraftModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    customerDashboardMenu2Model =
        createModel(context, () => CustomerDashboardMenu2Model());
    socialClientModel2 = createModel(context, () => SocialClientModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarClientDashboardModel.dispose();
    socialClientModel1.dispose();
    businessDraftModel.dispose();
    mobileAppBarModel.dispose();
    customerDashboardMenu2Model.dispose();
    socialClientModel2.dispose();
    mobileNavBarModel.dispose();
  }
}
