import '/backend/schema/enums/enums.dart';
import '/components/business_bookings_widget.dart';
import '/components/business_clients_widget.dart';
import '/components/business_empleados_widget.dart';
import '/components/business_factura_widget.dart';
import '/components/business_leads_widget.dart';
import '/components/business_overview_widget.dart';
import '/components/business_profile_widget.dart';
import '/components/business_services_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/business_menu/business_menu_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'business_page_model.dart';
export 'business_page_model.dart';

class BusinessPageWidget extends StatefulWidget {
  const BusinessPageWidget({super.key});

  static String routeName = 'BusinessPage';
  static String routePath = 'businessPage';

  @override
  State<BusinessPageWidget> createState() => _BusinessPageWidgetState();
}

class _BusinessPageWidgetState extends State<BusinessPageWidget> {
  late BusinessPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessPageModel());

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
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.overview)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessOverviewModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessOverviewWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.clients)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessClientsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessClientsWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.leads)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessLeadsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessLeadsWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.services)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessServicesModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessServicesWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.employees)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessEmpleadosModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessEmpleadosWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.profile)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessProfileModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessProfileWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.invoices)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessFacturaModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessFacturaWidget(),
                            ),
                          ),
                        if (FFAppState().businessDashboardPage ==
                            BusinessPages.bookings)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessBookingsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessBookingsWidget(),
                            ),
                          ),
                      ].addToEnd(const SizedBox(height: 1.0)),
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
                                    model: _model.businessMenuModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const BusinessMenuWidget(),
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
