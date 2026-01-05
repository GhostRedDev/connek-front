import '/backend/schema/enums/enums.dart';
import '/components/office_analytics_widget.dart';
import '/components/office_marketplace_widget.dart';
import '/components/office_my_bots_widget.dart';
import '/components/office_overview_widget.dart';
import '/components/office_settings_greg_widget.dart';
import '/components/office_train_greg_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/office_menu/office_menu_widget.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'office_page_model.dart';
export 'office_page_model.dart';

class OfficePageWidget extends StatefulWidget {
  const OfficePageWidget({super.key});

  static String routeName = 'OfficePage';
  static String routePath = 'officePage';

  @override
  State<OfficePageWidget> createState() => _OfficePageWidgetState();
}

class _OfficePageWidgetState extends State<OfficePageWidget> {
  late OfficePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfficePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await action_blocks.loadGreg(context);
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
                        if (FFAppState().officeDashboardPage ==
                            OfficePages.overview)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.officeOverviewModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const OfficeOverviewWidget(),
                            ),
                          ),
                        if (FFAppState().officeDashboardPage ==
                            OfficePages.myBots)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.officeMyBotsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const OfficeMyBotsWidget(),
                            ),
                          ),
                        if (FFAppState().officeDashboardPage ==
                            OfficePages.marketplace)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.officeMarketplaceModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const OfficeMarketplaceWidget(),
                            ),
                          ),
                        if (FFAppState().officeDashboardPage ==
                            OfficePages.analytics)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.officeAnalyticsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const OfficeAnalyticsWidget(),
                            ),
                          ),
                        if (FFAppState().officeDashboardPage ==
                            OfficePages.gregSettings)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.officeSettingsGregModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const OfficeSettingsGregWidget(),
                            ),
                          ),
                        if (FFAppState().officeDashboardPage ==
                            OfficePages.trainGreg)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.officeTrainGregModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const OfficeTrainGregWidget(),
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
                                    model: _model.officeMenuModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const OfficeMenuWidget(),
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
