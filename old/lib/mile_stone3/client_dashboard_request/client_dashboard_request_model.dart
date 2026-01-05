import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import '/generic/filter_option/filter_option_widget.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/mile_stone3/components3/request_card_mobil/request_card_mobil_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import '/mile_stone3/customer_dashboard_menu2/customer_dashboard_menu2_widget.dart';
import '/index.dart';
import 'client_dashboard_request_widget.dart' show ClientDashboardRequestWidget;
import 'package:flutter/material.dart';

class ClientDashboardRequestModel
    extends FlutterFlowModel<ClientDashboardRequestWidget> {
  ///  Local state fields for this page.

  String leadsFilter = 'all';

  String requestQueryFilter = 'all';

  RequestsFilter? filter = RequestsFilter.all;

  List<ClientRequestStruct> requests = [];
  void addToRequests(ClientRequestStruct item) => requests.add(item);
  void removeFromRequests(ClientRequestStruct item) => requests.remove(item);
  void removeAtIndexFromRequests(int index) => requests.removeAt(index);
  void insertAtIndexInRequests(int index, ClientRequestStruct item) =>
      requests.insert(index, item);
  void updateRequestsAtIndex(
          int index, Function(ClientRequestStruct) updateFn) =>
      requests[index] = updateFn(requests[index]);

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarClientDashboard component.
  late SideBarClientDashboardModel sideBarClientDashboardModel;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel1;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel2;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel3;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel4;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for CustomerDashboardMenu2 component.
  late CustomerDashboardMenu2Model customerDashboardMenu2Model;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel1;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel5;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel6;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel7;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel8;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel9;
  // Models for RequestCardMobil dynamic component.
  late FlutterFlowDynamicModels<RequestCardMobilModel> requestCardMobilModels;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel2;
  // State field(s) for firstField widget.
  FocusNode? firstFieldFocusNode;
  TextEditingController? firstFieldTextController;
  String? Function(BuildContext, String?)? firstFieldTextControllerValidator;
  // State field(s) for lastField widget.
  FocusNode? lastFieldFocusNode;
  TextEditingController? lastFieldTextController;
  String? Function(BuildContext, String?)? lastFieldTextControllerValidator;
  // State field(s) for aboutMeField widget.
  FocusNode? aboutMeFieldFocusNode;
  TextEditingController? aboutMeFieldTextController;
  String? Function(BuildContext, String?)? aboutMeFieldTextControllerValidator;
  // State field(s) for yearMobile widget.
  FocusNode? yearMobileFocusNode;
  TextEditingController? yearMobileTextController;
  String? Function(BuildContext, String?)? yearMobileTextControllerValidator;
  // State field(s) for monthMobile widget.
  FocusNode? monthMobileFocusNode;
  TextEditingController? monthMobileTextController;
  String? Function(BuildContext, String?)? monthMobileTextControllerValidator;
  // State field(s) for dayMobile widget.
  FocusNode? dayMobileFocusNode;
  TextEditingController? dayMobileTextController;
  String? Function(BuildContext, String?)? dayMobileTextControllerValidator;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel3;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel10;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel11;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel12;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel4;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue1;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue2;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue3;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue4;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue5;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarClientDashboardModel =
        createModel(context, () => SideBarClientDashboardModel());
    filterOptionModel1 = createModel(context, () => FilterOptionModel());
    filterOptionModel2 = createModel(context, () => FilterOptionModel());
    filterOptionModel3 = createModel(context, () => FilterOptionModel());
    filterOptionModel4 = createModel(context, () => FilterOptionModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    customerDashboardMenu2Model =
        createModel(context, () => CustomerDashboardMenu2Model());
    contentHeaderModel1 = createModel(context, () => ContentHeaderModel());
    filterOptionModel5 = createModel(context, () => FilterOptionModel());
    filterOptionModel6 = createModel(context, () => FilterOptionModel());
    filterOptionModel7 = createModel(context, () => FilterOptionModel());
    filterOptionModel8 = createModel(context, () => FilterOptionModel());
    filterOptionModel9 = createModel(context, () => FilterOptionModel());
    requestCardMobilModels =
        FlutterFlowDynamicModels(() => RequestCardMobilModel());
    contentHeaderModel2 = createModel(context, () => ContentHeaderModel());
    contentHeaderModel3 = createModel(context, () => ContentHeaderModel());
    filterOptionModel10 = createModel(context, () => FilterOptionModel());
    filterOptionModel11 = createModel(context, () => FilterOptionModel());
    filterOptionModel12 = createModel(context, () => FilterOptionModel());
    contentHeaderModel4 = createModel(context, () => ContentHeaderModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarClientDashboardModel.dispose();
    filterOptionModel1.dispose();
    filterOptionModel2.dispose();
    filterOptionModel3.dispose();
    filterOptionModel4.dispose();
    mobileAppBarModel.dispose();
    customerDashboardMenu2Model.dispose();
    contentHeaderModel1.dispose();
    filterOptionModel5.dispose();
    filterOptionModel6.dispose();
    filterOptionModel7.dispose();
    filterOptionModel8.dispose();
    filterOptionModel9.dispose();
    requestCardMobilModels.dispose();
    contentHeaderModel2.dispose();
    firstFieldFocusNode?.dispose();
    firstFieldTextController?.dispose();

    lastFieldFocusNode?.dispose();
    lastFieldTextController?.dispose();

    aboutMeFieldFocusNode?.dispose();
    aboutMeFieldTextController?.dispose();

    yearMobileFocusNode?.dispose();
    yearMobileTextController?.dispose();

    monthMobileFocusNode?.dispose();
    monthMobileTextController?.dispose();

    dayMobileFocusNode?.dispose();
    dayMobileTextController?.dispose();

    contentHeaderModel3.dispose();
    filterOptionModel10.dispose();
    filterOptionModel11.dispose();
    filterOptionModel12.dispose();
    contentHeaderModel4.dispose();
    mobileNavBar2Model.dispose();
  }
}
