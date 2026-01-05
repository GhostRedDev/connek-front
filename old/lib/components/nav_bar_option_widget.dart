import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nav_bar_option_model.dart';
export 'nav_bar_option_model.dart';

class NavBarOptionWidget extends StatefulWidget {
  const NavBarOptionWidget({
    super.key,
    required this.active,
    required this.text,
    required this.icon,
    required this.tapAction,
  });

  final bool? active;
  final String? text;
  final Widget? icon;
  final Future Function()? tapAction;

  @override
  State<NavBarOptionWidget> createState() => _NavBarOptionWidgetState();
}

class _NavBarOptionWidgetState extends State<NavBarOptionWidget> {
  late NavBarOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarOptionModel());

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
        width: 79.0,
        height: 57.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            widget.active!
                ? FlutterFlowTheme.of(context).primaryAlpha20
                : const Color(0x0000000E),
            const Color(0x008D99AE),
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon!,
            Text(
              valueOrDefault<String>(
                widget.text,
                'Option',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: valueOrDefault<Color>(
                      widget.active!
                          ? FlutterFlowTheme.of(context).primary100
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).accent1,
                    ),
                    fontSize: 10.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
