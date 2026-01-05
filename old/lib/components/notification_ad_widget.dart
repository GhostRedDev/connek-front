import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_ad_model.dart';
export 'notification_ad_model.dart';

class NotificationAdWidget extends StatefulWidget {
  const NotificationAdWidget({super.key});

  @override
  State<NotificationAdWidget> createState() => _NotificationAdWidgetState();
}

class _NotificationAdWidgetState extends State<NotificationAdWidget> {
  late NotificationAdModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationAdModel());

    _model.switchValue = FFAppState().myBots.greg.notifications;
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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).bg1Sec,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).secondaryAlpha10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const AlignmentDirectional(-1.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryAlpha10,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Icon(
                      FFIcons.knotification,
                      color: FlutterFlowTheme.of(context).primary200,
                      size: 24.0,
                    ),
                  ),
                  Text(
                    'Mensaje sin responder en 1 hora',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).neutral100,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ].divide(const SizedBox(height: 5.0)),
              ),
            ),
            Switch.adaptive(
              value: _model.switchValue!,
              onChanged: (newValue) async {
                safeSetState(() => _model.switchValue = newValue);
                if (newValue) {
                  await GregTable().update(
                    data: {
                      'notifications': true,
                    },
                    matchingRows: (rows) => rows.eqOrNull(
                      'id',
                      FFAppState().myBots.greg.gregId,
                    ),
                  );

                  _model.updatePage(() {});
                } else {
                  await GregTable().update(
                    data: {
                      'notifications': false,
                    },
                    matchingRows: (rows) => rows.eqOrNull(
                      'id',
                      FFAppState().myBots.greg.gregId,
                    ),
                  );

                  _model.updatePage(() {});
                }
              },
              activeColor: FlutterFlowTheme.of(context).white,
              activeTrackColor: FlutterFlowTheme.of(context).primary200,
              inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
              inactiveThumbColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ],
        ),
      ),
    );
  }
}
