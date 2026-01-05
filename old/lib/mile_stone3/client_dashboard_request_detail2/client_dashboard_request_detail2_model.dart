import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/request_cancelled/request_cancelled_widget.dart';
import '/mile_stone3/components3/request_completed/request_completed_widget.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import '/index.dart';
import 'client_dashboard_request_detail2_widget.dart'
    show ClientDashboardRequestDetail2Widget;
import 'package:flutter/material.dart';

class ClientDashboardRequestDetail2Model
    extends FlutterFlowModel<ClientDashboardRequestDetail2Widget> {
  ///  Local state fields for this page.

  String leadsFilter = 'all';

  String requestQueryFilter = 'all';

  String filter = 'All';

  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for requestOnHold component.
  late RequestOnHoldModel requestOnHoldModel;
  // Model for requestCompleted component.
  late RequestCompletedModel requestCompletedModel;
  // Model for requestCancelled component.
  late RequestCancelledModel requestCancelledModel;
  // Stores action output result for [Backend Call - API (Setup Payment Method)] action in Button widget.
  ApiCallResponse? setupPaymentQuery;
  // Stores action output result for [Action Block - multiPurposeDialog] action in Button widget.
  bool? confirmDialog;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    requestOnHoldModel = createModel(context, () => RequestOnHoldModel());
    requestCompletedModel = createModel(context, () => RequestCompletedModel());
    requestCancelledModel = createModel(context, () => RequestCancelledModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    requestOnHoldModel.dispose();
    requestCompletedModel.dispose();
    requestCancelledModel.dispose();
    mobileNavBarModel.dispose();
  }
}
