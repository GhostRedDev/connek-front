import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_cancelled/request_cancelled_widget.dart';
import '/mile_stone3/components3/request_completed/request_completed_widget.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import 'request_card_mobile_widget.dart' show RequestCardMobileWidget;
import 'package:flutter/material.dart';

class RequestCardMobileModel extends FlutterFlowModel<RequestCardMobileWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for requestCompleted component.
  late RequestCompletedModel requestCompletedModel;
  // Model for requestCancelled component.
  late RequestCancelledModel requestCancelledModel;
  // Model for requestOnHold component.
  late RequestOnHoldModel requestOnHoldModel;

  @override
  void initState(BuildContext context) {
    requestCompletedModel = createModel(context, () => RequestCompletedModel());
    requestCancelledModel = createModel(context, () => RequestCancelledModel());
    requestOnHoldModel = createModel(context, () => RequestOnHoldModel());
  }

  @override
  void dispose() {
    requestCompletedModel.dispose();
    requestCancelledModel.dispose();
    requestOnHoldModel.dispose();
  }
}
