import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resquestdeclined_model.dart';
export 'resquestdeclined_model.dart';

class ResquestdeclinedWidget extends StatefulWidget {
  const ResquestdeclinedWidget({super.key});

  @override
  State<ResquestdeclinedWidget> createState() => _ResquestdeclinedWidgetState();
}

class _ResquestdeclinedWidgetState extends State<ResquestdeclinedWidget> {
  late ResquestdeclinedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResquestdeclinedModel());

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
      text: 'Resquest declined',
      icon: const Icon(
        Icons.check_circle_sharp,
        size: 16.0,
      ),
      options: FFButtonOptions(
        width: 260.0,
        height: 24.0,
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconColor: const Color(0xFFD30000),
        color: const Color(0x32D30000),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: const Color(0xFFD30000),
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
