import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'employee_hireuse_to_replace_model.dart';
export 'employee_hireuse_to_replace_model.dart';

class EmployeeHireuseToReplaceWidget extends StatefulWidget {
  const EmployeeHireuseToReplaceWidget({
    super.key,
    required this.employee,
    Color? borderColor,
    Color? bgGradient1,
    Color? bgGradient2,
    required this.id,
  })  : borderColor = borderColor ?? const Color(0xA882CDFF),
        bgGradient1 = bgGradient1 ?? const Color(0x9A82CDFF),
        bgGradient2 = bgGradient2 ?? const Color(0x4C95A1AC);

  final EmployeesRow? employee;
  final Color borderColor;
  final Color bgGradient1;
  final Color bgGradient2;
  final String? id;

  @override
  State<EmployeeHireuseToReplaceWidget> createState() =>
      _EmployeeHireuseToReplaceWidgetState();
}

class _EmployeeHireuseToReplaceWidgetState
    extends State<EmployeeHireuseToReplaceWidget> {
  late EmployeeHireuseToReplaceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmployeeHireuseToReplaceModel());

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            () {
              if (widget.id == '0') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFE4F4D6)
                    : const Color(0xFF707F6B));
              } else if (widget.id == '1') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFD1E3F8)
                    : const Color(0xFF45536B));
              } else if (widget.id == '2') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFFAE3D8)
                    : const Color(0xFF535052));
              } else if (widget.id == '3') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFE7D8FA)
                    : const Color(0xFF6E6685));
              } else {
                return const Color(0xFFBABEC5);
              }
            }(),
            () {
              if (widget.id == '0') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFF8FCF6)
                    : const Color(0xFF656D6B));
              } else if (widget.id == '1') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFEFF3F8)
                    : const Color(0xFF3F4C61));
              } else if (widget.id == '2') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFFCF6F4)
                    : const Color(0xFF3F424B));
              } else if (widget.id == '3') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFF4F2F9)
                    : const Color(0xFF595A69));
              } else {
                return const Color(0xFFBABEC5);
              }
            }(),
            () {
              if (widget.id == '0') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFF8FCF6)
                    : const Color(0xFF4F5E68));
              } else if (widget.id == '1') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFEFF3F8)
                    : const Color(0xFF444A54));
              } else if (widget.id == '2') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFFCF6F4)
                    : const Color(0xFF434E62));
              } else if (widget.id == '3') {
                return (Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFF4F2F9)
                    : const Color(0xFF4E5670));
              } else {
                return const Color(0xFFBABEC5);
              }
            }(),
            () {
              if (Theme.of(context).brightness == Brightness.light) {
                return Colors.white;
              } else if ((widget.id == '0') &&
                  (Theme.of(context).brightness == Brightness.dark)) {
                return const Color(0xFF536373);
              } else if ((widget.id == '1') &&
                  (Theme.of(context).brightness == Brightness.dark)) {
                return const Color(0xFF555F6D);
              } else if ((widget.id == '2') &&
                  (Theme.of(context).brightness == Brightness.dark)) {
                return const Color(0xFF455167);
              } else if ((widget.id == '3') &&
                  (Theme.of(context).brightness == Brightness.dark)) {
                return const Color(0xFF525D78);
              } else {
                return const Color(0x00000000);
              }
            }()
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
          begin: const AlignmentDirectional(1.0, 0.87),
          end: const AlignmentDirectional(-1.0, -0.87),
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: widget.borderColor,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999.0),
                  child: Image.network(
                    'https://picsum.photos/seed/501/600',
                    width: 55.0,
                    height: 55.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget.employee?.name,
                    'employee name',
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget.employee?.description,
                    'descrption',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
                Builder(
                  builder: (context) {
                    final listFeatures = functions
                        .stringToList(widget.employee!.skills)
                        .toList();

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listFeatures.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 5.0),
                      itemBuilder: (context, listFeaturesIndex) {
                        final listFeaturesItem =
                            listFeatures[listFeaturesIndex];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).secondaryAlpha30,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2EE72E),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(9999.0),
                                    bottomRight: Radius.circular(9999.0),
                                    topLeft: Radius.circular(9999.0),
                                    topRight: Radius.circular(9999.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 4.0, 4.0, 4.0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  listFeaturesItem,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ].divide(const SizedBox(height: 5.0)),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    formatNumber(
                      widget.employee?.price,
                      formatType: FormatType.decimal,
                      decimalType: DecimalType.automatic,
                      currency: '\$',
                    ),
                    '1',
                  ),
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontStyle,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: 180.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              valueOrDefault<Color>(
                                widget.bgGradient1,
                                FlutterFlowTheme.of(context).primary,
                              ),
                              valueOrDefault<Color>(
                                widget.bgGradient2,
                                FlutterFlowTheme.of(context).secondary,
                              )
                            ],
                            stops: const [0.0, 1.0],
                            begin: const AlignmentDirectional(0.03, -1.0),
                            end: const AlignmentDirectional(-0.03, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.stripeCheckout =
                                await StripeGroup.employeeSubscribeCall.call(
                              businessId: FFAppState().account.businessId,
                              employeeId: widget.employee?.id,
                            );

                            if ((_model.stripeCheckout?.succeeded ?? true)) {
                              if (getJsonField(
                                (_model.stripeCheckout?.jsonBody ?? ''),
                                r'''$.success''',
                              )) {
                                await launchURL(getJsonField(
                                  (_model.stripeCheckout?.jsonBody ?? ''),
                                  r'''$.data.redirect_url''',
                                ).toString());
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Something went wrong.',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                  ),
                                  duration: const Duration(milliseconds: 3000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                ),
                              );
                            }

                            safeSetState(() {});
                          },
                          text: 'Hire Greg',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).secondaryAlpha30,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 180.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Learn More',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).secondaryAlpha30,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 10.0)),
                ),
              ],
            ),
          ].divide(const SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
