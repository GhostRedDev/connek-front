import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/my_bots_greg_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'office_my_bots_widget.dart' show OfficeMyBotsWidget;
import 'package:flutter/material.dart';

class OfficeMyBotsModel extends FlutterFlowModel<OfficeMyBotsWidget> {
  ///  Local state fields for this component.

  String myBotsFilter = 'all';

  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // Model for MyBotsGreg component.
  late MyBotsGregModel myBotsGregModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    myBotsGregModel = createModel(context, () => MyBotsGregModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    myBotsGregModel.dispose();
    emptySpaceModel.dispose();
  }
}
