import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_ind_contact_model.dart';
export 'chat_ind_contact_model.dart';

class ChatIndContactWidget extends StatefulWidget {
  const ChatIndContactWidget({super.key});

  @override
  State<ChatIndContactWidget> createState() => _ChatIndContactWidgetState();
}

class _ChatIndContactWidgetState extends State<ChatIndContactWidget> {
  late ChatIndContactModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatIndContactModel());

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
      width: 77.0,
      height: 23.0,
      decoration: BoxDecoration(
        color: const Color(0x2683B4FF),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
              child: Icon(
                Icons.person,
                color: Color(0xFF8D99AE),
                size: 10.31,
              ),
            ),
            Text(
              'Contacts',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: const Color(0xFF8D99AE),
                    fontSize: 11.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ].divide(const SizedBox(width: 3.0)),
        ),
      ),
    );
  }
}
