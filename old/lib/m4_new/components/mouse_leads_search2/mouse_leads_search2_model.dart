import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_cancelled_small/request_cancelled_small_widget.dart';
import '/mile_stone3/components3/request_completed_small/request_completed_small_widget.dart';
import '/mile_stone3/components3/request_on_hold_small/request_on_hold_small_widget.dart';
import 'mouse_leads_search2_widget.dart' show MouseLeadsSearch2Widget;
import 'package:flutter/material.dart';

class MouseLeadsSearch2Model extends FlutterFlowModel<MouseLeadsSearch2Widget> {
  ///  Local state fields for this component.

  bool bookingEnabled = true;

  bool joseActive = true;

  ///  State fields for stateful widgets in this component.

  // Model for requestCancelledSmall component.
  late RequestCancelledSmallModel requestCancelledSmallModel;
  // Model for requestCompletedSmall component.
  late RequestCompletedSmallModel requestCompletedSmallModel;
  // Model for requestOnHoldSmall component.
  late RequestOnHoldSmallModel requestOnHoldSmallModel;

  @override
  void initState(BuildContext context) {
    requestCancelledSmallModel =
        createModel(context, () => RequestCancelledSmallModel());
    requestCompletedSmallModel =
        createModel(context, () => RequestCompletedSmallModel());
    requestOnHoldSmallModel =
        createModel(context, () => RequestOnHoldSmallModel());
  }

  @override
  void dispose() {
    requestCancelledSmallModel.dispose();
    requestCompletedSmallModel.dispose();
    requestOnHoldSmallModel.dispose();
  }
}
