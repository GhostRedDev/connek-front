import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'customer_dashboard_menu_model.dart';
export 'customer_dashboard_menu_model.dart';

class CustomerDashboardMenuWidget extends StatefulWidget {
  const CustomerDashboardMenuWidget({
    super.key,
    required this.changePageAction,
    String? navBarMobi,
  }) : navBarMobi = navBarMobi ?? 'overview';

  final Future Function(String pageName)? changePageAction;
  final String navBarMobi;

  @override
  State<CustomerDashboardMenuWidget> createState() =>
      _CustomerDashboardMenuWidgetState();
}

class _CustomerDashboardMenuWidgetState
    extends State<CustomerDashboardMenuWidget> {
  late CustomerDashboardMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerDashboardMenuModel());

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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 45.0,
                      height: 45.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://i.pravatar.cc/150?img=22',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alexnader Roja',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'alexrojas.business@gmail.com',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(1.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 7.0, 0.0),
                              child: Container(
                                width: 34.0,
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x4D4F87C9),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Icon(
                                  Icons.login_outlined,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
            child: Container(
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(
                          ClientDashboardRequestWidget.routeName,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: () {
                            if ((widget.navBarMobi ==
                                    ClientBar.requests.name) &&
                                (Theme.of(context).brightness ==
                                    Brightness.light)) {
                              return const Color(0x4C83B4FF);
                            } else if ((widget.navBarMobi ==
                                    ClientBar.requests.name) &&
                                (Theme.of(context).brightness ==
                                    Brightness.dark)) {
                              return const Color(0x2583B4FF);
                            } else {
                              return const Color(0x0083B4FF);
                            }
                          }(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              13.0, 8.0, 13.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.show_chart_sharp,
                                color: widget.navBarMobi ==
                                        ClientBar.requests.name
                                    ? const Color(0xFF4F87C9)
                                    : const Color(0xFF8D99AE),
                                size: 19.0,
                              ),
                              Text(
                                'Request',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: widget.navBarMobi ==
                                              ClientBar.requests.name
                                          ? const Color(0xFF4F87C9)
                                          : const Color(0xFF8D99AE),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: () {
                          if ((widget.navBarMobi == ClientBar.profile.name) &&
                              (Theme.of(context).brightness ==
                                  Brightness.light)) {
                            return const Color(0x4C83B4FF);
                          } else if ((widget.navBarMobi ==
                                  ClientBar.profile.name) &&
                              (Theme.of(context).brightness ==
                                  Brightness.dark)) {
                            return const Color(0x2583B4FF);
                          } else {
                            return const Color(0x0083B4FF);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            13.0, 8.0, 13.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              FFIcons.kprofile,
                              color:
                                  widget.navBarMobi == ClientBar.profile.name
                                      ? const Color(0xFF4F87C9)
                                      : const Color(0xFF8D99AE),
                              size: 19.0,
                            ),
                            Text(
                              'Profile',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: widget.navBarMobi ==
                                            ClientBar.profile.name
                                        ? const Color(0xFF4F87C9)
                                        : const Color(0xFF8D99AE),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(const SizedBox(width: 5.0)),
                        ),
                      ),
                    ),
                    if (false)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.goNamed(
                            ClientDashboardNotificationsWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: const TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );

                          safeSetState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navBarMobi ==
                                      ClientBar.notifications.name) &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navBarMobi ==
                                      ClientBar.notifications.name) &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kbell,
                                  color: widget.navBarMobi ==
                                          ClientBar.notifications.name
                                      ? const Color(0xFF4F87C9)
                                      : const Color(0xFF8D99AE),
                                  size: 19.0,
                                ),
                                Text(
                                  'Notifications',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: widget.navBarMobi ==
                                                ClientBar.notifications.name
                                            ? const Color(0xFF4F87C9)
                                            : const Color(0xFF8D99AE),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
                            ),
                          ),
                        ),
                      ),
                    if (false)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.goNamed(
                            ClientDashboardPostWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: const TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navBarMobi ==
                                      ClientBar.posts.name) &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navBarMobi ==
                                      ClientBar.posts.name) &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kmedalStar,
                                  color:
                                      widget.navBarMobi == ClientBar.posts.name
                                          ? const Color(0xFF4F87C9)
                                          : const Color(0xFF8D99AE),
                                  size: 19.0,
                                ),
                                Text(
                                  'Posts',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: widget.navBarMobi ==
                                                ClientBar.posts.name
                                            ? const Color(0xFF4F87C9)
                                            : const Color(0xFF8D99AE),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
                            ),
                          ),
                        ),
                      ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(
                          ClientDashboardWalletWidget.routeName,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: () {
                            if ((widget.navBarMobi == ClientBar.wallet.name) &&
                                (Theme.of(context).brightness ==
                                    Brightness.light)) {
                              return const Color(0x4C83B4FF);
                            } else if ((widget.navBarMobi ==
                                    ClientBar.wallet.name) &&
                                (Theme.of(context).brightness ==
                                    Brightness.dark)) {
                              return const Color(0x2583B4FF);
                            } else {
                              return const Color(0x0083B4FF);
                            }
                          }(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              13.0, 8.0, 13.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kcard,
                                color:
                                    widget.navBarMobi == ClientBar.wallet.name
                                        ? const Color(0xFF4F87C9)
                                        : const Color(0xFF8D99AE),
                                size: 19.0,
                              ),
                              Text(
                                'Payments & Wallet',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: widget.navBarMobi ==
                                              ClientBar.wallet.name
                                          ? const Color(0xFF4F87C9)
                                          : const Color(0xFF8D99AE),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: () {
                          if ((FFAppState().businessDashboardPage ==
                                  BusinessPages.settings) &&
                              (Theme.of(context).brightness ==
                                  Brightness.light)) {
                            return const Color(0x4C83B4FF);
                          } else if ((FFAppState().businessDashboardPage ==
                                  BusinessPages.settings) &&
                              (Theme.of(context).brightness ==
                                  Brightness.dark)) {
                            return const Color(0x2583B4FF);
                          } else {
                            return const Color(0x0083B4FF);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            13.0, 8.0, 13.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.settings_outlined,
                              color: FFAppState().businessDashboardPage ==
                                      BusinessPages.settings
                                  ? const Color(0xFF4F87C9)
                                  : const Color(0xFF8D99AE),
                              size: 19.0,
                            ),
                            Text(
                              'Settings',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FFAppState().businessDashboardPage ==
                                            BusinessPages.settings
                                        ? const Color(0xFF4F87C9)
                                        : const Color(0xFF8D99AE),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(const SizedBox(width: 5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
