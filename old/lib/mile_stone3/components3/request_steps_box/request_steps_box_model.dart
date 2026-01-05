import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'request_steps_box_widget.dart' show RequestStepsBoxWidget;
import 'package:flutter/material.dart';

class RequestStepsBoxModel extends FlutterFlowModel<RequestStepsBoxWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<QuoteRow>? acceptedQuote;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<RequestsRow>? updatedRequest;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<LeadsRow>? updatedLead;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<QuoteRow>? declinedQuote;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
