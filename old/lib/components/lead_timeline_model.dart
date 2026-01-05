import '/components/time_line_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lead_timeline_widget.dart' show LeadTimelineWidget;
import 'package:flutter/material.dart';

class LeadTimelineModel extends FlutterFlowModel<LeadTimelineWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TimeLine component.
  late TimeLineModel timeLineModel;

  @override
  void initState(BuildContext context) {
    timeLineModel = createModel(context, () => TimeLineModel());
  }

  @override
  void dispose() {
    timeLineModel.dispose();
  }
}
