import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filter_option_model.dart';
export 'filter_option_model.dart';

class FilterOptionWidget extends StatefulWidget {
  const FilterOptionWidget({
    super.key,
    required this.text,
    required this.selected,
    required this.updateFIlterCallback,
  });

  final String? text;
  final bool? selected;
  final Future Function()? updateFIlterCallback;

  @override
  State<FilterOptionWidget> createState() => _FilterOptionWidgetState();
}

class _FilterOptionWidgetState extends State<FilterOptionWidget> {
  late FilterOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterOptionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
      }),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          await widget.updateFIlterCallback?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            color: () {
              if ((widget.selected == true) &&
                  ((Theme.of(context).brightness == Brightness.light) ==
                      true)) {
                return const Color(0xFF4F87C9);
              } else if ((widget.selected == true) &&
                  ((Theme.of(context).brightness == Brightness.dark) == true)) {
                return const Color(0xFF4F87C9);
              } else if (_model.mouseRegionHovered) {
                return const Color(0x4D83B4FF);
              } else {
                return Colors.transparent;
              }
            }(),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(
              color: () {
                if ((widget.selected == true) &&
                    ((Theme.of(context).brightness == Brightness.light) ==
                        true)) {
                  return const Color(0xFF1D415C);
                } else if ((widget.selected == true) &&
                    ((Theme.of(context).brightness == Brightness.dark) ==
                        true)) {
                  return const Color(0xFF4F87C9);
                } else if ((widget.selected == false) &&
                    ((Theme.of(context).brightness == Brightness.light) ==
                        true)) {
                  return const Color(0xFF8D99AE);
                } else {
                  return const Color(0xFF8D99AE);
                }
              }(),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15.0, 2.0, 15.0, 2.0),
            child: Text(
              valueOrDefault<String>(
                widget.text,
                'All',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: () {
                      if ((widget.selected == true) &&
                          ((Theme.of(context).brightness == Brightness.light) ==
                              true)) {
                        return Colors.white;
                      } else if ((widget.selected == true) &&
                          ((Theme.of(context).brightness == Brightness.dark) ==
                              true)) {
                        return Colors.white;
                      } else if ((widget.selected == false) &&
                          ((Theme.of(context).brightness == Brightness.light) ==
                              true)) {
                        return const Color(0xFF8D99AE);
                      } else {
                        return const Color(0xFF8D99AE);
                      }
                    }(),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
