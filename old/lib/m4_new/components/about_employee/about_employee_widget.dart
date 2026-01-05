import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about_employee_model.dart';
export 'about_employee_model.dart';

class AboutEmployeeWidget extends StatefulWidget {
  const AboutEmployeeWidget({
    super.key,
    required this.id,
  });

  final String? id;

  @override
  State<AboutEmployeeWidget> createState() => _AboutEmployeeWidgetState();
}

class _AboutEmployeeWidgetState extends State<AboutEmployeeWidget> {
  late AboutEmployeeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutEmployeeModel());

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
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF31363F),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            desktop: false,
                          ))
                            Container(
                              width: 70.0,
                              height: 70.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/501/600',
                                fit: BoxFit.cover,
                              ),
                            ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'About Name',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return 20.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return 20.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return 20.0;
                                      } else {
                                        return 24.0;
                                      }
                                    }(),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Description Description  Description Description  Description Description  Description Description  Description Description  Description Description  Description Description  Description Description scription  Description Description  Description Description  Description Description scription  Description Description  Description Description  Description Description ',
                              maxLines: 5,
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
                          Text(
                            'Features',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Builder(
                              builder: (context) {
                                final listExampleSkills =
                                    FFAppState().examplesIDlist.toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(listExampleSkills.length,
                                          (listExampleSkillsIndex) {
                                    final listExampleSkillsItem =
                                        listExampleSkills[
                                            listExampleSkillsIndex];
                                    return Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryAlpha30,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              color: Color(0xFF2EE72E),
                                              size: 24.0,
                                            ),
                                            Flexible(
                                              child: Text(
                                                '24/7',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                          ].divide(const SizedBox(width: 5.0)),
                                        ),
                                      ),
                                    );
                                  }).divide(const SizedBox(height: 5.0)),
                                );
                              },
                            ),
                          ),
                        ].divide(const SizedBox(height: 5.0)),
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                    ))
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                'https://picsum.photos/seed/501/600',
                                height: 220.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      ),
                  ],
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
                      child: AutoSizeText(
                        '\$Price',
                        style: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .override(
                              font: GoogleFonts.outfit(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .fontStyle,
                              ),
                              fontSize: () {
                                if (MediaQuery.sizeOf(context).width <
                                    kBreakpointSmall) {
                                  return 24.0;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointMedium) {
                                  return 24.0;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointLarge) {
                                  return 24.0;
                                } else {
                                  return 32.0;
                                }
                              }(),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .fontStyle,
                            ),
                      ),
                    ),
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
                                  begin: const AlignmentDirectional(1.0, 0.87),
                                  end: const AlignmentDirectional(-1.0, -0.87),
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  _model.stripeCheckout = await StripeGroup
                                      .employeeSubscribeCall
                                      .call(
                                    businessId: FFAppState().account.businessId,
                                  );

                                  if ((_model.stripeCheckout?.succeeded ??
                                      true)) {
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
                                                    FlutterFlowTheme.of(context)
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
                                icon: const Icon(
                                  Icons.add,
                                  size: 28.0,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconColor: const Color(0xFF222831),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryAlpha30,
                                  textStyle: FlutterFlowTheme.of(context)
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
                                        color: const Color(0xFF222831),
                                        fontSize: 18.0,
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
    );
  }
}
