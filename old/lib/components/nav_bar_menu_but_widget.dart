import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nav_bar_menu_but_model.dart';
export 'nav_bar_menu_but_model.dart';

class NavBarMenuButWidget extends StatefulWidget {
  const NavBarMenuButWidget({super.key});

  @override
  State<NavBarMenuButWidget> createState() => _NavBarMenuButWidgetState();
}

class _NavBarMenuButWidgetState extends State<NavBarMenuButWidget> {
  late NavBarMenuButModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarMenuButModel());

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
      width: 79.0,
      height: 57.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryAlpha20,
        borderRadius: BorderRadius.circular(100.0),
      ),
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FFIcons.kmisbots,
            color: FlutterFlowTheme.of(context).primary100,
            size: 30.0,
          ),
          Text(
            'Oficina',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primary100,
                  fontSize: 10.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
        ],
      ),
    );
  }
}
