import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'greg_blacklist_model.dart';
export 'greg_blacklist_model.dart';

class GregBlacklistWidget extends StatefulWidget {
  const GregBlacklistWidget({
    super.key,
    required this.word,
  });

  final String? word;

  @override
  State<GregBlacklistWidget> createState() => _GregBlacklistWidgetState();
}

class _GregBlacklistWidgetState extends State<GregBlacklistWidget> {
  late GregBlacklistModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GregBlacklistModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryAlpha20,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 8.0, 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await action_blocks.gregBlackList(
                  context,
                  add: false,
                  word: widget.word,
                );
                FFAppState().updateMyBotsStruct(
                  (e) => e
                    ..updateGreg(
                      (e) => e
                        ..updateBlacklist(
                          (e) => e.remove(widget.word),
                        ),
                    ),
                );
                _model.updatePage(() {});
              },
              child: Icon(
                Icons.cancel_sharp,
                color: FlutterFlowTheme.of(context).primary100,
                size: 18.0,
              ),
            ),
            Text(
              valueOrDefault<String>(
                widget.word,
                'Word',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primary100,
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ].divide(const SizedBox(width: 4.0)),
        ),
      ),
    );
  }
}
