import '/components/status_badge_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'solicitud_card_widget.dart' show SolicitudCardWidget;
import 'package:flutter/material.dart';

class SolicitudCardModel extends FlutterFlowModel<SolicitudCardWidget> {
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
