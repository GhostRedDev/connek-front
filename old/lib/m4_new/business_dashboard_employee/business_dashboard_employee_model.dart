import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/business_dashboard_menu2/business_dashboard_menu2_widget.dart';
import '/m4_new/components/business_dashboard_menu/business_dashboard_menu_widget.dart';
import '/m4_new/components/employee_manage/employee_manage_widget.dart';
import '/m4_new/components/footer/footer_widget.dart';
import '/m4_new/components/side_bar_desktop/side_bar_desktop_widget.dart';
import '/m_ilestone4/business_dashboard_welcome/business_dashboard_welcome_widget.dart';
import 'business_dashboard_employee_widget.dart'
    show BusinessDashboardEmployeeWidget;
import 'package:flutter/material.dart';

class BusinessDashboardEmployeeModel
    extends FlutterFlowModel<BusinessDashboardEmployeeWidget> {
  ///  Local state fields for this page.

  String pageSelected = 'overview';

  String leadsFilter = 'all';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in BusinessDashboardEmployee widget.
  List<EmployeesRow>? employeesData;
  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarDesktop component.
  late SideBarDesktopModel sideBarDesktopModel;
  // Model for BusinessDashboardMenu component.
  late BusinessDashboardMenuModel businessDashboardMenuModel;
  // Model for BusinessDashboardWelcome component.
  late BusinessDashboardWelcomeModel businessDashboardWelcomeModel;
  // Model for EmployeeManage component.
  late EmployeeManageModel employeeManageModel;
  // Model for footer component.
  late FooterModel footerModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for BusinessDashboardMenu2 component.
  late BusinessDashboardMenu2Model businessDashboardMenu2Model;
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
    employeeManageModel = createModel(context, () => EmployeeManageModel());
    footerModel = createModel(context, () => FooterModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    businessDashboardMenu2Model =
        createModel(context, () => BusinessDashboardMenu2Model());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarDesktopModel.dispose();
    businessDashboardMenuModel.dispose();
    businessDashboardWelcomeModel.dispose();
    employeeManageModel.dispose();
    footerModel.dispose();
    mobileAppBarModel.dispose();
    businessDashboardMenu2Model.dispose();
    mobileNavBarModel.dispose();
  }
}
