import '/backend/schema/enums/enums.dart';
import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'office_menu_model.dart';
export 'office_menu_model.dart';

class OfficeMenuWidget extends StatefulWidget {
  const OfficeMenuWidget({super.key});

  @override
  State<OfficeMenuWidget> createState() => _OfficeMenuWidgetState();
}

class _OfficeMenuWidgetState extends State<OfficeMenuWidget> {
  late OfficeMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfficeMenuModel());

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
              if (false)
                wrapWithModel(
                  model: _model.overviewModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TopMenuOptionWidget(
                    active: FFAppState().officeDashboardPage ==
                        OfficePages.overview,
                    icon: Icon(
                      Icons.query_stats,
                      color: valueOrDefault<Color>(
                        FFAppState().officeDashboardPage == OfficePages.overview
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                        FlutterFlowTheme.of(context).secondary300,
                      ),
                    ),
                    name: 'Overview',
                    tapAction: () async {
                      FFAppState().pageSelected = Pages.employees;
                      FFAppState().officeDashboardPage = OfficePages.overview;
                      _model.updatePage(() {});
                    },
                  ),
                ),
              wrapWithModel(
                model: _model.myBotsModel,
                updateCallback: () => safeSetState(() {}),
                child: TopMenuOptionWidget(
                  active: (FFAppState().officeDashboardPage ==
                          OfficePages.myBots) ||
                      (FFAppState().officeDashboardPage ==
                          OfficePages.trainGreg) ||
                      (FFAppState().officeDashboardPage ==
                          OfficePages.gregSettings),
                  icon: Icon(
                    Icons.new_label,
                    color: valueOrDefault<Color>(
                      (FFAppState().officeDashboardPage ==
                                  OfficePages.myBots) ||
                              (FFAppState().officeDashboardPage ==
                                  OfficePages.trainGreg) ||
                              (FFAppState().officeDashboardPage ==
                                  OfficePages.gregSettings)
                          ? FlutterFlowTheme.of(context).white
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).secondary300,
                    ),
                  ),
                  name: 'My bots',
                  tapAction: () async {
                    FFAppState().pageSelected = Pages.employees;
                    FFAppState().officeDashboardPage = OfficePages.myBots;
                    _model.updatePage(() {});
                  },
                ),
              ),
              if (false)
                wrapWithModel(
                  model: _model.clientsModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TopMenuOptionWidget(
                    active: FFAppState().officeDashboardPage ==
                        OfficePages.analytics,
                    icon: Icon(
                      Icons.people_alt_rounded,
                      color: valueOrDefault<Color>(
                        FFAppState().officeDashboardPage ==
                                OfficePages.analytics
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                        FlutterFlowTheme.of(context).secondary300,
                      ),
                    ),
                    name: 'Analytics',
                    tapAction: () async {
                      FFAppState().pageSelected = Pages.employees;
                      FFAppState().officeDashboardPage = OfficePages.analytics;
                      _model.updatePage(() {});
                    },
                  ),
                ),
              wrapWithModel(
                model: _model.servicesModel,
                updateCallback: () => safeSetState(() {}),
                child: TopMenuOptionWidget(
                  active: FFAppState().officeDashboardPage ==
                      OfficePages.marketplace,
                  icon: Icon(
                    Icons.people_alt_rounded,
                    color: valueOrDefault<Color>(
                      FFAppState().officeDashboardPage ==
                              OfficePages.marketplace
                          ? FlutterFlowTheme.of(context).white
                          : FlutterFlowTheme.of(context).secondary300,
                      FlutterFlowTheme.of(context).secondary300,
                    ),
                  ),
                  name: 'Marketplace',
                  tapAction: () async {
                    FFAppState().pageSelected = Pages.employees;
                    FFAppState().officeDashboardPage = OfficePages.marketplace;
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
