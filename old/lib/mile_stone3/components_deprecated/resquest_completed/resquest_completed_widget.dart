import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resquest_completed_model.dart';
export 'resquest_completed_model.dart';

class ResquestCompletedWidget extends StatefulWidget {
  const ResquestCompletedWidget({super.key});

  @override
  State<ResquestCompletedWidget> createState() =>
      _ResquestCompletedWidgetState();
}

class _ResquestCompletedWidgetState extends State<ResquestCompletedWidget> {
  late ResquestCompletedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResquestCompletedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
      },
      text: 'Resquest completed',
      icon: const Icon(
        Icons.check_circle_sharp,
        size: 16.0,
      ),
      options: FFButtonOptions(
        width: 260.0,
        height: 24.0,
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconColor: const Color(0xFF00D73B),
        color: const Color(0x3400D73B),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: const Color(0xFF00D73B),
              fontSize: 12.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
