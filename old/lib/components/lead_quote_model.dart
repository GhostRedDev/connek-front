import '/components/status_badge_quote_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lead_quote_widget.dart' show LeadQuoteWidget;
import 'package:flutter/material.dart';

class LeadQuoteModel extends FlutterFlowModel<LeadQuoteWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for statusBadgeQuote component.
  late StatusBadgeQuoteModel statusBadgeQuoteModel1;
  // Model for statusBadgeQuote component.
  late StatusBadgeQuoteModel statusBadgeQuoteModel2;
  // Model for statusBadgeQuote component.
  late StatusBadgeQuoteModel statusBadgeQuoteModel3;

  @override
  void initState(BuildContext context) {
    statusBadgeQuoteModel1 =
        createModel(context, () => StatusBadgeQuoteModel());
    statusBadgeQuoteModel2 =
        createModel(context, () => StatusBadgeQuoteModel());
    statusBadgeQuoteModel3 =
        createModel(context, () => StatusBadgeQuoteModel());
  }

  @override
  void dispose() {
    statusBadgeQuoteModel1.dispose();
    statusBadgeQuoteModel2.dispose();
    statusBadgeQuoteModel3.dispose();
  }
}
