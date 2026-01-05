import '/components/client_bookings_widget.dart';
import '/components/client_bookmarks_widget.dart';
import '/components/client_requests_widget.dart';
import '/components/client_wallet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/client_menu/client_menu_widget.dart';
import 'client_page_widget.dart' show ClientPageWidget;
import 'package:flutter/material.dart';

class ClientPageModel extends FlutterFlowModel<ClientPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ClientBookmarks component.
  late ClientBookmarksModel clientBookmarksModel;
  // Model for ClientBookings component.
  late ClientBookingsModel clientBookingsModel;
  // Model for ClientRequests component.
  late ClientRequestsModel clientRequestsModel;
  // Model for ClientWallet component.
  late ClientWalletModel clientWalletModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for ClientMenu component.
  late ClientMenuModel clientMenuModel;

  @override
  void initState(BuildContext context) {
    clientBookmarksModel = createModel(context, () => ClientBookmarksModel());
    clientBookingsModel = createModel(context, () => ClientBookingsModel());
    clientRequestsModel = createModel(context, () => ClientRequestsModel());
    clientWalletModel = createModel(context, () => ClientWalletModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    clientMenuModel = createModel(context, () => ClientMenuModel());
  }

  @override
  void dispose() {
    clientBookmarksModel.dispose();
    clientBookingsModel.dispose();
    clientRequestsModel.dispose();
    clientWalletModel.dispose();
    mobileNavBar2Model.dispose();
    mobileAppBarModel.dispose();
    clientMenuModel.dispose();
  }
}
