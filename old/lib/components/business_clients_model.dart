import '/components/client_card_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'business_clients_widget.dart' show BusinessClientsWidget;
import 'package:flutter/material.dart';

class BusinessClientsModel extends FlutterFlowModel<BusinessClientsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // Models for ClientCard dynamic component.
  late FlutterFlowDynamicModels<ClientCardModel> clientCardModels;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    clientCardModels = FlutterFlowDynamicModels(() => ClientCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    clientCardModels.dispose();
    emptySpaceModel.dispose();
  }
}
