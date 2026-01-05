import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'top_menu_option_model.dart';
export 'top_menu_option_model.dart';

class TopMenuOptionWidget extends StatefulWidget {
  const TopMenuOptionWidget({
    super.key,
    required this.tapAction,
    required this.active,
    required this.icon,
    this.name,
  });

  final Future Function()? tapAction;
  final bool? active;
  final Widget? icon;
  final String? name;

  @override
  State<TopMenuOptionWidget> createState() => _TopMenuOptionWidgetState();
}

class _TopMenuOptionWidgetState extends State<TopMenuOptionWidget> {
  late TopMenuOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopMenuOptionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await widget.tapAction?.call();
      },
      child: Container(
        height: 44.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.active! ? const Color(0xFF212121) : Colors.transparent,
              widget.active! ? const Color(0xFF383737) : Colors.transparent
            ],
            stops: const [0.0, 1.0],
            begin: const AlignmentDirectional(1.0, -0.87),
            end: const AlignmentDirectional(-1.0, 0.87),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.icon!,
              Text(
                valueOrDefault<String>(
                  widget.name,
                  'Option',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: valueOrDefault<Color>(
                        widget.active!
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                        FlutterFlowTheme.of(context).secondary300,
                      ),
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ].divide(const SizedBox(width: 5.0)),
          ),
        ),
      ),
    );
  }
}
