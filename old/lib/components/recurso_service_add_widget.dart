import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recurso_service_add_model.dart';
export 'recurso_service_add_model.dart';

class RecursoServiceAddWidget extends StatefulWidget {
  const RecursoServiceAddWidget({
    super.key,
    required this.resource,
    required this.onActivate,
    required this.onDeactivate,
  });

  final ResourceDataStruct? resource;
  final Future Function()? onActivate;
  final Future Function()? onDeactivate;

  @override
  State<RecursoServiceAddWidget> createState() =>
      _RecursoServiceAddWidgetState();
}

class _RecursoServiceAddWidgetState extends State<RecursoServiceAddWidget> {
  late RecursoServiceAddModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecursoServiceAddModel());

    _model.switchValue = true;
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
      width: 147.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryAlpha10,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).secondaryAlpha10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 7.0, 0.0, 7.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                valueOrDefault<String>(
                  functions.urlStorageFile('business',
                      '${FFAppState().account.businessId.toString()}/resources/${widget.resource?.resourceId.toString()}/${widget.resource?.profileImage}'),
                  'https://momentumhealth.ca/wp-content/uploads/2024/05/Massage-therapists-momentum-health-calgary-ab.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  widget.resource?.name,
                  'Gabriel',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).neutral100,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Text(
              valueOrDefault<String>(
                widget.resource?.resourceType == 'staff'
                    ? 'Staff'
                    : 'Resource',
                'Staff',
              ),
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondary300,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                  ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
              child: Switch.adaptive(
                value: _model.switchValue!,
                onChanged: (newValue) async {
                  safeSetState(() => _model.switchValue = newValue);
                  if (newValue) {
                    await widget.onActivate?.call();
                  } else {
                    await widget.onDeactivate?.call();
                  }
                },
                activeColor: FlutterFlowTheme.of(context).white,
                activeTrackColor: FlutterFlowTheme.of(context).primary200,
                inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                inactiveThumbColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
