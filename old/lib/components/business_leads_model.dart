import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/lead_newx_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_leads_widget.dart' show BusinessLeadsWidget;
import 'package:flutter/material.dart';

class BusinessLeadsModel extends FlutterFlowModel<BusinessLeadsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Models for LeadNewx dynamic component.
  late FlutterFlowDynamicModels<LeadNewxModel> leadNewxModels;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    leadNewxModels = FlutterFlowDynamicModels(() => LeadNewxModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    leadNewxModels.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    emptySpaceModel.dispose();
  }
}
