import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dropdown_sales_model.dart';
export 'dropdown_sales_model.dart';

class DropdownSalesWidget extends StatefulWidget {
  const DropdownSalesWidget({super.key});

  @override
  State<DropdownSalesWidget> createState() => _DropdownSalesWidgetState();
}

class _DropdownSalesWidgetState extends State<DropdownSalesWidget> {
  late DropdownSalesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropdownSalesModel());

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
      width: 153.0,
      height: 146.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                FFAppState().businessDashboardPage = BusinessPages.quotes;
                safeSetState(() {});
              },
              child: Container(
                height: 44.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FFAppState().businessDashboardPage == BusinessPages.quotes
                          ? const Color(0xFF212121)
                          : Colors.transparent,
                      FFAppState().businessDashboardPage == BusinessPages.quotes
                          ? const Color(0xFF383737)
                          : Colors.transparent
                    ],
                    stops: const [0.0, 1.0],
                    begin: const AlignmentDirectional(1.0, -0.87),
                    end: const AlignmentDirectional(-1.0, 0.87),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FFIcons.kdollarCricle,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.quotes
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                        size: 24.0,
                      ),
                      Text(
                        'Propuestas',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FFAppState().businessDashboardPage ==
                                      BusinessPages.quotes
                                  ? FlutterFlowTheme.of(context).white
                                  : FlutterFlowTheme.of(context).secondary300,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
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
                FFAppState().businessDashboardPage = BusinessPages.invoices;
                safeSetState(() {});
              },
              child: Container(
                height: 44.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FFAppState().businessDashboardPage ==
                              BusinessPages.invoices
                          ? const Color(0xFF212121)
                          : Colors.transparent,
                      FFAppState().businessDashboardPage ==
                              BusinessPages.invoices
                          ? const Color(0xFF383737)
                          : Colors.transparent
                    ],
                    stops: const [0.0, 1.0],
                    begin: const AlignmentDirectional(1.0, -0.87),
                    end: const AlignmentDirectional(-1.0, 0.87),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FFIcons.kdocLarge,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.invoices
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                        size: 24.0,
                      ),
                      Text(
                        'Facturas',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FFAppState().businessDashboardPage ==
                                      BusinessPages.invoices
                                  ? FlutterFlowTheme.of(context).white
                                  : FlutterFlowTheme.of(context).secondary300,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
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
                FFAppState().businessDashboardPage = BusinessPages.bookings;
                safeSetState(() {});
              },
              child: Container(
                height: 44.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FFAppState().businessDashboardPage ==
                              BusinessPages.bookings
                          ? const Color(0xFF212121)
                          : Colors.transparent,
                      FFAppState().businessDashboardPage ==
                              BusinessPages.bookings
                          ? const Color(0xFF383737)
                          : Colors.transparent
                    ],
                    stops: const [0.0, 1.0],
                    begin: const AlignmentDirectional(1.0, -0.87),
                    end: const AlignmentDirectional(-1.0, 0.87),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FFIcons.kbooking,
                        color: FFAppState().businessDashboardPage ==
                                BusinessPages.bookings
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).secondary300,
                        size: 24.0,
                      ),
                      Text(
                        'Bookings',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FFAppState().businessDashboardPage ==
                                      BusinessPages.bookings
                                  ? FlutterFlowTheme.of(context).white
                                  : FlutterFlowTheme.of(context).secondary300,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
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
          ],
        ),
      ),
    );
  }
}
