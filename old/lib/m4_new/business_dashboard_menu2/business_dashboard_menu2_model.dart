import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_dashboard_menu2_widget.dart' show BusinessDashboardMenu2Widget;
import 'package:flutter/material.dart';

class BusinessDashboardMenu2Model
    extends FlutterFlowModel<BusinessDashboardMenu2Widget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in employees widget.
  List<EmployeesRow>? employeesData;
  // Stores action output result for [Action Block - loadBusinessData] action in profile widget.
  BusinessDataStruct? businessQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
