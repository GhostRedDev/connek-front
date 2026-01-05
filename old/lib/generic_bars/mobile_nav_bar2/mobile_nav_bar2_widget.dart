import '/auth/base_auth_user_provider.dart';
import '/backend/schema/enums/enums.dart';
import '/components/nav_bar_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mobile_nav_bar2_model.dart';
export 'mobile_nav_bar2_model.dart';

class MobileNavBar2Widget extends StatefulWidget {
  const MobileNavBar2Widget({super.key});

  @override
  State<MobileNavBar2Widget> createState() => _MobileNavBar2WidgetState();
}

class _MobileNavBar2WidgetState extends State<MobileNavBar2Widget> {
  late MobileNavBar2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MobileNavBar2Model());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Container(
            width: 432.0,
            height: 67.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 12.0,
                        sigmaY: 12.0,
                      ),
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).navBg,
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(
                            color:
                                FlutterFlowTheme.of(context).secondaryAlpha10,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              2.0, 2.0, 2.0, 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.clientOptionModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: NavBarOptionWidget(
                                    active: FFAppState().pageSelected ==
                                        Pages.client,
                                    text: 'Buy',
                                    icon: Icon(
                                      FFIcons.kbag,
                                      color: valueOrDefault<Color>(
                                        FFAppState().pageSelected ==
                                                Pages.client
                                            ? FlutterFlowTheme.of(context)
                                                .primary100
                                            : FlutterFlowTheme.of(context)
                                                .secondary300,
                                        const Color(0x008D99AE),
                                      ),
                                    ),
                                    tapAction: () async {
                                      FFAppState().pageSelected = Pages.client;
                                      safeSetState(() {});

                                      context.pushNamed(
                                        ClientPageWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.businessOptionModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: NavBarOptionWidget(
                                    active: FFAppState().pageSelected ==
                                        Pages.business,
                                    text: 'Sell',
                                    icon: Icon(
                                      FFIcons.kbusiness,
                                      color: valueOrDefault<Color>(
                                        FFAppState().pageSelected ==
                                                Pages.business
                                            ? FlutterFlowTheme.of(context)
                                                .primary100
                                            : FlutterFlowTheme.of(context)
                                                .secondary300,
                                        const Color(0x008D99AE),
                                      ),
                                    ),
                                    tapAction: () async {
                                      FFAppState().pageSelected =
                                          Pages.business;
                                      safeSetState(() {});
                                      if (FFAppState().account.isBusiness &&
                                          (FFAppState().account.businessId !=
                                              0)) {
                                        context.pushNamed(
                                          BusinessPageWidget.routeName,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      } else {
                                        context.goNamed(
                                          CreateBusiness0CoverWidget.routeName,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              if (FFAppState().account.isBusiness)
                                Expanded(
                                  child: wrapWithModel(
                                    model: _model.officeOptionModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NavBarOptionWidget(
                                      active: FFAppState().pageSelected ==
                                          Pages.employees,
                                      text: 'Oficina',
                                      icon: Icon(
                                        FFIcons.kmisbots,
                                        color: valueOrDefault<Color>(
                                          FFAppState().pageSelected ==
                                                  Pages.employees
                                              ? FlutterFlowTheme.of(context)
                                                  .primary100
                                              : FlutterFlowTheme.of(context)
                                                  .secondary300,
                                          const Color(0x008D99AE),
                                        ),
                                      ),
                                      tapAction: () async {
                                        FFAppState().pageSelected =
                                            Pages.employees;
                                        safeSetState(() {});
                                        if (FFAppState().account.isBusiness &&
                                            (FFAppState().account.businessId !=
                                                0)) {
                                          context.pushNamed(
                                            OfficePageWidget.routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 0),
                                              ),
                                            },
                                          );
                                        } else {
                                          await action_blocks.errorSnackbar(
                                            context,
                                            message: 'Need to be business',
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.profileOptionModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: NavBarOptionWidget(
                                    active: FFAppState().pageSelected ==
                                        Pages.profile,
                                    text: 'Profile',
                                    icon: Icon(
                                      FFIcons.kuserv,
                                      color: valueOrDefault<Color>(
                                        FFAppState().pageSelected ==
                                                Pages.profile
                                            ? FlutterFlowTheme.of(context)
                                                .primary100
                                            : FlutterFlowTheme.of(context)
                                                .secondary300,
                                        const Color(0x008D99AE),
                                      ),
                                    ),
                                    tapAction: () async {
                                      FFAppState().pageSelected = Pages.profile;
                                      safeSetState(() {});

                                      context.pushNamed(
                                        ProfilePageWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ),
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
                    FFAppState().pageSelected = Pages.home;
                    FFAppState().update(() {});
                    if (loggedIn) {
                      context.pushNamed(
                        HomePageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    } else {
                      context.goNamed(
                        HomePageNoAuthWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    }
                  },
                  child: Container(
                    width: 67.0,
                    height: 67.0,
                    constraints: const BoxConstraints(
                      minWidth: 67.0,
                      minHeight: 67.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/Search_Icon_BG.png',
                        ).image,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Color(0x41046CFF),
                          offset: Offset(
                            0.0,
                            10.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(500.0),
                    ),
                    child: const Icon(
                      FFIcons.ksearchL,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ].divide(const SizedBox(width: 5.0)),
            ),
          ),
        ),
      ],
    );
  }
}
