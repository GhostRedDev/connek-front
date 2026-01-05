import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alerts_i_a_model.dart';
export 'alerts_i_a_model.dart';

class AlertsIAWidget extends StatefulWidget {
  const AlertsIAWidget({super.key});

  @override
  State<AlertsIAWidget> createState() => _AlertsIAWidgetState();
}

class _AlertsIAWidgetState extends State<AlertsIAWidget> {
  late AlertsIAModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertsIAModel());

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
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 44.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).greenAlpha10,
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).secondaryAlpha10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: SvgPicture.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/Sugerencias_IA_Night.svg'
                    : 'assets/images/SugIaButLight.svg',
                width: 18.0,
                height: 18.0,
                fit: BoxFit.none,
              ),
            ),
            Expanded(
              child: Text(
                'Optimizar el bot \'Greg\' para reducir errores',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ].divide(const SizedBox(width: 8.0)),
        ),
      ),
    );
  }
}
