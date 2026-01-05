import '/components/status_badge_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lead_card_info_widget.dart' show LeadCardInfoWidget;
import 'package:flutter/material.dart';

class LeadCardInfoModel extends FlutterFlowModel<LeadCardInfoWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for statusBadge component.
  late StatusBadgeModel statusBadgeModel;

  @override
  void initState(BuildContext context) {
    statusBadgeModel = createModel(context, () => StatusBadgeModel());
  }

  @override
  void dispose() {
    statusBadgeModel.dispose();
  }
}
