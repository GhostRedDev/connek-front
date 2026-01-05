import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/dropdown_user_menu/dropdown_user_menu_widget.dart';
import '/generic/notifications/notifications_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'desktop_header_model.dart';
export 'desktop_header_model.dart';

class DesktopHeaderWidget extends StatefulWidget {
  const DesktopHeaderWidget({
    super.key,
    required this.moduleName,
    this.bgTrans,
    this.blur,
  });

  final String? moduleName;
  final bool? bgTrans;
  final bool? blur;

  @override
  State<DesktopHeaderWidget> createState() => _DesktopHeaderWidgetState();
}

class _DesktopHeaderWidgetState extends State<DesktopHeaderWidget> {
  late DesktopHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DesktopHeaderModel());

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

    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            () {
              if (widget.bgTrans == true) {
                return Colors.transparent;
              } else if (widget.blur == true) {
                return const Color(0x33EEEEEE);
              } else if ((Theme.of(context).brightness == Brightness.dark) ==
                  true) {
                return const Color(0xFF222831);
              } else {
                return FlutterFlowTheme.of(context).secondaryBackground;
              }
            }(),
            FlutterFlowTheme.of(context).primary100,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(HomePageWidget.routeName);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/conneck_logo_white.png'
                          : 'assets/images/conneck_logo_dark.png',
                      height: 45.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: Container(
                width: 450.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).neutral100,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).green400,
                    width: 2.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().pageSelected = Pages.home;
                          safeSetState(() {});
                        },
                        child: Container(
                          width: 110.0,
                          height: 76.0,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              FFAppState().pageSelected == Pages.home
                                  ? const Color(0x4D4F87C9)
                                  : const Color(0x008D99AE),
                              const Color(0x008D99AE),
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FFIcons.kiconSearch,
                                color: valueOrDefault<Color>(
                                  FFAppState().pageSelected == Pages.home
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .customColor32,
                                  FlutterFlowTheme.of(context).accent1,
                                ),
                                size: 24.0,
                              ),
                              Text(
                                'Search',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: valueOrDefault<Color>(
                                        FFAppState().pageSelected == Pages.home
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .customColor32,
                                        FlutterFlowTheme.of(context).accent1,
                                      ),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ]
                                .divide(const SizedBox(width: 5.0))
                                .addToStart(const SizedBox(width: 5.0))
                                .addToEnd(const SizedBox(width: 5.0)),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().pageSelected = Pages.social;
                          safeSetState(() {});
                        },
                        child: Container(
                          width: 110.0,
                          height: 76.0,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              FFAppState().pageSelected == Pages.social
                                  ? const Color(0x4D4F87C9)
                                  : const Color(0x008D99AE),
                              const Color(0x008D99AE),
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FFIcons.kiconsFeed,
                                color: valueOrDefault<Color>(
                                  FFAppState().pageSelected == Pages.social
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .customColor32,
                                  FlutterFlowTheme.of(context).accent1,
                                ),
                                size: 24.0,
                              ),
                              Text(
                                'Feed',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: valueOrDefault<Color>(
                                        FFAppState().pageSelected ==
                                                Pages.social
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .customColor32,
                                        FlutterFlowTheme.of(context).accent1,
                                      ),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ]
                                .divide(const SizedBox(width: 5.0))
                                .addToStart(const SizedBox(width: 5.0))
                                .addToEnd(const SizedBox(width: 5.0)),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().pageSelected = Pages.client;
                          safeSetState(() {});
                        },
                        child: Container(
                          width: 110.0,
                          height: 76.0,
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              FFAppState().pageSelected == Pages.client
                                  ? const Color(0x4D4F87C9)
                                  : const Color(0x008D99AE),
                              const Color(0x008D99AE),
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 1.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FFIcons.kiconsClient,
                                  color: valueOrDefault<Color>(
                                    FFAppState().pageSelected == Pages.client
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .customColor32,
                                    FlutterFlowTheme.of(context).accent1,
                                  ),
                                  size: 24.0,
                                ),
                                Text(
                                  'Client',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                        ),
                                        color: valueOrDefault<Color>(
                                          FFAppState().pageSelected ==
                                                  Pages.client
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .customColor32,
                                          FlutterFlowTheme.of(context).accent1,
                                        ),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 5.0))
                                  .addToStart(const SizedBox(width: 5.0))
                                  .addToEnd(const SizedBox(width: 5.0)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 110.0,
                        height: 76.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            FFAppState().pageSelected == Pages.business
                                ? const Color(0x4D4F87C9)
                                : const Color(0x008D99AE),
                            const Color(0x4D4F87C9),
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FFIcons.kiconsMybusiness,
                              color: valueOrDefault<Color>(
                                FFAppState().pageSelected == Pages.business
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context)
                                        .customColor32,
                                FlutterFlowTheme.of(context).primary,
                              ),
                              size: 24.0,
                            ),
                            Text(
                              'My business',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      FFAppState().pageSelected ==
                                              Pages.business
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .customColor32,
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ]
                              .divide(const SizedBox(width: 5.0))
                              .addToStart(const SizedBox(width: 5.0))
                              .addToEnd(const SizedBox(width: 5.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 115.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).neutral100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).accent1,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: const AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: const NotificationsWidget(),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                FFIcons.kbell,
                                color: FlutterFlowTheme.of(context).yellow100,
                                size: 24.0,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(ChatPageWidget.routeName);
                            },
                            child: Icon(
                              FFIcons.ksms,
                              color: FlutterFlowTheme.of(context).yellow100,
                              size: 22.0,
                            ),
                          ),
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: const AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: const DropdownUserMenuWidget(),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/889/600',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 10.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Container(
                  width: 110.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0x191D415C)
                        : const Color(0x1983B4FF),
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setDarkModeSetting(context, ThemeMode.dark);
                            },
                            child: Container(
                              width: 115.0,
                              height: 115.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color(0x00FFFFFF)
                                    : const Color(0xFF83B4FF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0x00F8EEEE),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (Theme.of(context).brightness ==
                                          Brightness.dark) {
                                        return const FaIcon(
                                          FontAwesomeIcons.solidMoon,
                                          color: Color(0xFF1D415C),
                                          size: 28.0,
                                        );
                                      } else {
                                        return const FaIcon(
                                          FontAwesomeIcons.moon,
                                          color: Color(0xFF1D415C),
                                          size: 28.0,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setDarkModeSetting(context, ThemeMode.light);
                            },
                            child: Container(
                              width: 115.0,
                              height: 115.0,
                              decoration: BoxDecoration(
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark) ==
                                        true
                                    ? const Color(0x00FFFFFF)
                                    : const Color(0xFF83B4FF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (Theme.of(context).brightness ==
                                          Brightness.light) {
                                        return const Icon(
                                          FFIcons.ksun,
                                          color: Color(0xFF1D415C),
                                          size: 28.0,
                                        );
                                      } else {
                                        return Icon(
                                          FFIcons.ksun,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 28.0,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ].addToStart(const SizedBox(width: 10.0)).addToEnd(const SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}
