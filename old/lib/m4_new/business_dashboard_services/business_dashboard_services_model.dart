import '/components/business_services_o_l_d_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/business_dashboard_menu2/business_dashboard_menu2_widget.dart';
import '/m4_new/components/business_dashboard_menu/business_dashboard_menu_widget.dart';
import '/m4_new/components/footer/footer_widget.dart';
import '/m4_new/components/side_bar_desktop/side_bar_desktop_widget.dart';
import '/m_ilestone4/business_dashboard_welcome/business_dashboard_welcome_widget.dart';
import 'business_dashboard_services_widget.dart'
    show BusinessDashboardServicesWidget;
import 'package:flutter/material.dart';

class BusinessDashboardServicesModel
    extends FlutterFlowModel<BusinessDashboardServicesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarDesktop component.
  late SideBarDesktopModel sideBarDesktopModel;
  // Model for BusinessDashboardMenu component.
  late BusinessDashboardMenuModel businessDashboardMenuModel;
  // Model for BusinessDashboardWelcome component.
  late BusinessDashboardWelcomeModel businessDashboardWelcomeModel;
  // Model for footer component.
  late FooterModel footerModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for BusinessDashboardMenu2 component.
  late BusinessDashboardMenu2Model businessDashboardMenu2Model;
  // Model for BusinessServicesOLD component.
  late BusinessServicesOLDModel businessServicesOLDModel;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarDesktopModel = createModel(context, () => SideBarDesktopModel());
    businessDashboardMenuModel =
        createModel(context, () => BusinessDashboardMenuModel());
    businessDashboardWelcomeModel =
        createModel(context, () => BusinessDashboardWelcomeModel());
    footerModel = createModel(context, () => FooterModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    businessDashboardMenu2Model =
        createModel(context, () => BusinessDashboardMenu2Model());
    businessServicesOLDModel =
        createModel(context, () => BusinessServicesOLDModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarDesktopModel.dispose();
    businessDashboardMenuModel.dispose();
    businessDashboardWelcomeModel.dispose();
    footerModel.dispose();
    mobileAppBarModel.dispose();
    businessDashboardMenu2Model.dispose();
    businessServicesOLDModel.dispose();
    mobileNavBarModel.dispose();
  }
}
