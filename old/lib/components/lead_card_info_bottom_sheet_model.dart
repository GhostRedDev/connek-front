import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import 'lead_card_info_bottom_sheet_widget.dart'
    show LeadCardInfoBottomSheetWidget;
import 'package:flutter/material.dart';

class LeadCardInfoBottomSheetModel
    extends FlutterFlowModel<LeadCardInfoBottomSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for requestOnHold component.
  late RequestOnHoldModel requestOnHoldModel;

  @override
  void initState(BuildContext context) {
    requestOnHoldModel = createModel(context, () => RequestOnHoldModel());
  }

  @override
  void dispose() {
    requestOnHoldModel.dispose();
  }
}
