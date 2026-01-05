import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_menu_widget.dart' show BusinessMenuWidget;
import 'package:flutter/material.dart';

class BusinessMenuModel extends FlutterFlowModel<BusinessMenuWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for overview.
  late TopMenuOptionModel overviewModel;
  // Model for leads.
  late TopMenuOptionModel leadsModel;
  // Model for clients.
  late TopMenuOptionModel clientsModel;
  // Model for sales.
  late TopMenuOptionModel salesModel;
  // Model for services.
  late TopMenuOptionModel servicesModel;
  // Model for employees.
  late TopMenuOptionModel employeesModel;

  @override
  void initState(BuildContext context) {
    overviewModel = createModel(context, () => TopMenuOptionModel());
    leadsModel = createModel(context, () => TopMenuOptionModel());
    clientsModel = createModel(context, () => TopMenuOptionModel());
    salesModel = createModel(context, () => TopMenuOptionModel());
    servicesModel = createModel(context, () => TopMenuOptionModel());
    employeesModel = createModel(context, () => TopMenuOptionModel());
  }

  @override
  void dispose() {
    overviewModel.dispose();
    leadsModel.dispose();
    clientsModel.dispose();
    salesModel.dispose();
    servicesModel.dispose();
    employeesModel.dispose();
  }
}
