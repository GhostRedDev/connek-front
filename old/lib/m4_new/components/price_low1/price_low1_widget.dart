import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'price_low1_model.dart';
export 'price_low1_model.dart';

class PriceLow1Widget extends StatefulWidget {
  const PriceLow1Widget({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  State<PriceLow1Widget> createState() => _PriceLow1WidgetState();
}

class _PriceLow1WidgetState extends State<PriceLow1Widget> {
  late PriceLow1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PriceLow1Model());

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
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: const Color(0x1900D73B),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FFIcons.kdollarCircle,
                color: FlutterFlowTheme.of(context).success,
                size: 20.0,
              ),
              Text(
                valueOrDefault<String>(
                  widget.text,
                  'Price Low: \$100.00',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).success,
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
