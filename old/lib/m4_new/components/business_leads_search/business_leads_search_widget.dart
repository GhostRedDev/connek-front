import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/m4_new/components/mouse_leads_search2/mouse_leads_search2_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_leads_search_model.dart';
export 'business_leads_search_model.dart';

class BusinessLeadsSearchWidget extends StatefulWidget {
  const BusinessLeadsSearchWidget({super.key});

  @override
  State<BusinessLeadsSearchWidget> createState() =>
      _BusinessLeadsSearchWidgetState();
}

class _BusinessLeadsSearchWidgetState extends State<BusinessLeadsSearchWidget> {
  late BusinessLeadsSearchModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessLeadsSearchModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0x00F8EEEE),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: Text(
                                'Filter: ',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: const Color(0xFF8D99AE),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MouseRegion(
                                  opaque: false,
                                  cursor:
                                      MouseCursor.defer ?? MouseCursor.defer,
                                  onEnter: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered1 = true);
                                  }),
                                  onExit: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered1 = false);
                                  }),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.filter = 'All';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: () {
                                          if ((_model.filter == 'All') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.light) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if ((_model.filter == 'All') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.dark) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if (_model
                                              .mouseRegionHovered1) {
                                            return const Color(0x4D83B4FF);
                                          } else {
                                            return Colors.transparent;
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        border: Border.all(
                                          color: () {
                                            if ((_model.filter == 'All') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
                                                    true)) {
                                              return const Color(0xFF1D415C);
                                            } else if ((_model.filter ==
                                                    'All') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark) ==
                                                    true)) {
                                              return const Color(0xFF4F87C9);
                                            } else if ((_model.filter !=
                                                    'All') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15.0, 2.0, 15.0, 2.0),
                                        child: Text(
                                          'All',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if ((_model.filter ==
                                                          'All') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF1D415C);
                                                  } else if ((_model.filter ==
                                                          'All') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter !=
                                                          'All') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF8D99AE);
                                                  } else {
                                                    return const Color(0xFF8D99AE);
                                                  }
                                                }(),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  opaque: false,
                                  cursor:
                                      MouseCursor.defer ?? MouseCursor.defer,
                                  onEnter: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered2 = true);
                                  }),
                                  onExit: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered2 = false);
                                  }),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.filter = 'Pendings';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: () {
                                          if ((_model.filter == 'Pendings') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.light) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if ((_model.filter ==
                                                  'Pendings') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.dark) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if (_model
                                              .mouseRegionHovered2) {
                                            return const Color(0x4D83B4FF);
                                          } else {
                                            return Colors.transparent;
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        border: Border.all(
                                          color: () {
                                            if ((_model.filter == 'Pendings') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
                                                    true)) {
                                              return const Color(0xFF1D415C);
                                            } else if ((_model.filter ==
                                                    'Pendings') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark) ==
                                                    true)) {
                                              return const Color(0xFF4F87C9);
                                            } else if ((_model.filter !=
                                                    'Pendings') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15.0, 2.0, 15.0, 2.0),
                                        child: Text(
                                          'Pendings',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Pendings') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF1D415C);
                                                  } else if ((_model.filter ==
                                                          'Pendings') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter !=
                                                          'Pendings') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF8D99AE);
                                                  } else {
                                                    return const Color(0xFF8D99AE);
                                                  }
                                                }(),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  opaque: false,
                                  cursor:
                                      MouseCursor.defer ?? MouseCursor.defer,
                                  onEnter: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered3 = true);
                                  }),
                                  onExit: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered3 = false);
                                  }),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.filter = 'Completed';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: () {
                                          if ((_model.filter == 'Completed') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.light) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if ((_model.filter ==
                                                  'Completed') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.dark) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if (_model
                                              .mouseRegionHovered3) {
                                            return const Color(0x4D83B4FF);
                                          } else {
                                            return Colors.transparent;
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        border: Border.all(
                                          color: () {
                                            if ((_model.filter ==
                                                    'Completed') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
                                                    true)) {
                                              return const Color(0xFF1D415C);
                                            } else if ((_model.filter ==
                                                    'Completed') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark) ==
                                                    true)) {
                                              return const Color(0xFF4F87C9);
                                            } else if ((_model.filter !=
                                                    'Completed') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15.0, 2.0, 15.0, 2.0),
                                        child: Text(
                                          'Completed',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Completed') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF1D415C);
                                                  } else if ((_model.filter ==
                                                          'Completed') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter !=
                                                          'Completed') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF8D99AE);
                                                  } else {
                                                    return const Color(0xFF8D99AE);
                                                  }
                                                }(),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  opaque: false,
                                  cursor:
                                      MouseCursor.defer ?? MouseCursor.defer,
                                  onEnter: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered4 = true);
                                  }),
                                  onExit: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered4 = false);
                                  }),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.filter = 'Declined';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: () {
                                          if ((_model.filter == 'Declined') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.light) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if ((_model.filter ==
                                                  'Declined') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.dark) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if (_model
                                              .mouseRegionHovered4) {
                                            return const Color(0x4D83B4FF);
                                          } else {
                                            return Colors.transparent;
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        border: Border.all(
                                          color: () {
                                            if ((_model.filter == 'Declined') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
                                                    true)) {
                                              return const Color(0xFF1D415C);
                                            } else if ((_model.filter ==
                                                    'Declined') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark) ==
                                                    true)) {
                                              return const Color(0xFF4F87C9);
                                            } else if ((_model.filter !=
                                                    'Declined') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15.0, 2.0, 15.0, 2.0),
                                        child: Text(
                                          'Declined',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Declined') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF1D415C);
                                                  } else if ((_model.filter ==
                                                          'Declined') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter !=
                                                          'Declined') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF8D99AE);
                                                  } else {
                                                    return const Color(0xFF8D99AE);
                                                  }
                                                }(),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  opaque: false,
                                  cursor:
                                      MouseCursor.defer ?? MouseCursor.defer,
                                  onEnter: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered5 = true);
                                  }),
                                  onExit: ((event) async {
                                    safeSetState(() =>
                                        _model.mouseRegionHovered5 = false);
                                  }),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.filter = 'News';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: () {
                                          if ((_model.filter == 'News') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.light) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if ((_model.filter ==
                                                  'News') &&
                                              ((Theme.of(context).brightness ==
                                                      Brightness.dark) ==
                                                  true)) {
                                            return const Color(0x1983B4FF);
                                          } else if (_model
                                              .mouseRegionHovered5) {
                                            return const Color(0x4D83B4FF);
                                          } else {
                                            return Colors.transparent;
                                          }
                                        }(),
                                        borderRadius:
                                            BorderRadius.circular(999.0),
                                        border: Border.all(
                                          color: () {
                                            if ((_model.filter == 'News') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
                                                    true)) {
                                              return const Color(0xFF1D415C);
                                            } else if ((_model.filter ==
                                                    'News') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark) ==
                                                    true)) {
                                              return const Color(0xFF4F87C9);
                                            } else if ((_model.filter !=
                                                    'News') &&
                                                ((Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light) ==
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15.0, 2.0, 15.0, 2.0),
                                        child: Text(
                                          'News',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if ((_model.filter ==
                                                          'News') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF1D415C);
                                                  } else if ((_model.filter ==
                                                          'News') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter !=
                                                          'News') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF8D99AE);
                                                  } else {
                                                    return const Color(0xFF8D99AE);
                                                  }
                                                }(),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                            ))
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 5.0, 0.0),
                                child: Text(
                                  'Order from: ',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: const Color(0xFF8D99AE),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                            ))
                              FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController ??=
                                    FormFieldController<String>(
                                  _model.dropDownValue ??= 'This week',
                                ),
                                options: const [
                                  'This week',
                                  'This month',
                                  'This year'
                                ],
                                onChanged: (val) => safeSetState(
                                    () => _model.dropDownValue = val),
                                width: 120.0,
                                height: 20.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0xFF1D415C)
                                          : const Color(0xFF8D99AE),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                hintText: 'This week',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color(0xFF1D415C)
                                      : const Color(0xFF8D99AE),
                                  size: 24.0,
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color(0xFFEEEEEE)
                                    : const Color(0xFF31363F),
                                elevation: 2.0,
                                borderColor: const Color(0xFF1D415C),
                                borderWidth: 1.0,
                                borderRadius: 50.0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                    ))
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 250.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                color: const Color(0xFF8D99AE),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  FFIcons.kiconSearch,
                                  color: Color(0xFF8D99AE),
                                  size: 24.0,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 200.0,
                                    child: TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Search leads',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color: const Color(0xFF8D99AE),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0x00FFFFFF),
                                        hoverColor: Colors.transparent,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 15.0))
                                  .around(const SizedBox(width: 15.0)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    final leads = FFAppState().businessLeads.toList();

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(leads.length, (leadsIndex) {
                        final leadsItem = leads[leadsIndex];
                        return Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: wrapWithModel(
                            model: _model.mouseLeadsSearch02Models.getModel(
                              leadsIndex.toString(),
                              leadsIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: MouseLeadsSearch2Widget(
                              key: Key(
                                'Keyvd5_${leadsIndex.toString()}',
                              ),
                              lead: leadsItem,
                            ),
                          ),
                        );
                      }).divide(const SizedBox(width: 25.0)),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
