import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'side_bar_desktop_model.dart';
export 'side_bar_desktop_model.dart';

class SideBarDesktopWidget extends StatefulWidget {
  const SideBarDesktopWidget({
    super.key,
    required this.navSelected,
  });

  final String? navSelected;

  @override
  State<SideBarDesktopWidget> createState() => _SideBarDesktopWidgetState();
}

class _SideBarDesktopWidgetState extends State<SideBarDesktopWidget> {
  late SideBarDesktopModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SideBarDesktopModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: responsiveVisibility(
        context: context,
        phone: false,
        tablet: false,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 270.0,
        height: double.infinity,
        decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.light) == true
              ? const Color(0xFFEEEEEE)
              : const Color(0xFF31363F),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(20.0),
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(20.0),
          ),
          border: Border.all(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: 270.0,
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          maxHeight: 70.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0x1A222526)
                                  : const Color(0x4D222526),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/Ellipse_11.png',
                                  height: 200.0,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200.0,
                                      decoration: const BoxDecoration(),
                                      child: Visibility(
                                        visible: responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ),
                                        child: Text(
                                          'AR Design & Commerce',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF222831)
                                                    : const Color(0xFFEEEEEE),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 200.0,
                                      decoration: const BoxDecoration(),
                                      child: Visibility(
                                        visible: responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ),
                                        child: Text(
                                          'Web Designer',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF1D415C)
                                                    : const Color(0xFFC4C7CD),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered1 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered1 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 270.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navSelected == 'Overview') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navSelected == 'Overview') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(5.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 6.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kchart,
                                  color: () {
                                    if (widget.navSelected == 'Overview') {
                                      return FlutterFlowTheme.of(context)
                                          .primary;
                                    } else if ((widget.navSelected !=
                                            'Overview') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.light)) {
                                      return const Color(0xFF8D99AE);
                                    } else if ((widget.navSelected !=
                                            'Overview') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.dark)) {
                                      return Colors.white;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .secondaryText;
                                    }
                                  }(),
                                  size: 24.0,
                                ),
                                if ((widget.navSelected != 'Overview') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Overview',
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
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF8D99AE)
                                                    : Colors.white,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                if ((widget.navSelected == 'Overview') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Overview',
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
                                                .primary,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered2 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered2 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 270.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navSelected == 'Leads') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navSelected == 'Leads') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(5.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 6.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kedit,
                                  color: () {
                                    if (widget.navSelected == 'Leads') {
                                      return FlutterFlowTheme.of(context)
                                          .primary;
                                    } else if ((widget.navSelected !=
                                            'Leads') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.light)) {
                                      return const Color(0xFF8D99AE);
                                    } else if ((widget.navSelected !=
                                            'Leads') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.dark)) {
                                      return Colors.white;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .secondaryText;
                                    }
                                  }(),
                                  size: 24.0,
                                ),
                                if ((widget.navSelected != 'Leads') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Leads',
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
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF8D99AE)
                                                    : Colors.white,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                if ((widget.navSelected == 'Leads') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Leads',
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
                                                .primary,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered3 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered3 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 270.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navSelected == 'Employees') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navSelected == 'Employees') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(5.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 6.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.goNamed(
                                  BusinessDashboardEmployeeWidget.routeName,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    FFIcons.kemployess,
                                    color: () {
                                      if (widget.navSelected == 'Employees') {
                                        return FlutterFlowTheme.of(context)
                                            .primary;
                                      } else if ((widget.navSelected !=
                                              'Employees') &&
                                          (Theme.of(context).brightness ==
                                              Brightness.light)) {
                                        return const Color(0xFF8D99AE);
                                      } else if ((widget.navSelected !=
                                              'Employees') &&
                                          (Theme.of(context).brightness ==
                                              Brightness.dark)) {
                                        return Colors.white;
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .secondaryText;
                                      }
                                    }(),
                                    size: 24.0,
                                  ),
                                  if ((widget.navSelected != 'Employees') &&
                                      responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                      ))
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Employees',
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
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const Color(0xFF8D99AE)
                                                  : Colors.white,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  if ((widget.navSelected == 'Employees') &&
                                      responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                      ))
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Employees',
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered4 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered4 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.goNamed(
                              BusinessDashboardServicesWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            width: 270.0,
                            height: 39.0,
                            decoration: BoxDecoration(
                              color: () {
                                if ((widget.navSelected == 'Services') &&
                                    (Theme.of(context).brightness ==
                                        Brightness.light)) {
                                  return const Color(0x4C83B4FF);
                                } else if ((widget.navSelected ==
                                        'Services') &&
                                    (Theme.of(context).brightness ==
                                        Brightness.dark)) {
                                  return const Color(0x2583B4FF);
                                } else {
                                  return const Color(0x0083B4FF);
                                }
                              }(),
                              borderRadius: BorderRadius.circular(5.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 6.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    FFIcons.kservices,
                                    color: () {
                                      if (widget.navSelected == 'Services') {
                                        return FlutterFlowTheme.of(context)
                                            .primary;
                                      } else if ((widget.navSelected !=
                                              'Services') &&
                                          (Theme.of(context).brightness ==
                                              Brightness.light)) {
                                        return const Color(0xFF8D99AE);
                                      } else if ((widget.navSelected !=
                                              'Posts') &&
                                          (Theme.of(context).brightness ==
                                              Brightness.dark)) {
                                        return Colors.white;
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .secondaryText;
                                      }
                                    }(),
                                    size: 24.0,
                                  ),
                                  if ((widget.navSelected != 'Services') &&
                                      responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                      ))
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Services',
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
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const Color(0xFF8D99AE)
                                                  : Colors.white,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  if ((widget.navSelected == 'Services') &&
                                      responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                      ))
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Services',
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered5 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered5 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 270.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navSelected == 'Posts') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navSelected == 'Posts') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(5.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 6.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kposts,
                                  color: () {
                                    if (widget.navSelected == 'Posts') {
                                      return FlutterFlowTheme.of(context)
                                          .primary;
                                    } else if ((widget.navSelected !=
                                            'Posts') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.light)) {
                                      return const Color(0xFF8D99AE);
                                    } else if ((widget.navSelected !=
                                            'Posts') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.dark)) {
                                      return Colors.white;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .secondaryText;
                                    }
                                  }(),
                                  size: 24.0,
                                ),
                                if ((widget.navSelected != 'Posts') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
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
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF8D99AE)
                                                    : Colors.white,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                if ((widget.navSelected == 'Posts') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
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
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered6 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered6 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 270.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navSelected == 'Profile') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navSelected == 'Profile') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(5.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 6.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kprofile,
                                  color: () {
                                    if (widget.navSelected == 'Profile') {
                                      return FlutterFlowTheme.of(context)
                                          .primary;
                                    } else if ((widget.navSelected !=
                                            'Profile') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.light)) {
                                      return const Color(0xFF8D99AE);
                                    } else if ((widget.navSelected !=
                                            'Profile') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.dark)) {
                                      return Colors.white;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .secondaryText;
                                    }
                                  }(),
                                  size: 24.0,
                                ),
                                if ((widget.navSelected != 'Profile') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Profile',
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
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF8D99AE)
                                                    : Colors.white,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                if ((widget.navSelected == 'Profile') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Profile',
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
                                                .primary,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      opaque: false,
                      cursor: MouseCursor.defer ?? MouseCursor.defer,
                      onEnter: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered7 = true);
                      }),
                      onExit: ((event) async {
                        safeSetState(() => _model.mouseRegionHovered7 = false);
                      }),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 270.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: () {
                              if ((widget.navSelected == 'Settings') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((widget.navSelected == 'Settings') &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(5.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 6.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.settings_outlined,
                                  color: () {
                                    if (widget.navSelected == 'Settings') {
                                      return FlutterFlowTheme.of(context)
                                          .primary;
                                    } else if ((widget.navSelected !=
                                            'Settings') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.light)) {
                                      return const Color(0xFF8D99AE);
                                    } else if ((widget.navSelected !=
                                            'Settings') &&
                                        (Theme.of(context).brightness ==
                                            Brightness.dark)) {
                                      return Colors.white;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .secondaryText;
                                    }
                                  }(),
                                  size: 24.0,
                                ),
                                if ((widget.navSelected != 'Settings') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Settings',
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
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF8D99AE)
                                                    : Colors.white,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                if ((widget.navSelected == 'Settings') &&
                                    responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Settings',
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
                                                .primary,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                      .divide(const SizedBox(height: 8.0))
                      .addToStart(const SizedBox(height: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
