import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'price_high1_model.dart';
export 'price_high1_model.dart';

class PriceHigh1Widget extends StatefulWidget {
  const PriceHigh1Widget({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  State<PriceHigh1Widget> createState() => _PriceHigh1WidgetState();
}

class _PriceHigh1WidgetState extends State<PriceHigh1Widget> {
  late PriceHigh1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PriceHigh1Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: const Color(0x194F87C9),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FFIcons.kdollarCircle,
                color: Color(0xFF4F87C9),
                size: 20.0,
              ),
              Text(
                valueOrDefault<String>(
                  widget.text,
                  '200',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: const Color(0xFF4F87C9),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ].divide(const SizedBox(width: 6.0)),
          ),
        ),
      ),
    );
  }
}
