import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/components/footer/footer_widget.dart';
import '/m4_new/components/lead_steps_box/lead_steps_box_widget.dart';
import '/m4_new/components/side_bar_desktop/side_bar_desktop_widget.dart';
import '/mile_stone3/components3/request_cancelled/request_cancelled_widget.dart';
import '/mile_stone3/components3/request_completed/request_completed_widget.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import '/index.dart';
import 'business_dashboard_lead_detail_widget.dart'
    show BusinessDashboardLeadDetailWidget;
import 'package:flutter/material.dart';

class BusinessDashboardLeadDetailModel
    extends FlutterFlowModel<BusinessDashboardLeadDetailWidget> {
  ///  Local state fields for this page.

  String pageSelected = 'overview';

  String leadsFilter = 'all';

  List<int> stepsLead = [0];
  void addToStepsLead(int item) => stepsLead.add(item);
  void removeFromStepsLead(int item) => stepsLead.remove(item);
  void removeAtIndexFromStepsLead(int index) => stepsLead.removeAt(index);
  void insertAtIndexInStepsLead(int index, int item) =>
      stepsLead.insert(index, item);
  void updateStepsLeadAtIndex(int index, Function(int) updateFn) =>
      stepsLead[index] = updateFn(stepsLead[index]);

  QuoteRow? quoteData;

  BookingsRow? booking;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in BusinessDashboardLeadDetail widget.
  List<QuoteRow>? quoteDataOutput;
  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarDesktop component.
  late SideBarDesktopModel sideBarDesktopModel;
  // Model for footer component.
  late FooterModel footerModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for requestOnHold component.
  late RequestOnHoldModel requestOnHoldModel;
  // Model for requestCompleted component.
  late RequestCompletedModel requestCompletedModel;
  // Model for requestCancelled component.
  late RequestCancelledModel requestCancelledModel;
  // Model for leadStepsBox component.
  late LeadStepsBoxModel leadStepsBoxModel;
  // Stores action output result for [Action Block - multiPurposeDialog] action in Button widget.
  bool? response;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarDesktopModel = createModel(context, () => SideBarDesktopModel());
    footerModel = createModel(context, () => FooterModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    requestOnHoldModel = createModel(context, () => RequestOnHoldModel());
    requestCompletedModel = createModel(context, () => RequestCompletedModel());
    requestCancelledModel = createModel(context, () => RequestCancelledModel());
    leadStepsBoxModel = createModel(context, () => LeadStepsBoxModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarDesktopModel.dispose();
    footerModel.dispose();
    mobileAppBarModel.dispose();
    requestOnHoldModel.dispose();
    requestCompletedModel.dispose();
    requestCancelledModel.dispose();
    leadStepsBoxModel.dispose();
    mobileNavBarModel.dispose();
  }
}
