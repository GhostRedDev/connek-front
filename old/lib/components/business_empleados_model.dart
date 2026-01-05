import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/my_bots_greg_widget.dart';
import '/components/recurso_card_widget.dart';
import '/components/staff_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_empleados_widget.dart' show BusinessEmpleadosWidget;
import 'package:flutter/material.dart';

class BusinessEmpleadosModel extends FlutterFlowModel<BusinessEmpleadosWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for MyBotsGreg component.
  late MyBotsGregModel myBotsGregModel;
  // Models for StaffCard dynamic component.
  late FlutterFlowDynamicModels<StaffCardModel> staffCardModels;
  // Models for RecursoCard dynamic component.
  late FlutterFlowDynamicModels<RecursoCardModel> recursoCardModels;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    myBotsGregModel = createModel(context, () => MyBotsGregModel());
    staffCardModels = FlutterFlowDynamicModels(() => StaffCardModel());
    recursoCardModels = FlutterFlowDynamicModels(() => RecursoCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    myBotsGregModel.dispose();
    staffCardModels.dispose();
    recursoCardModels.dispose();
    emptySpaceModel.dispose();
  }
}
