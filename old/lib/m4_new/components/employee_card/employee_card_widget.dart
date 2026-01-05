import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'employee_card_model.dart';
export 'employee_card_model.dart';

class EmployeeCardWidget extends StatefulWidget {
  const EmployeeCardWidget({super.key});

  @override
  State<EmployeeCardWidget> createState() => _EmployeeCardWidgetState();
}

class _EmployeeCardWidgetState extends State<EmployeeCardWidget> {
  late EmployeeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmployeeCardModel());

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
