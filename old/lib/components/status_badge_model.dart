import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_cancelled/request_cancelled_widget.dart';
import '/mile_stone3/components3/request_completed/request_completed_widget.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import 'status_badge_widget.dart' show StatusBadgeWidget;
import 'package:flutter/material.dart';

class StatusBadgeModel extends FlutterFlowModel<StatusBadgeWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for requestCompleted component.
  late RequestCompletedModel requestCompletedModel;
  // Model for requestOnHold component.
  late RequestOnHoldModel requestOnHoldModel;
  // Model for requestCancelled component.
  late RequestCancelledModel requestCancelledModel;

  @override
  void initState(BuildContext context) {
    requestCompletedModel = createModel(context, () => RequestCompletedModel());
    requestOnHoldModel = createModel(context, () => RequestOnHoldModel());
    requestCancelledModel = createModel(context, () => RequestCancelledModel());
  }

  @override
  void dispose() {
    requestCompletedModel.dispose();
    requestOnHoldModel.dispose();
    requestCancelledModel.dispose();
  }
}
