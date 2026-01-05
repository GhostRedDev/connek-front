import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_dashboard_welcome_model.dart';
export 'business_dashboard_welcome_model.dart';

class BusinessDashboardWelcomeWidget extends StatefulWidget {
  const BusinessDashboardWelcomeWidget({
    super.key,
    required this.title,
    required this.message,
    this.sunActive,
  });

  final String? title;
  final String? message;
  final bool? sunActive;

  @override
  State<BusinessDashboardWelcomeWidget> createState() =>
      _BusinessDashboardWelcomeWidgetState();
}

class _BusinessDashboardWelcomeWidgetState
    extends State<BusinessDashboardWelcomeWidget> {
  late BusinessDashboardWelcomeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardWelcomeModel());

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
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x3382CDFF),
            offset: Offset(0.0, 0.0),
          )
        ],
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).secondaryAlpha20,
            FlutterFlowTheme.of(context).bg2Sec,
            FlutterFlowTheme.of(context).bg2Sec,
            FlutterFlowTheme.of(context).secondaryAlpha20
          ],
          stops: const [0.0, 0.15, 0.9, 1.0],
          begin: const AlignmentDirectional(1.0, -0.5),
          end: const AlignmentDirectional(-1.0, 0.5),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Text(
                        valueOrDefault<String>(
                          (String name) {
                            return "Good morning, $name";
                          }(FFAppState().businessData.name),
                          'Good morning, Carlos Eduardo Pastor Romero mijail',
                        ),
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                              ),
                              fontSize: valueOrDefault<double>(
                                () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 18.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 18.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 22.0;
                                  } else {
                                    return 22.0;
                                  }
                                }(),
                                18.0,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                  if (widget.sunActive == true)
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/sunEmoji.png',
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              valueOrDefault<String>(
                widget.message,
                'See how your business is moving from the overview.',
              ),
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    fontSize: valueOrDefault<double>(
                      () {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return 14.0;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return 14.0;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return 20.0;
                        } else {
                          return 20.0;
                        }
                      }(),
                      14.0,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
            ),
          ].divide(const SizedBox(height: 2.0)),
        ),
      ),
    );
  }
}
