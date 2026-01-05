import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'employee_manage_model.dart';
export 'employee_manage_model.dart';

class EmployeeManageWidget extends StatefulWidget {
  const EmployeeManageWidget({super.key});

  @override
  State<EmployeeManageWidget> createState() => _EmployeeManageWidgetState();
}

class _EmployeeManageWidgetState extends State<EmployeeManageWidget> {
  late EmployeeManageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmployeeManageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
