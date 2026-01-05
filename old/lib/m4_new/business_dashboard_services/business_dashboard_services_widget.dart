import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/business_services_o_l_d_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/business_dashboard_menu2/business_dashboard_menu2_widget.dart';
import '/m4_new/components/business_dashboard_menu/business_dashboard_menu_widget.dart';
import '/m4_new/components/footer/footer_widget.dart';
import '/m4_new/components/side_bar_desktop/side_bar_desktop_widget.dart';
import '/m_ilestone4/business_dashboard_welcome/business_dashboard_welcome_widget.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'business_dashboard_services_model.dart';
export 'business_dashboard_services_model.dart';

class BusinessDashboardServicesWidget extends StatefulWidget {
  const BusinessDashboardServicesWidget({super.key});

  static String routeName = 'BusinessDashboardServices';
  static String routePath = 'businessDashboardServices';

  @override
  State<BusinessDashboardServicesWidget> createState() =>
      _BusinessDashboardServicesWidgetState();
}

class _BusinessDashboardServicesWidgetState
    extends State<BusinessDashboardServicesWidget> {
  late BusinessDashboardServicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardServicesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().businessDashboardPage = BusinessPages.services;
      safeSetState(() {});
      await action_blocks.loadServices(context);
      await action_blocks.loadResources(context);
      safeSetState(() {});
    });

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Builder(
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
                return Container(
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
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                      ))
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
                            wrapWithModel(
                              model: _model.sideBarDesktopModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const SideBarDesktopWidget(
                                navSelected: 'Services',
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 100.0,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: FutureBuilder<List<BusinessRow>>(
                                        future: BusinessTable().querySingleRow(
                                          queryFn: (q) => q.eqOrNull(
                                            'id',
                                            FFAppState().account.businessId,
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 40.0,
                                                height: 40.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<BusinessRow>
                                              containerBusinessRowList =
                                              snapshot.data!;

                                          // Return an empty Container when the item does not exist.
                                          if (snapshot.data!.isEmpty) {
                                            return Container();
                                          }
                                          final containerBusinessRow =
                                              containerBusinessRowList
                                                      .isNotEmpty
                                                  ? containerBusinessRowList
                                                      .first
                                                  : null;

                                          return Container(
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                      tabletLandscape: false,
                                                      desktop: false,
                                                    ))
                                                      wrapWithModel(
                                                        model: _model
                                                            .businessDashboardMenuModel,
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child:
                                                            BusinessDashboardMenuWidget(
                                                          changePageAction:
                                                              (pageName) async {},
                                                        ),
                                                      ),
                                                    wrapWithModel(
                                                      model: _model
                                                          .businessDashboardWelcomeModel,
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          const BusinessDashboardWelcomeWidget(
                                                        title: 'Services',
                                                        message:
                                                            'Add news, manage or edit your services.',
                                                        sunActive: false,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40.0,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          wrapWithModel(
                                                            model: _model
                                                                .footerModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                const FooterWidget(),
                                                          ),
                                                        ].divide(const SizedBox(
                                                            height: 15.0)),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(height: 15.0)),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      desktop: false,
                    ))
                      SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
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
                              if (responsiveVisibility(
                                context: context,
                                desktop: false,
                              ))
                                wrapWithModel(
                                  model: _model.businessDashboardMenu2Model,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BusinessDashboardMenu2Widget(
                                    callBack: () async {},
                                  ),
                                ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: wrapWithModel(
                                        model: _model.businessServicesOLDModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const BusinessServicesOLDWidget(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (responsiveVisibility(
                                context: context,
                                desktop: false,
                              ))
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.95,
                                  height: 80.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0x0083B4FF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      wrapWithModel(
                                        model: _model.mobileNavBarModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const MobileNavBarWidget(),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
