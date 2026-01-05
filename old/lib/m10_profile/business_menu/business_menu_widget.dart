import '/backend/schema/enums/enums.dart';
import '/components/dropdown_sales_widget.dart';
import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'business_menu_model.dart';
export 'business_menu_model.dart';

class BusinessMenuWidget extends StatefulWidget {
  const BusinessMenuWidget({super.key});

  @override
  State<BusinessMenuWidget> createState() => _BusinessMenuWidgetState();
}

class _BusinessMenuWidgetState extends State<BusinessMenuWidget> {
  late BusinessMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessMenuModel());

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
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  wrapWithModel(
                    model: _model.overviewModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().businessDashboardPage ==
                          BusinessPages.overview,
                      icon: Icon(
                        FFIcons.kdiscover2,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.overview
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                      ),
                      name: 'Overview',
                      tapAction: () async {
                        await action_blocks.businessVerification(context);
                        await action_blocks.loadBusinessDeposit(context);
                        safeSetState(() {});
                        FFAppState().pageSelected = Pages.business;
                        FFAppState().businessDashboardPage =
                            BusinessPages.overview;
                        _model.updatePage(() {});
                      },
                    ),
                  ),
                  wrapWithModel(
                    model: _model.leadsModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().businessDashboardPage ==
                          BusinessPages.leads,
                      icon: Icon(
                        FFIcons.kflash,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.leads
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                      ),
                      name: 'Leads',
                      tapAction: () async {
                        await action_blocks.loadLeads(context);
                        FFAppState().pageSelected = Pages.business;
                        FFAppState().businessDashboardPage =
                            BusinessPages.leads;
                        safeSetState(() {});
                      },
                    ),
                  ),
                  wrapWithModel(
                    model: _model.clientsModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().businessDashboardPage ==
                          BusinessPages.clients,
                      icon: Icon(
                        FFIcons.kclientGroup,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.clients
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                      ),
                      name: 'Clients',
                      tapAction: () async {
                        FFAppState().pageSelected = Pages.business;
                        FFAppState().businessDashboardPage =
                            BusinessPages.clients;
                        FFAppState().update(() {});
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => wrapWithModel(
                      model: _model.salesModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TopMenuOptionWidget(
                        active: (FFAppState().businessDashboardPage ==
                                BusinessPages.sales) ||
                            (FFAppState().businessDashboardPage ==
                                BusinessPages.invoices) ||
                            (FFAppState().businessDashboardPage ==
                                BusinessPages.quotes),
                        icon: Icon(
                          FFIcons.kclientGroup,
                          color: (FFAppState().businessDashboardPage ==
                                      BusinessPages.bookings) ||
                                  (FFAppState().businessDashboardPage ==
                                      BusinessPages.invoices) ||
                                  (FFAppState().businessDashboardPage ==
                                      BusinessPages.quotes)
                              ? FlutterFlowTheme.of(context).white
                              : FlutterFlowTheme.of(context).secondary300,
                        ),
                        name: 'Sales',
                        tapAction: () async {
                          await showAlignedDialog(
                            context: context,
                            isGlobal: false,
                            avoidOverflow: false,
                            targetAnchor: const AlignmentDirectional(-1.0, 1.0)
                                .resolve(Directionality.of(context)),
                            followerAnchor: const AlignmentDirectional(-1.0, -1.0)
                                .resolve(Directionality.of(context)),
                            builder: (dialogContext) {
                              return const Material(
                                color: Colors.transparent,
                                child: DropdownSalesWidget(),
                              );
                            },
                          );

                          FFAppState().pageSelected = Pages.business;
                          FFAppState().businessDashboardPage =
                              BusinessPages.clients;
                          FFAppState().update(() {});
                        },
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.servicesModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().businessDashboardPage ==
                          BusinessPages.services,
                      icon: Icon(
                        FFIcons.karchive,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.services
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                      ),
                      name: 'Services',
                      tapAction: () async {
                        await action_blocks.loadServices(context);
                        await action_blocks.loadResources(context);
                        FFAppState().pageSelected = Pages.business;
                        FFAppState().businessDashboardPage =
                            BusinessPages.services;
                        safeSetState(() {});
                      },
                    ),
                  ),
                  wrapWithModel(
                    model: _model.employeesModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().businessDashboardPage ==
                          BusinessPages.employees,
                      icon: Icon(
                        FFIcons.kportfolio,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.employees
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                      ),
                      name: 'Employees',
                      tapAction: () async {
                        await action_blocks.loadResources(context);
                        FFAppState().pageSelected = Pages.business;
                        FFAppState().businessDashboardPage =
                            BusinessPages.employees;
                        safeSetState(() {});
                      },
                    ),
                  ),
                ]
                    .addToStart(const SizedBox(width: 10.0))
                    .addToEnd(const SizedBox(width: 10.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
