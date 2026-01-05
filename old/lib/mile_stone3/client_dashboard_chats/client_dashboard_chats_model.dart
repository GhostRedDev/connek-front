import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import '/mile_stone3/customer_dashboard_menu/customer_dashboard_menu_widget.dart';
import 'client_dashboard_chats_widget.dart' show ClientDashboardChatsWidget;
import 'package:flutter/material.dart';

class ClientDashboardChatsModel
    extends FlutterFlowModel<ClientDashboardChatsWidget> {
  ///  Local state fields for this page.

  String pageSelected = 'overview';

  String filter = 'All';

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarClientDashboard component.
  late SideBarClientDashboardModel sideBarClientDashboardModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered3 = false;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for CustomerDashboardMenu component.
  late CustomerDashboardMenuModel customerDashboardMenuModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered4 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered5 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarClientDashboardModel =
        createModel(context, () => SideBarClientDashboardModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    customerDashboardMenuModel =
        createModel(context, () => CustomerDashboardMenuModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarClientDashboardModel.dispose();
    mobileAppBarModel.dispose();
    customerDashboardMenuModel.dispose();
    mobileNavBarModel.dispose();
  }
}
