import '/backend/schema/enums/enums.dart';
import '/components/client_bookings_widget.dart';
import '/components/client_bookmarks_widget.dart';
import '/components/client_requests_widget.dart';
import '/components/client_wallet_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/client_menu/client_menu_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'client_page_model.dart';
export 'client_page_model.dart';

class ClientPageWidget extends StatefulWidget {
  const ClientPageWidget({super.key});

  static String routeName = 'ClientPage';
  static String routePath = 'clientPage';

  @override
  State<ClientPageWidget> createState() => _ClientPageWidgetState();
}

class _ClientPageWidgetState extends State<ClientPageWidget> {
  late ClientPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientPageModel());

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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).bg1Sec,
        body: SafeArea(
          top: true,
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              desktop: false,
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).bg1Sec,
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (FFAppState().clientDashboardPage ==
                            ClientPages.bookmark)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.clientBookmarksModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ClientBookmarksWidget(),
                            ),
                          ),
                        if (FFAppState().clientDashboardPage ==
                            ClientPages.bookings)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.clientBookingsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ClientBookingsWidget(),
                            ),
                          ),
                        if (FFAppState().clientDashboardPage ==
                            ClientPages.requests)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.clientRequestsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ClientRequestsWidget(),
                            ),
                          ),
                        if (FFAppState().clientDashboardPage ==
                            ClientPages.wallet)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.clientWalletModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ClientWalletWidget(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        width: double.infinity,
                        height: 67.0,
                        decoration: const BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.mobileNavBar2Model,
                          updateCallback: () => safeSetState(() {}),
                          child: const MobileNavBar2Widget(),
                        ),
                      ),
                    ),
                  ),
                  if (responsiveVisibility(
                    context: context,
                    desktop: false,
                  ))
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Container(
                        width: double.infinity,
                        height: 145.0,
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 20.0,
                              sigmaY: 20.0,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 145.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).navBg,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.mobileAppBarModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const MobileAppBarWidget(
                                      bgTrans: true,
                                    ),
                                  ),
                                  Divider(
                                    height: 1.0,
                                    thickness: 1.0,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryAlpha10,
                                  ),
                                  wrapWithModel(
                                    model: _model.clientMenuModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const ClientMenuWidget(),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
