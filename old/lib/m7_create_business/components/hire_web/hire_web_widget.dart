import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/m7_create_business/components/hire_detail/hire_detail_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'hire_web_model.dart';
export 'hire_web_model.dart';

class HireWebWidget extends StatefulWidget {
  const HireWebWidget({
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
  State<HireWebWidget> createState() => _HireWebWidgetState();
}

class _HireWebWidgetState extends State<HireWebWidget> {
  late HireWebModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HireWebModel());

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
            const Color(0xFFEEEEEE),
            () {
              if (widget.id == '0') {
                return const Color(0xFF7DC94F);
              } else if (widget.id == '1') {
                return const Color(0xFF4F87C9);
              } else if (widget.id == '2') {
                return const Color(0xFFC9744F);
              } else if (widget.id == '3') {
                return const Color(0xFF854FC9);
              } else {
                return const Color(0xFFBABEC5);
              }
            }()
          ],
          stops: const [0.0, 1.0],
          begin: const AlignmentDirectional(-1.0, -0.87),
          end: const AlignmentDirectional(1.0, 0.87),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
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
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999.0),
                        child: Image.network(
                          'https://picsum.photos/seed/501/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AutoSizeText(
                                      'Name',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
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
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 15.0)),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              child: AutoSizeText(
                                'Description Description  Description Description  Description Description  Description Description  Description Description  Description Description  Description Description  Description Description ',
                                maxLines: 3,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
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
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
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
                                          begin:
                                              const AlignmentDirectional(1.0, 0.87),
                                          end:
                                              const AlignmentDirectional(-1.0, -0.87),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          _model.stripeCheckout =
                                              await StripeGroup
                                                  .employeeSubscribeCall
                                                  .call(
                                            businessId:
                                                FFAppState().account.businessId,
                                          );

                                          if ((_model
                                                  .stripeCheckout?.succeeded ??
                                              true)) {
                                            if (getJsonField(
                                              (_model.stripeCheckout
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.success''',
                                            )) {
                                              await launchURL(getJsonField(
                                                (_model.stripeCheckout
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.data.redirect_url''',
                                              ).toString());
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Something went wrong.',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.outfit(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 3000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
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
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconColor: const Color(0xFF222831),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryAlpha30,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: const Color(0xFF222831),
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
                                          elevation: 0.0,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 180.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0x1A83B4FF),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      const AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: SizedBox(
                                                    height: 518.0,
                                                    width: 662.0,
                                                    child: HireDetailWidget(
                                                      borderColor:
                                                          const Color(0x00000000),
                                                      bgGradient1:
                                                          const Color(0x00000000),
                                                      bgGradient2:
                                                          const Color(0x00000000),
                                                      id: widget.id!,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: 'Learn More',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryAlpha30,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.outfit(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 10.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ].divide(const SizedBox(height: 2.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
