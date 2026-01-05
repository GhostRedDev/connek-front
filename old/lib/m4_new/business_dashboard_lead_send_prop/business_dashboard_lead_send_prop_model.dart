import '/backend/supabase/supabase.dart';
import '/components/calendar_input_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/components/business_dashboard_menu/business_dashboard_menu_widget.dart';
import '/m4_new/components/side_bar_desktop/side_bar_desktop_widget.dart';
import '/m_ilestone4/business_dashboard_welcome/business_dashboard_welcome_widget.dart';
import '/index.dart';
import 'business_dashboard_lead_send_prop_widget.dart'
    show BusinessDashboardLeadSendPropWidget;
import 'package:flutter/material.dart';

class BusinessDashboardLeadSendPropModel
    extends FlutterFlowModel<BusinessDashboardLeadSendPropWidget> {
  ///  Local state fields for this page.

  String pageSelected = 'overview';

  String leadsFilter = 'all';

  int? expiringDay;

  int? expiringMonth;

  int? expiringYear;

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarDesktop component.
  late SideBarDesktopModel sideBarDesktopModel;
  // Model for BusinessDashboardMenu component.
  late BusinessDashboardMenuModel businessDashboardMenuModel;
  // Model for BusinessDashboardWelcome component.
  late BusinessDashboardWelcomeModel businessDashboardWelcomeModel1;
  // State field(s) for descriptionDesktop widget.
  FocusNode? descriptionDesktopFocusNode;
  TextEditingController? descriptionDesktopTextController;
  String? Function(BuildContext, String?)?
      descriptionDesktopTextControllerValidator;
  // State field(s) for PriceDesktop widget.
  FocusNode? priceDesktopFocusNode;
  TextEditingController? priceDesktopTextController;
  String? Function(BuildContext, String?)? priceDesktopTextControllerValidator;
  // State field(s) for expirationDesktop widget.
  FocusNode? expirationDesktopFocusNode;
  TextEditingController? expirationDesktopTextController;
  String? Function(BuildContext, String?)?
      expirationDesktopTextControllerValidator;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for BusinessDashboardWelcome component.
  late BusinessDashboardWelcomeModel businessDashboardWelcomeModel2;
  // State field(s) for descriptionMobile widget.
  FocusNode? descriptionMobileFocusNode;
  TextEditingController? descriptionMobileTextController;
  String? Function(BuildContext, String?)?
      descriptionMobileTextControllerValidator;
  // State field(s) for PriceMobile widget.
  FocusNode? priceMobileFocusNode;
  TextEditingController? priceMobileTextController;
  String? Function(BuildContext, String?)? priceMobileTextControllerValidator;
  // State field(s) for expirationMobile widget.
  FocusNode? expirationMobileFocusNode;
  TextEditingController? expirationMobileTextController;
  String? Function(BuildContext, String?)?
      expirationMobileTextControllerValidator;
  // Model for calendarInput component.
  late CalendarInputModel calendarInputModel;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  QuoteRow? newQuoteQuery;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarDesktopModel = createModel(context, () => SideBarDesktopModel());
    businessDashboardMenuModel =
        createModel(context, () => BusinessDashboardMenuModel());
    businessDashboardWelcomeModel1 =
        createModel(context, () => BusinessDashboardWelcomeModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    businessDashboardWelcomeModel2 =
        createModel(context, () => BusinessDashboardWelcomeModel());
    calendarInputModel = createModel(context, () => CalendarInputModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarDesktopModel.dispose();
    businessDashboardMenuModel.dispose();
    businessDashboardWelcomeModel1.dispose();
    descriptionDesktopFocusNode?.dispose();
    descriptionDesktopTextController?.dispose();

    priceDesktopFocusNode?.dispose();
    priceDesktopTextController?.dispose();

    expirationDesktopFocusNode?.dispose();
    expirationDesktopTextController?.dispose();

    mobileAppBarModel.dispose();
    businessDashboardWelcomeModel2.dispose();
    descriptionMobileFocusNode?.dispose();
    descriptionMobileTextController?.dispose();

    priceMobileFocusNode?.dispose();
    priceMobileTextController?.dispose();

    expirationMobileFocusNode?.dispose();
    expirationMobileTextController?.dispose();

    calendarInputModel.dispose();
    mobileNavBarModel.dispose();
  }
}
