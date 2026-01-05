import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/card_post_desktop/card_post_desktop_widget.dart';
import '/mile_stone3/components3/card_post_mobile/card_post_mobile_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import '/mile_stone3/customer_dashboard_menu/customer_dashboard_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client_dashboard_post_model.dart';
export 'client_dashboard_post_model.dart';

class ClientDashboardPostWidget extends StatefulWidget {
  const ClientDashboardPostWidget({super.key});

  static String routeName = 'ClientDashboardPost';
  static String routePath = 'clientDashboardPost';

  @override
  State<ClientDashboardPostWidget> createState() =>
      _ClientDashboardPostWidgetState();
}

class _ClientDashboardPostWidgetState extends State<ClientDashboardPostWidget> {
  late ClientDashboardPostModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientDashboardPostModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Builder(
            builder: (context) {
              if (() {
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
              }()) {
                return Visibility(
                  visible: responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                    tabletLandscape: false,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xFF222831),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.desktopHeaderModel,
                          updateCallback: () => safeSetState(() {}),
                          child: const DesktopHeaderWidget(
                            moduleName: 'business',
                            bgTrans: true,
                            blur: false,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.sideBarClientDashboardModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const SideBarClientDashboardWidget(
                                    navSelected: 'Posts',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 100.0,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height: 52.0,
                                          decoration: BoxDecoration(
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.light) ==
                                                        true
                                                    ? const Color(0xFFEEEEEE)
                                                    : const Color(0xFF31363F),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Posts',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .customColor38,
                                                        fontSize: 25.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 7.0, 0.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0x4D4F87C9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                1.0, 0.0),
                                                    child: Icon(
                                                      FFIcons.kmedalStar,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor46,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30.0,
                                          decoration: const BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              MouseRegion(
                                                opaque: false,
                                                cursor: MouseCursor.defer ??
                                                    MouseCursor.defer,
                                                onEnter: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered1 =
                                                      true);
                                                }),
                                                onExit: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered1 =
                                                      false);
                                                }),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.filter = 'All';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'All') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if ((_model
                                                                    .filter ==
                                                                'All') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if (_model
                                                            .mouseRegionHovered1) {
                                                          return const Color(
                                                              0x4D83B4FF);
                                                        } else {
                                                          return Colors
                                                              .transparent;
                                                        }
                                                      }(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999.0),
                                                      border: Border.all(
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'All') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF1D415C);
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'All') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF4F87C9);
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'All') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  2.0,
                                                                  15.0,
                                                                  2.0),
                                                      child: Text(
                                                        'All',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if ((_model.filter ==
                                                                            'All') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'All') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'All') &&
                                                                        ((Theme.of(context).brightness ==
                                                                                Brightness.light) ==
                                                                            true)) {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                                cursor: MouseCursor.defer ??
                                                    MouseCursor.defer,
                                                onEnter: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered2 =
                                                      true);
                                                }),
                                                onExit: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered2 =
                                                      false);
                                                }),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.filter = 'Contacts';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'Contacts') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if ((_model
                                                                    .filter ==
                                                                'Contacts') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if (_model
                                                            .mouseRegionHovered2) {
                                                          return const Color(
                                                              0x4D83B4FF);
                                                        } else {
                                                          return Colors
                                                              .transparent;
                                                        }
                                                      }(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999.0),
                                                      border: Border.all(
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Contacts') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF1D415C);
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Contacts') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF4F87C9);
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Contacts') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  2.0,
                                                                  15.0,
                                                                  2.0),
                                                      child: Text(
                                                        'Videos',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if ((_model.filter ==
                                                                            'Contacts') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'Contacts') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'Contacts') &&
                                                                        ((Theme.of(context).brightness ==
                                                                                Brightness.light) ==
                                                                            true)) {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                                cursor: MouseCursor.defer ??
                                                    MouseCursor.defer,
                                                onEnter: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered3 =
                                                      true);
                                                }),
                                                onExit: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered3 =
                                                      false);
                                                }),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.filter = 'Image';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'Image') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if ((_model
                                                                    .filter ==
                                                                'Image') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if (_model
                                                            .mouseRegionHovered3) {
                                                          return const Color(
                                                              0x4D83B4FF);
                                                        } else {
                                                          return Colors
                                                              .transparent;
                                                        }
                                                      }(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999.0),
                                                      border: Border.all(
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF1D415C);
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF4F87C9);
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  2.0,
                                                                  15.0,
                                                                  2.0),
                                                      child: Text(
                                                        'Image',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if ((_model.filter ==
                                                                            'Image') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'Image') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'Image') &&
                                                                        ((Theme.of(context).brightness ==
                                                                                Brightness.light) ==
                                                                            true)) {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                                cursor: MouseCursor.defer ??
                                                    MouseCursor.defer,
                                                onEnter: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered4 =
                                                      true);
                                                }),
                                                onExit: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered4 =
                                                      false);
                                                }),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.filter = 'Carrousel';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'Carrousel') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if ((_model
                                                                    .filter ==
                                                                'Carrousel') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if (_model
                                                            .mouseRegionHovered4) {
                                                          return const Color(
                                                              0x4D83B4FF);
                                                        } else {
                                                          return Colors
                                                              .transparent;
                                                        }
                                                      }(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999.0),
                                                      border: Border.all(
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Carrousel') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF1D415C);
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Carrousel') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF4F87C9);
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Carrousel') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  2.0,
                                                                  15.0,
                                                                  2.0),
                                                      child: Text(
                                                        'Carrousel',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if ((_model.filter ==
                                                                            'Carrousel') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'Carrousel') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'Carrousel') &&
                                                                        ((Theme.of(context).brightness ==
                                                                                Brightness.light) ==
                                                                            true)) {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                                cursor: MouseCursor.defer ??
                                                    MouseCursor.defer,
                                                onEnter: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered5 =
                                                      true);
                                                }),
                                                onExit: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered5 =
                                                      false);
                                                }),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.filter = 'Text';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'Text') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if ((_model
                                                                    .filter ==
                                                                'Text') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if (_model
                                                            .mouseRegionHovered5) {
                                                          return const Color(
                                                              0x4D83B4FF);
                                                        } else {
                                                          return Colors
                                                              .transparent;
                                                        }
                                                      }(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999.0),
                                                      border: Border.all(
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF1D415C);
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF4F87C9);
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  2.0,
                                                                  15.0,
                                                                  2.0),
                                                      child: Text(
                                                        'Text',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if ((_model.filter ==
                                                                            'Text') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'Text') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'Text') &&
                                                                        ((Theme.of(context).brightness ==
                                                                                Brightness.light) ==
                                                                            true)) {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                                cursor: MouseCursor.defer ??
                                                    MouseCursor.defer,
                                                onEnter: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered6 =
                                                      true);
                                                }),
                                                onExit: ((event) async {
                                                  safeSetState(() => _model
                                                          .mouseRegionHovered6 =
                                                      false);
                                                }),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.filter = 'Reviews';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'Reviews') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if ((_model
                                                                    .filter ==
                                                                'Reviews') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
                                                        } else if (_model
                                                            .mouseRegionHovered6) {
                                                          return const Color(
                                                              0x4D83B4FF);
                                                        } else {
                                                          return Colors
                                                              .transparent;
                                                        }
                                                      }(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999.0),
                                                      border: Border.all(
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Reviews') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF1D415C);
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Reviews') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF4F87C9);
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Reviews') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  2.0,
                                                                  15.0,
                                                                  2.0),
                                                      child: Text(
                                                        'Reviews',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if ((_model.filter ==
                                                                            'Reviews') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'Reviews') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'Reviews') &&
                                                                        ((Theme.of(context).brightness ==
                                                                                Brightness.light) ==
                                                                            true)) {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFF8D99AE);
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 600.0,
                                            decoration: const BoxDecoration(),
                                            child: FutureBuilder<
                                                List<RequestsRow>>(
                                              future: RequestsTable().queryRows(
                                                queryFn: (q) => q,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitRipple(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<RequestsRow>
                                                    wrapRequestsRowList =
                                                    snapshot.data!;

                                                return Wrap(
                                                  spacing: 20.0,
                                                  runSpacing: 20.0,
                                                  alignment:
                                                      WrapAlignment.start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  direction: Axis.horizontal,
                                                  runAlignment:
                                                      WrapAlignment.start,
                                                  verticalDirection:
                                                      VerticalDirection.down,
                                                  clipBehavior: Clip.none,
                                                  children: List.generate(
                                                      wrapRequestsRowList
                                                          .length, (wrapIndex) {
                                                    final wrapRequestsRow =
                                                        wrapRequestsRowList[
                                                            wrapIndex];
                                                    return CardPostDesktopWidget(
                                                      key: Key(
                                                          'Keytw2_${wrapIndex}_of_${wrapRequestsRowList.length}'),
                                                    );
                                                  }),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ].divide(const SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Visibility(
                  visible: responsiveVisibility(
                    context: context,
                    desktop: false,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xFF222831),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          desktop: false,
                        ))
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 80.0,
                            decoration: const BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.mobileAppBarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const MobileAppBarWidget(
                                bgTrans: true,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 15.0, 10.0, 15.0),
                          child: wrapWithModel(
                            model: _model.customerDashboardMenuModel,
                            updateCallback: () => safeSetState(() {}),
                            child: CustomerDashboardMenuWidget(
                              navBarMobi: ClientBar.posts.name,
                              changePageAction: (pageName) async {},
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            decoration: const BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: Container(
                                      height: 45.0,
                                      decoration: BoxDecoration(
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.light) ==
                                                true
                                            ? const Color(0xFFEEEEEE)
                                            : const Color(0xFF31363F),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Posts',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .customColor38,
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 7.0, 0.0),
                                            child: Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0x4D4F87C9),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 1.0, 0.0),
                                                child: Icon(
                                                  FFIcons.kmedalStar,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor46,
                                                  size: 25.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        MouseRegion(
                                          opaque: false,
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered7 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered7 = false);
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
                                                  if ((_model.filter ==
                                                          'All') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'All') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered7) {
                                                    return const Color(0x4D83B4FF);
                                                  } else {
                                                    return Colors.transparent;
                                                  }
                                                }(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                border: Border.all(
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
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 2.0, 15.0, 2.0),
                                                child: Text(
                                                  'All',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'All') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'All') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered8 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered8 = false);
                                          }),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.filter = 'Contacts';
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Contacts') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'Contacts') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered8) {
                                                    return const Color(0x4D83B4FF);
                                                  } else {
                                                    return Colors.transparent;
                                                  }
                                                }(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                border: Border.all(
                                                  color: () {
                                                    if ((_model.filter ==
                                                            'Contacts') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .light) ==
                                                            true)) {
                                                      return const Color(0xFF1D415C);
                                                    } else if ((_model.filter ==
                                                            'Contacts') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .dark) ==
                                                            true)) {
                                                      return const Color(0xFF4F87C9);
                                                    } else if ((_model.filter !=
                                                            'Contacts') &&
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
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 2.0, 15.0, 2.0),
                                                child: Text(
                                                  'Videos',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Contacts') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Contacts') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Contacts') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered9 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered9 = false);
                                          }),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.filter = 'Image';
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Image') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'Image') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered9) {
                                                    return const Color(0x4D83B4FF);
                                                  } else {
                                                    return Colors.transparent;
                                                  }
                                                }(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                border: Border.all(
                                                  color: () {
                                                    if ((_model.filter ==
                                                            'Business') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .light) ==
                                                            true)) {
                                                      return const Color(0xFF1D415C);
                                                    } else if ((_model.filter ==
                                                            'Business') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .dark) ==
                                                            true)) {
                                                      return const Color(0xFF4F87C9);
                                                    } else if ((_model.filter !=
                                                            'Business') &&
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
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 2.0, 15.0, 2.0),
                                                child: Text(
                                                  'Image',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Image') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Image') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Image') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered10 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered10 = false);
                                          }),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.filter = 'Carrousel';
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Carrousel') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'Carrousel') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered10) {
                                                    return const Color(0x4D83B4FF);
                                                  } else {
                                                    return Colors.transparent;
                                                  }
                                                }(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                border: Border.all(
                                                  color: () {
                                                    if ((_model.filter ==
                                                            'Carrousel') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .light) ==
                                                            true)) {
                                                      return const Color(0xFF1D415C);
                                                    } else if ((_model.filter ==
                                                            'Carrousel') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .dark) ==
                                                            true)) {
                                                      return const Color(0xFF4F87C9);
                                                    } else if ((_model.filter !=
                                                            'Carrousel') &&
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
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 2.0, 15.0, 2.0),
                                                child: Text(
                                                  'Carrousel',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Carrousel') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Carrousel') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Carrousel') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered11 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered11 = false);
                                          }),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.filter = 'Text';
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Text') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'Text') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered11) {
                                                    return const Color(0x4D83B4FF);
                                                  } else {
                                                    return Colors.transparent;
                                                  }
                                                }(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                border: Border.all(
                                                  color: () {
                                                    if ((_model.filter ==
                                                            'Business') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .light) ==
                                                            true)) {
                                                      return const Color(0xFF1D415C);
                                                    } else if ((_model.filter ==
                                                            'Business') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .dark) ==
                                                            true)) {
                                                      return const Color(0xFF4F87C9);
                                                    } else if ((_model.filter !=
                                                            'Business') &&
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
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 2.0, 15.0, 2.0),
                                                child: Text(
                                                  'Text',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Text') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Text') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Text') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                          cursor: MouseCursor.defer ??
                                              MouseCursor.defer,
                                          onEnter: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered12 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered12 = false);
                                          }),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.filter = 'Reviews';
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Reviews') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'Reviews') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered12) {
                                                    return const Color(0x4D83B4FF);
                                                  } else {
                                                    return Colors.transparent;
                                                  }
                                                }(),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        999.0),
                                                border: Border.all(
                                                  color: () {
                                                    if ((_model.filter ==
                                                            'Reviews') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .light) ==
                                                            true)) {
                                                      return const Color(0xFF1D415C);
                                                    } else if ((_model.filter ==
                                                            'Reviews') &&
                                                        ((Theme.of(context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .dark) ==
                                                            true)) {
                                                      return const Color(0xFF4F87C9);
                                                    } else if ((_model.filter !=
                                                            'Reviews') &&
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
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 2.0, 15.0, 2.0),
                                                child: Text(
                                                  'Reviews',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if ((_model.filter ==
                                                                  'Reviews') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Reviews') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter !=
                                                                  'Reviews') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          } else {
                                                            return const Color(
                                                                0xFF8D99AE);
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                          .divide(const SizedBox(width: 5.0))
                                          .addToStart(const SizedBox(width: 10.0)),
                                    ),
                                  ),
                                  FutureBuilder<List<RequestsRow>>(
                                    future: RequestsTable().queryRows(
                                      queryFn: (q) => q,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: SpinKitRipple(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 50.0,
                                            ),
                                          ),
                                        );
                                      }
                                      List<RequestsRow> columnRequestsRowList =
                                          snapshot.data!;

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            columnRequestsRowList.length,
                                            (columnIndex) {
                                          final columnRequestsRow =
                                              columnRequestsRowList[
                                                  columnIndex];
                                          return CardPostMobileWidget(
                                            key: Key(
                                                'Keynsk_${columnIndex}_of_${columnRequestsRowList.length}'),
                                          );
                                        }).divide(const SizedBox(height: 15.0)),
                                      );
                                    },
                                  ),
                                ].divide(const SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                        ),
                        if (responsiveVisibility(
                          context: context,
                          desktop: false,
                        ))
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 45.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              height: 80.0,
                              decoration: const BoxDecoration(
                                color: Color(0x0083B4FF),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  wrapWithModel(
                                    model: _model.mobileNavBarModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const MobileNavBarWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
