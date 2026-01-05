import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inactive_chats_client_dashboard_model.dart';
export 'inactive_chats_client_dashboard_model.dart';

class InactiveChatsClientDashboardWidget extends StatefulWidget {
  const InactiveChatsClientDashboardWidget({super.key});

  @override
  State<InactiveChatsClientDashboardWidget> createState() =>
      _InactiveChatsClientDashboardWidgetState();
}

class _InactiveChatsClientDashboardWidgetState
    extends State<InactiveChatsClientDashboardWidget> {
  late InactiveChatsClientDashboardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InactiveChatsClientDashboardModel());

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
      width: 72.0,
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
            Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Color(0xFF8D99AE),
                shape: BoxShape.circle,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
              child: Text(
                'Inactive',
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
            ),
          ],
        ),
      ),
    );
  }
}
