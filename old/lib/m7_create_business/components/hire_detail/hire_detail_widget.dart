import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'hire_detail_model.dart';
export 'hire_detail_model.dart';

class HireDetailWidget extends StatefulWidget {
  const HireDetailWidget({
    super.key,
    Color? borderColor,
    Color? bgGradient1,
    Color? bgGradient2,
    required this.id,
  })  : borderColor = borderColor ?? const Color(0xA882CDFF),
        bgGradient1 = bgGradient1 ?? const Color(0x9A82CDFF),
        bgGradient2 = bgGradient2 ?? const Color(0x4C95A1AC);

  final Color borderColor;
  final Color bgGradient1;
  final Color bgGradient2;
  final String? id;

  @override
  State<HireDetailWidget> createState() => _HireDetailWidgetState();
}

class _HireDetailWidgetState extends State<HireDetailWidget> {
  late HireDetailModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HireDetailModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(
          valueOrDefault<double>(
            () {
              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                return 10.0;
              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                return 10.0;
              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                return 10.0;
              } else {
                return 2.0;
              }
            }(),
            0.0,
          ),
          0.0,
          valueOrDefault<double>(
            () {
              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                return 10.0;
              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                return 10.0;
              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                return 10.0;
              } else {
                return 2.0;
              }
            }(),
            0.0,
          ),
          0.0),
      child: Container(
        width: 662.0,
        height: 518.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999.0),
                  child: Image.network(
                    'https://picsum.photos/seed/501/600',
                    width: 75.0,
                    height: 75.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Name',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: () {
                                if (widget.id == '0') {
                                  return const Color(0xFF9BBE7F);
                                } else if (widget.id == '1') {
                                  return const Color(0xFF8DA5C4);
                                } else if (widget.id == '2') {
                                  return const Color(0xFFDB9F82);
                                } else if (widget.id == '3') {
                                  return const Color(0xFF8268B0);
                                } else {
                                  return const Color(0xFFBABEC5);
                                }
                              }(),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                            ),
                      ),
                      AutoSizeText(
                        '24/7 Assistant',
                        maxLines: 3,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ],
                  ),
                ),
              ]
                  .divide(const SizedBox(width: 15.0))
                  .addToStart(const SizedBox(width: 20.0))
                  .addToEnd(const SizedBox(width: 20.0)),
            ),
            Container(
              height: 45.0,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: AutoSizeText(
                  'Description Description  Description Description  Description Description  Description Description  Description Description  Description Description  Description Description  Description Description xcscxscs',
                  maxLines: 3,
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
              ),
            ),
            Container(
              width: double.infinity,
              height: 240.0,
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 194.0,
                      height: 240.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      width: 194.0,
                      height: 240.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      width: 194.0,
                      height: 240.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      width: 194.0,
                      height: 240.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ]
                      .divide(const SizedBox(width: 10.0))
                      .addToStart(const SizedBox(width: 20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
              child: RichText(
                textScaler: MediaQuery.of(context).textScaler,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    const TextSpan(
                      text: '50/',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                      ),
                    ),
                    const TextSpan(
                      text: 'month',
                      style: TextStyle(),
                    )
                  ],
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                maxLines: 3,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 180.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          () {
                            if (widget.id == '0') {
                              return const Color(0xFFCDDCBF);
                            } else if (widget.id == '1') {
                              return const Color(0xFF92A5BE);
                            } else if (widget.id == '2') {
                              return const Color(0xFFE3CCC0);
                            } else if (widget.id == '3') {
                              return const Color(0xFFDACBF1);
                            } else {
                              return const Color(0xFFBABEC5);
                            }
                          }(),
                          () {
                            if (widget.id == '0') {
                              return const Color(0xFFADD39C);
                            } else if (widget.id == '1') {
                              return const Color(0xFFA5C5F3);
                            } else if (widget.id == '2') {
                              return const Color(0xFFEEB9A5);
                            } else if (widget.id == '3') {
                              return const Color(0xFFA693D2);
                            } else {
                              return const Color(0xFFBABEC5);
                            }
                          }(),
                          () {
                            if (widget.id == '0') {
                              return const Color(0xFFADD39C);
                            } else if (widget.id == '1') {
                              return const Color(0xFF8EB3E9);
                            } else if (widget.id == '2') {
                              return const Color(0xFFEEB9A5);
                            } else if (widget.id == '3') {
                              return const Color(0xFFA693D2);
                            } else {
                              return const Color(0xFFBABEC5);
                            }
                          }(),
                          () {
                            if (widget.id == '0') {
                              return const Color(0xFF9BBE7F);
                            } else if (widget.id == '1') {
                              return const Color(0xFF8DA5C4);
                            } else if (widget.id == '2') {
                              return const Color(0xFFDB9F82);
                            } else if (widget.id == '3') {
                              return const Color(0xFF8268B0);
                            } else {
                              return const Color(0xFFBABEC5);
                            }
                          }()
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                        begin: const AlignmentDirectional(1.0, 0.87),
                        end: const AlignmentDirectional(-1.0, -0.87),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: FFButtonWidget(
                      onPressed: () async {
                        _model.stripeCheckout =
                            await StripeGroup.employeeSubscribeCall.call(
                          businessId: FFAppState().account.businessId,
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                      text: 'Hire',
                      icon: const Icon(
                        Icons.add,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconColor: const Color(0xFF222831),
                        color: FlutterFlowTheme.of(context).secondaryAlpha30,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: const Color(0xFF222831),
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
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: const Color(0x1A83B4FF),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Close',
                        options: FFButtonOptions(
                          height: 36.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondaryAlpha30,
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
                                color: FlutterFlowTheme.of(context).primaryText,
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
                ),
              ]
                  .divide(const SizedBox(width: 10.0))
                  .addToStart(const SizedBox(width: 20.0))
                  .addToEnd(const SizedBox(width: 20.0)),
            ),
          ]
              .divide(const SizedBox(height: 15.0))
              .addToStart(const SizedBox(height: 10.0))
              .addToEnd(const SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
