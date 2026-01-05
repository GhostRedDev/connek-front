import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'client_menu_model.dart';
export 'client_menu_model.dart';

class ClientMenuWidget extends StatefulWidget {
  const ClientMenuWidget({super.key});

  @override
  State<ClientMenuWidget> createState() => _ClientMenuWidgetState();
}

class _ClientMenuWidgetState extends State<ClientMenuWidget> {
  late ClientMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientMenuModel());

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
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              wrapWithModel(
                model: _model.requestsModel,
                updateCallback: () => safeSetState(() {}),
                child: TopMenuOptionWidget(
                  active:
                      FFAppState().clientDashboardPage == ClientPages.requests,
                  icon: Icon(
                    FFIcons.kuserv,
                    color: valueOrDefault<Color>(
                      FFAppState().clientDashboardPage == ClientPages.requests
                          ? FlutterFlowTheme.of(context).white
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).secondary300,
                    ),
                  ),
                  name: 'Requests',
                  tapAction: () async {
                    unawaited(
                      () async {
                        await action_blocks.loadRequests(context);
                      }(),
                    );
                    FFAppState().clientRequestQuotes = [];
                    FFAppState().clientRequestLeadIds = [];
                    FFAppState().clientRequestBusinesses = [];
                    FFAppState().clientRequestAcceptedQuote =
                        ClientRequestQuoteStruct();
                    FFAppState().clientRequestAcceptedBusiness =
                        BusinessDataStruct();
                    FFAppState().pageSelected = Pages.client;
                    FFAppState().clientDashboardPage = ClientPages.requests;
                    FFAppState().update(() {});
                  },
                ),
              ),
              wrapWithModel(
                model: _model.bookingsModel,
                updateCallback: () => safeSetState(() {}),
                child: TopMenuOptionWidget(
                  active:
                      FFAppState().clientDashboardPage == ClientPages.bookings,
                  icon: Icon(
                    FFIcons.kbooking,
                    color: valueOrDefault<Color>(
                      FFAppState().clientDashboardPage == ClientPages.bookings
                          ? FlutterFlowTheme.of(context).white
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).secondary300,
                    ),
                  ),
                  name: 'Bookings',
                  tapAction: () async {
                    unawaited(
                      () async {
                        await action_blocks.loadBookings(context);
                      }(),
                    );
                    FFAppState().clientDashboardPage = ClientPages.bookings;
                    FFAppState().pageSelected = Pages.client;
                    _model.updatePage(() {});
                  },
                ),
              ),
              wrapWithModel(
                model: _model.bookmarksModel,
                updateCallback: () => safeSetState(() {}),
                child: TopMenuOptionWidget(
                  active:
                      FFAppState().clientDashboardPage == ClientPages.bookmark,
                  icon: Icon(
                    FFIcons.kreceipSquare,
                    color: valueOrDefault<Color>(
                      FFAppState().clientDashboardPage == ClientPages.bookmark
                          ? FlutterFlowTheme.of(context).white
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).secondary300,
                    ),
                  ),
                  name: 'Bookmarks',
                  tapAction: () async {
                    FFAppState().clientDashboardPage = ClientPages.bookmark;
                    FFAppState().pageSelected = Pages.client;
                    _model.updatePage(() {});
                  },
                ),
              ),
              wrapWithModel(
                model: _model.walletModel,
                updateCallback: () => safeSetState(() {}),
                child: TopMenuOptionWidget(
                  active:
                      FFAppState().clientDashboardPage == ClientPages.wallet,
                  icon: Icon(
                    FFIcons.kdollarCircle,
                    color: valueOrDefault<Color>(
                      FFAppState().clientDashboardPage == ClientPages.wallet
                          ? FlutterFlowTheme.of(context).white
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).secondary300,
                    ),
                  ),
                  name: 'Wallet',
                  tapAction: () async {
                    FFAppState().clientDashboardPage = ClientPages.wallet;
                    FFAppState().pageSelected = Pages.client;
                    _model.updatePage(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
