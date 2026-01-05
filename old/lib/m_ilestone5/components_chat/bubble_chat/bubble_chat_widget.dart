import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bubble_chat_model.dart';
export 'bubble_chat_model.dart';

class BubbleChatWidget extends StatefulWidget {
  const BubbleChatWidget({
    super.key,
    required this.clientId,
    required this.messageText,
    this.messageRow,
  });

  final int? clientId;
  final String? messageText;
  final MessagesRow? messageRow;

  @override
  State<BubbleChatWidget> createState() => _BubbleChatWidgetState();
}

class _BubbleChatWidgetState extends State<BubbleChatWidget> {
  late BubbleChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BubbleChatModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.clientId == FFAppState().account.clientId)
            Align(
              alignment: const AlignmentDirectional(1.0, -1.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 331.0,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryAlpha10,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(7.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SelectionArea(
                      child: Text(
                    valueOrDefault<String>(
                      widget.messageText,
                      'Text message asdasd asdasd asd asdasda sdasd asdas dasd asd',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).neutral100,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.3,
                        ),
                  )),
                ),
              ),
            ),
          if (widget.clientId != FFAppState().account.clientId)
            Align(
              alignment: const AlignmentDirectional(-1.0, -1.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 331.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SelectionArea(
                      child: Text(
                    valueOrDefault<String>(
                      widget.messageText,
                      'Text message asdasd asdasd asd asdasda sdasd asdas dasd asd',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).neutral100,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.3,
                        ),
                  )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
