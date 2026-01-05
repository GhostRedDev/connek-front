import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/employee_card/employee_card_widget.dart';
import 'business_dashboard_employees_widget.dart'
    show BusinessDashboardEmployeesWidget;
import 'package:flutter/material.dart';

class BusinessDashboardEmployeesModel
    extends FlutterFlowModel<BusinessDashboardEmployeesWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmployeeCard component.
  late EmployeeCardModel employeeCardModel;

  @override
  void initState(BuildContext context) {
    employeeCardModel = createModel(context, () => EmployeeCardModel());
  }

  @override
  void dispose() {
    employeeCardModel.dispose();
  }
}
