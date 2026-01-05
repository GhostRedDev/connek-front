import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'resource_form_model.dart';
export 'resource_form_model.dart';

class ResourceFormWidget extends StatefulWidget {
  const ResourceFormWidget({super.key});

  @override
  State<ResourceFormWidget> createState() => _ResourceFormWidgetState();
}

class _ResourceFormWidgetState extends State<ResourceFormWidget> {
  late ResourceFormModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResourceFormModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 238.8,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
    );
  }
}
