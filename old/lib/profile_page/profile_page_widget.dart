import '/backend/schema/enums/enums.dart';
import '/components/business_profile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/business_profile_profile/business_profile_profile_widget.dart';
import '/m10_profile/business_profile_settings/business_profile_settings_widget.dart';
import '/m10_profile/client_profile_profile/client_profile_profile_widget.dart';
import '/m10_profile/client_profile_settings/client_profile_settings_widget.dart';
import '/m10_profile/profile_media/profile_media_widget.dart';
import '/m10_profile/profile_menu/profile_menu_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'ProfilePage';
  static String routePath = 'profilePage';

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());

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
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              desktop: false,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
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
                        if (FFAppState().profilePage == ProfilePages.reviews)
                          Expanded(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            ),
                          ),
                        if (false)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessProfileProfileModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessProfileProfileWidget(),
                            ),
                          ),
                        if ((FFAppState().profilePage ==
                                ProfilePages.profile) &&
                            FFAppState().account.isBusiness)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessProfileModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessProfileWidget(),
                            ),
                          ),
                        if (FFAppState().profilePage == ProfilePages.media)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.profileMediaModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ProfileMediaWidget(),
                            ),
                          ),
                        if ((FFAppState().profilePage ==
                                ProfilePages.profile) &&
                            !FFAppState().account.isBusiness)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.clientProfileProfileModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ClientProfileProfileWidget(),
                            ),
                          ),
                        if ((FFAppState().profilePage ==
                                ProfilePages.settings) &&
                            FFAppState().account.isBusiness)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.businessProfileSettingsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const BusinessProfileSettingsWidget(),
                            ),
                          ),
                        if ((FFAppState().profilePage ==
                                ProfilePages.settings) &&
                            !FFAppState().account.isBusiness)
                          Expanded(
                            child: wrapWithModel(
                              model: _model.clientProfileSettingsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ClientProfileSettingsWidget(),
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
                              height: 139.0,
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
                                    model: _model.profileMenuModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const ProfileMenuWidget(),
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
