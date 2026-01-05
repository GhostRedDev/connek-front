import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import '/mile_stone3/customer_dashboard_menu/customer_dashboard_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'client_dashboard_chats_model.dart';
export 'client_dashboard_chats_model.dart';

class ClientDashboardChatsWidget extends StatefulWidget {
  const ClientDashboardChatsWidget({super.key});

  static String routeName = 'ClientDashboardChats';
  static String routePath = 'clientDashboardChats';

  @override
  State<ClientDashboardChatsWidget> createState() =>
      _ClientDashboardChatsWidgetState();
}

class _ClientDashboardChatsWidgetState
    extends State<ClientDashboardChatsWidget> {
  late ClientDashboardChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientDashboardChatsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
                                    navSelected: 'Chats',
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
                                                  'Chats',
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
                                                      FFIcons.kmessage05,
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
                                                        'Contacts',
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
                                                    _model.filter = 'Business';
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: () {
                                                        if ((_model.filter ==
                                                                'Business') &&
                                                            ((Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light) ==
                                                                true)) {
                                                          return const Color(
                                                              0xFF4F87C9);
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
                                                        'Business',
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
                                                                            'Business') &&
                                                                        ((Theme.of(context).brightness == Brightness.light) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter ==
                                                                            'Business') &&
                                                                        ((Theme.of(context).brightness == Brightness.dark) ==
                                                                            true)) {
                                                                      return Colors
                                                                          .white;
                                                                    } else if ((_model.filter !=
                                                                            'Business') &&
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

                                        // fix HEIGHT
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 600.0,
                                            decoration: const BoxDecoration(),
                                            child: Builder(
                                              builder: (context) {
                                                final exampleList = FFAppState()
                                                    .exampleNumberList
                                                    .toList();

                                                return SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        exampleList.length,
                                                        (exampleListIndex) {
                                                      final exampleListItem =
                                                          exampleList[
                                                              exampleListIndex];
                                                      return Container(
                                                        height: 81.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          5.0,
                                                                          10.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Stack(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            1.7,
                                                                            1.0),
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image:
                                                                                Image.network(
                                                                              'https://i.pravatar.cc/150?img=12',
                                                                            ).image,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(9999.0),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              15.0,
                                                                          height:
                                                                              15.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                const Color(0xFF00D73B),
                                                                            boxShadow: const [
                                                                              BoxShadow(
                                                                                blurRadius: 4.0,
                                                                                color: Color(0xFF00D73B),
                                                                                offset: Offset(
                                                                                  0.0,
                                                                                  2.0,
                                                                                ),
                                                                              )
                                                                            ],
                                                                            borderRadius:
                                                                                BorderRadius.circular(9999.0),
                                                                          ),
                                                                          alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              1.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              if (responsiveVisibility(
                                                                                context: context,
                                                                                phone: false,
                                                                                tablet: false,
                                                                                tabletLandscape: false,
                                                                                desktop: false,
                                                                              ))
                                                                                const Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Icon(
                                                                                    FFIcons.kheart2,
                                                                                    color: Color(0xFFEEEEEE),
                                                                                    size: 18.0,
                                                                                  ),
                                                                                ),
                                                                              if (responsiveVisibility(
                                                                                context: context,
                                                                                phone: false,
                                                                                tablet: false,
                                                                                tabletLandscape: false,
                                                                                desktop: false,
                                                                              ))
                                                                                const Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Icon(
                                                                                    FFIcons.kshare,
                                                                                    color: Color(0xFFEEEEEE),
                                                                                    size: 18.0,
                                                                                  ),
                                                                                ),
                                                                              if (responsiveVisibility(
                                                                                context: context,
                                                                                phone: false,
                                                                                tablet: false,
                                                                                tabletLandscape: false,
                                                                                desktop: false,
                                                                              ))
                                                                                const Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Icon(
                                                                                    FFIcons.kfriend,
                                                                                    color: Color(0xFFEEEEEE),
                                                                                    size: 18.0,
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Text(
                                                                            'Jacob Jones',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  font: GoogleFonts.outfit(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            'Commented on your post “Como diseñar en Figma” dfvdfsvfvdfv',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: const Color(0xFF8D99AE),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ].divide(const SizedBox(height: 5.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        120.0,
                                                                    height:
                                                                        60.0,
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          '1 hour ago',
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: const Color(0xFF4F87C9),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            _model.filter =
                                                                                'Declined';
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.0,
                                                                            height:
                                                                                25.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: const Color(0x4D83B4FF),
                                                                              borderRadius: BorderRadius.circular(999.0),
                                                                              border: Border.all(
                                                                                color: Colors.transparent,
                                                                                width: 0.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.business,
                                                                                  color: Color(0xFF8D99AE),
                                                                                  size: 20.0,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                  child: Text(
                                                                                    'Business',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: const Color(0xFF8D99AE),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(const SizedBox(width: 5.0)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ].divide(const SizedBox(
                                                                              height: 5.0)),
                                                                    ),
                                                                  ),
                                                                ].divide(const SizedBox(
                                                                    width:
                                                                        10.0)),
                                                              ),
                                                            ),
                                                            const Divider(
                                                              thickness: 1.0,
                                                              color: Color(
                                                                  0xB2C4C7CD),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).divide(
                                                        const SizedBox(height: 0.0)),
                                                  ),
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
                              navBarMobi: ClientBar.chats.name,
                              changePageAction: (pageName) async {},
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
                                  10.0, 0.0, 10.0, 30.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
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
                                              'Chats',
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
                                                  FFIcons.kbell,
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
                                    Row(
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
                                                .mouseRegionHovered4 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered4 = false);
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
                                                      .mouseRegionHovered4) {
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
                                                .mouseRegionHovered5 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered5 = false);
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
                                                      .mouseRegionHovered5) {
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
                                                  'Contacts',
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
                                                .mouseRegionHovered6 = true);
                                          }),
                                          onExit: ((event) async {
                                            safeSetState(() => _model
                                                .mouseRegionHovered6 = false);
                                          }),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.filter = 'Business';
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: () {
                                                  if ((_model.filter ==
                                                          'Business') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .light) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if ((_model.filter ==
                                                          'Business') &&
                                                      ((Theme.of(context)
                                                                  .brightness ==
                                                              Brightness
                                                                  .dark) ==
                                                          true)) {
                                                    return const Color(0xFF4F87C9);
                                                  } else if (_model
                                                      .mouseRegionHovered6) {
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
                                                  'Business',
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
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light) ==
                                                                  true)) {
                                                            return Colors.white;
                                                          } else if ((_model
                                                                      .filter ==
                                                                  'Business') &&
                                                              ((Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark) ==
                                                                  true)) {
                                                            return Colors.white;
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
                                      ].divide(const SizedBox(width: 5.0)),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final exampleList = FFAppState()
                                            .exampleNumberList
                                            .toList();

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children:
                                              List.generate(exampleList.length,
                                                  (exampleListIndex) {
                                            final exampleListItem =
                                                exampleList[exampleListIndex];
                                            return Container(
                                              height: 81.0,
                                              decoration: const BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 5.0,
                                                                10.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  1.7, 1.0),
                                                          children: [
                                                            Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: Image
                                                                      .network(
                                                                    'https://i.pravatar.cc/150?img=12',
                                                                  ).image,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9999.0),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFF00D73B),
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          4.0,
                                                                      color: Color(
                                                                          0xFF00D73B),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9999.0),
                                                                ),
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                      tabletLandscape:
                                                                          false,
                                                                      desktop:
                                                                          false,
                                                                    ))
                                                                      const Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kheart2,
                                                                          color:
                                                                              Color(0xFFEEEEEE),
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                      ),
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                      tabletLandscape:
                                                                          false,
                                                                      desktop:
                                                                          false,
                                                                    ))
                                                                      const Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kshare,
                                                                          color:
                                                                              Color(0xFFEEEEEE),
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                      ),
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                      tabletLandscape:
                                                                          false,
                                                                      desktop:
                                                                          false,
                                                                    ))
                                                                      const Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kfriend,
                                                                          color:
                                                                              Color(0xFFEEEEEE),
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Jacob Jones',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .outfit(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  'Commented on your post “Como diseñar en Figma” dfvdfsvfvdfv',
                                                                  maxLines: 1,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: const Color(
                                                                            0xFF8D99AE),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(const SizedBox(
                                                                  height: 5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120.0,
                                                          height: 60.0,
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                '1 hour ago',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: const Color(
                                                                          0xFF4F87C9),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  _model.filter =
                                                                      'Declined';
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 100.0,
                                                                  height: 25.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0x4D83B4FF),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            999.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width:
                                                                          0.0,
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .business,
                                                                        color: Color(
                                                                            0xFF8D99AE),
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            2.0,
                                                                            0.0,
                                                                            2.0),
                                                                        child:
                                                                            Text(
                                                                          'Business',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: const Color(0xFF8D99AE),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ].divide(const SizedBox(
                                                                        width:
                                                                            5.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(const SizedBox(
                                                                height: 5.0)),
                                                          ),
                                                        ),
                                                      ].divide(const SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 1.0,
                                                    color: Color(0xB2C4C7CD),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).divide(const SizedBox(height: 0.0)),
                                        );
                                      },
                                    ),
                                  ].divide(const SizedBox(height: 10.0)),
                                ),
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
