import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'office_menu_widget.dart' show OfficeMenuWidget;
import 'package:flutter/material.dart';

class OfficeMenuModel extends FlutterFlowModel<OfficeMenuWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for overview.
  late TopMenuOptionModel overviewModel;
  // Model for myBots.
  late TopMenuOptionModel myBotsModel;
  // Model for clients.
  late TopMenuOptionModel clientsModel;
  // Model for services.
  late TopMenuOptionModel servicesModel;

  @override
  void initState(BuildContext context) {
    overviewModel = createModel(context, () => TopMenuOptionModel());
    myBotsModel = createModel(context, () => TopMenuOptionModel());
    clientsModel = createModel(context, () => TopMenuOptionModel());
    servicesModel = createModel(context, () => TopMenuOptionModel());
  }

  @override
  void dispose() {
    overviewModel.dispose();
    myBotsModel.dispose();
    clientsModel.dispose();
    servicesModel.dispose();
  }
}
