import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_dashboard_analytics_model.dart';
export 'business_dashboard_analytics_model.dart';

class BusinessDashboardAnalyticsWidget extends StatefulWidget {
  const BusinessDashboardAnalyticsWidget({super.key});

  @override
  State<BusinessDashboardAnalyticsWidget> createState() =>
      _BusinessDashboardAnalyticsWidgetState();
}

class _BusinessDashboardAnalyticsWidgetState
    extends State<BusinessDashboardAnalyticsWidget> {
  late BusinessDashboardAnalyticsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardAnalyticsModel());

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

    return FutureBuilder<ApiCallResponse>(
      future: ConnekApiGroup.businessLeadsCall.call(
        businessId: FFAppState().account.businessId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        final containerBusinessLeadsResponse = snapshot.data!;

        return Container(
          height: 400.0,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? (() {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return true;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return true;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return true;
                    } else {
                      return false;
                    }
                  }()
                    ? Colors.transparent
                    : const Color(0x66EEEEEE))
                : const Color(0x004F87C9),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return false;
                } else {
                  return true;
                }
              }()
                  ? FlutterFlowTheme.of(context).green400
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                valueOrDefault<double>(
                  () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 0.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 0.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 0.0;
                    } else {
                      return 15.0;
                    }
                  }(),
                  0.0,
                ),
                10.0,
                valueOrDefault<double>(
                  () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 0.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 0.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 0.0;
                    } else {
                      return 15.0;
                    }
                  }(),
                  0.0,
                ),
                0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            FFAppState().weekState = true;
                            safeSetState(() {});
                          },
                          text: 'Weekly',
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 15.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FFAppState().weekState == true
                                ? const Color(0xFF4F87C9)
                                : const Color(0x008D99AE),
                            textStyle:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FFAppState().weekState == true
                                          ? Colors.white
                                          : const Color(0xFF8D99AE),
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Color(0x008D99AE),
                              width: 0.0,
                            ),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            FFAppState().weekState = false;
                            safeSetState(() {});
                          },
                          text: 'Monthly',
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 15.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FFAppState().weekState == false
                                ? const Color(0xFF4F87C9)
                                : const Color(0x008D99AE),
                            textStyle:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FFAppState().weekState == false
                                          ? Colors.white
                                          : const Color(0xFF8D99AE),
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Color(0x008D99AE),
                              width: 0.0,
                            ),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                        ),
                      ].divide(const SizedBox(width: 10.0)),
                    ),
                  ],
                ),
                if (FFAppState().weekState == true)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return true;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return true;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return true;
                            } else {
                              return false;
                            }
                          }()
                              ? FlutterFlowTheme.of(context).green400
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                if (FFAppState().weekState == false)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return true;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return true;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return true;
                            } else {
                              return false;
                            }
                          }()
                              ? FlutterFlowTheme.of(context).green400
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
              ].divide(const SizedBox(height: 10.0)),
            ),
          ),
        );
      },
    );
  }
}
