import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'customer_dashboard_menu2_model.dart';
export 'customer_dashboard_menu2_model.dart';

class CustomerDashboardMenu2Widget extends StatefulWidget {
  const CustomerDashboardMenu2Widget({
    super.key,
    required this.changePageAction,
    String? navBarMobi,
    this.requestAction,
  }) : navBarMobi = navBarMobi ?? 'overview';

  final Future Function(String pageName)? changePageAction;
  final String navBarMobi;
  final Future Function()? requestAction;

  @override
  State<CustomerDashboardMenu2Widget> createState() =>
      _CustomerDashboardMenu2WidgetState();
}

class _CustomerDashboardMenu2WidgetState
    extends State<CustomerDashboardMenu2Widget> {
  late CustomerDashboardMenu2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomerDashboardMenu2Model());

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

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
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
                          FFAppState().clientRequestQuotes = [];
                          FFAppState().clientRequestLeadIds = [];
                          FFAppState().clientRequestBusinesses = [];
                          FFAppState().clientRequestAcceptedQuote =
                              ClientRequestQuoteStruct();
                          FFAppState().clientRequestAcceptedBusiness =
                              BusinessDataStruct();
                          FFAppState().pageSelected = Pages.client;
                          FFAppState().clientDashboardPage =
                              ClientPages.requests;
                          FFAppState().update(() {});
                          await action_blocks.loadRequests(context);
                          await widget.requestAction?.call();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: FFAppState().clientDashboardPage ==
                                    ClientPages.requests
                                ? FlutterFlowTheme.of(context).secondary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.show_chart_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 19.0,
                                ),
                                Text(
                                  'Request',
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
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
                          FFAppState().pageSelected = Pages.client;
                          FFAppState().clientDashboardPage = ClientPages.wallet;
                          FFAppState().update(() {});
                          await action_blocks.loadPayments(context);
                          safeSetState(() {});
                          await action_blocks.loadBalances(context);
                          safeSetState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: FFAppState().clientDashboardPage ==
                                    ClientPages.wallet
                                ? FlutterFlowTheme.of(context).secondary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kcard,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 19.0,
                                ),
                                Text(
                                  'Payments & Wallet',
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
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
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                    color: widget.navBarMobi ==
                                            ClientBar.posts.name
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
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 5.0)),
                              ),
                            ),
                          ),
                        ),
                    ]
                        .addToStart(const SizedBox(width: 10.0))
                        .addToEnd(const SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
