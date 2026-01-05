import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_dashboard_menu3_model.dart';
export 'business_dashboard_menu3_model.dart';

class BusinessDashboardMenu3Widget extends StatefulWidget {
  const BusinessDashboardMenu3Widget({
    super.key,
    int? activeIndex,
    this.callBack,
  }) : activeIndex = activeIndex ?? 0;

  final int activeIndex;
  final Future Function()? callBack;

  @override
  State<BusinessDashboardMenu3Widget> createState() =>
      _BusinessDashboardMenu3WidgetState();
}

class _BusinessDashboardMenu3WidgetState
    extends State<BusinessDashboardMenu3Widget> {
  late BusinessDashboardMenu3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardMenu3Model());

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

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
              child: Container(
                decoration: const BoxDecoration(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().businessDashboardPage =
                              BusinessPages.overview;
                          safeSetState(() {});
                          await action_blocks.loadEmployeesNotHired(context);
                          await action_blocks.loadLeads(context);
                          await action_blocks.businessVerification(context);
                          await action_blocks.loadBusinessDeposit(context);
                          safeSetState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: FFAppState().businessDashboardPage ==
                                    BusinessPages.overview
                                ? FlutterFlowTheme.of(context).secondary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.bar_chart,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 19.0,
                                ),
                                Text(
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
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
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
                          FFAppState().businessDashboardPage =
                              BusinessPages.leads;
                          safeSetState(() {});
                          await action_blocks.loadLeads(context);
                          safeSetState(() {});
                          await action_blocks.loadBusinessClients(context);
                          await widget.callBack?.call();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: FFAppState().businessDashboardPage ==
                                    BusinessPages.leads
                                ? FlutterFlowTheme.of(context).secondary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.edit,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 19.0,
                                ),
                                Text(
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
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FFAppState().businessDashboardPage ==
                                  BusinessPages.leads
                              ? FlutterFlowTheme.of(context).secondary
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              13.0, 8.0, 13.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.people_alt_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 19.0,
                              ),
                              Text(
                                'Clients',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          FFAppState().businessDashboardPage =
                              BusinessPages.services;
                          safeSetState(() {});
                          await action_blocks.loadServices(context);
                          await action_blocks.loadResources(context);
                          await widget.callBack?.call();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: FFAppState().businessDashboardPage ==
                                    BusinessPages.services
                                ? FlutterFlowTheme.of(context).secondary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.boxes,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 19.0,
                                ),
                                Text(
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
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
                          FFAppState().businessDashboardPage =
                              BusinessPages.employees;
                          safeSetState(() {});
                          _model.employeesData =
                              await EmployeesTable().queryRows(
                            queryFn: (q) => q,
                          );
                          await widget.callBack?.call();

                          safeSetState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: FFAppState().businessDashboardPage ==
                                    BusinessPages.employees
                                ? FlutterFlowTheme.of(context).secondary
                                : FlutterFlowTheme.of(context)
                                    .primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.show_chart_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 19.0,
                                ),
                                Text(
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
                            ),
                          ),
                        ),
                      ),
                      if (false)
                        Container(
                          decoration: BoxDecoration(
                            color: () {
                              if ((FFAppState().businessDashboardPage ==
                                      BusinessPages.posts) &&
                                  (Theme.of(context).brightness ==
                                      Brightness.light)) {
                                return const Color(0x4C83B4FF);
                              } else if ((FFAppState().businessDashboardPage ==
                                      BusinessPages.posts) &&
                                  (Theme.of(context).brightness ==
                                      Brightness.dark)) {
                                return const Color(0x2583B4FF);
                              } else {
                                return const Color(0x0083B4FF);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                13.0, 8.0, 13.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.briefcase,
                                  color: FFAppState().businessDashboardPage ==
                                          BusinessPages.posts
                                      ? const Color(0xFF4F87C9)
                                      : const Color(0xFF8D99AE),
                                  size: 19.0,
                                ),
                                Text(
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
                                        color: FFAppState()
                                                    .businessDashboardPage ==
                                                BusinessPages.posts
                                            ? const Color(0xFF4F87C9)
                                            : const Color(0xFF8D99AE),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 5.0)),
                            ),
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          color: FFAppState().businessDashboardPage ==
                                  BusinessPages.employees
                              ? FlutterFlowTheme.of(context).secondary
                              : FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              13.0, 8.0, 13.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.sell_sharp,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 19.0,
                              ),
                              Text(
                                'Sales',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ),
                      ),
                    ]
                        .addToStart(const SizedBox(width: 10.0))
                        .addToEnd(const SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
