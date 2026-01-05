import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import '/generic/filter_option/filter_option_widget.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import '/mile_stone3/customer_dashboard_menu2/customer_dashboard_menu2_widget.dart';
import '/index.dart';
import 'client_dashboard_wallet_widget.dart' show ClientDashboardWalletWidget;
import 'package:flutter/material.dart';

class ClientDashboardWalletModel
    extends FlutterFlowModel<ClientDashboardWalletWidget> {
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
  // Model for CustomerDashboardMenu2 component.
  late CustomerDashboardMenu2Model customerDashboardMenu2Model;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel1;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel2;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel3;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarClientDashboardModel =
        createModel(context, () => SideBarClientDashboardModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    customerDashboardMenu2Model =
        createModel(context, () => CustomerDashboardMenu2Model());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    filterOptionModel1 = createModel(context, () => FilterOptionModel());
    filterOptionModel2 = createModel(context, () => FilterOptionModel());
    filterOptionModel3 = createModel(context, () => FilterOptionModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarClientDashboardModel.dispose();
    mobileAppBarModel.dispose();
    customerDashboardMenu2Model.dispose();
    contentHeaderModel.dispose();
    filterOptionModel1.dispose();
    filterOptionModel2.dispose();
    filterOptionModel3.dispose();
    mobileNavBarModel.dispose();
  }
}
