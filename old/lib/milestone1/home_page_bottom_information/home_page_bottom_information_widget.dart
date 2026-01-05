import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page_bottom_information_model.dart';
export 'home_page_bottom_information_model.dart';

class HomePageBottomInformationWidget extends StatefulWidget {
  const HomePageBottomInformationWidget({super.key});

  @override
  State<HomePageBottomInformationWidget> createState() =>
      _HomePageBottomInformationWidgetState();
}

class _HomePageBottomInformationWidgetState
    extends State<HomePageBottomInformationWidget> {
  late HomePageBottomInformationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageBottomInformationModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: const BoxDecoration(),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 0.0,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.vertical,
        runAlignment: WrapAlignment.center,
        verticalDirection: VerticalDirection.down,
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            width: valueOrDefault<double>(
              MediaQuery.sizeOf(context).width < kBreakpointMedium
                  ? valueOrDefault<double>(
                      MediaQuery.sizeOf(context).width,
                      1.0,
                    )
                  : valueOrDefault<double>(
                      MediaQuery.sizeOf(context).width,
                      0.30,
                    ),
              432.0,
            ),
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Terms of Use',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.0,
                      ),
                ),
                Text(
                  'Privacy Policy',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.0,
                      ),
                ),
                Text(
                  'Cookies',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.0,
                      ),
                ),
              ].divide(const SizedBox(width: 31.0)),
            ),
          ),
          Container(
            width: valueOrDefault<double>(
              MediaQuery.sizeOf(context).width < kBreakpointMedium
                  ? valueOrDefault<double>(
                      MediaQuery.sizeOf(context).width,
                      1.0,
                    )
                  : valueOrDefault<double>(
                      MediaQuery.sizeOf(context).width,
                      0.3,
                    ),
              432.0,
            ),
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'How it works',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.0,
                      ),
                ),
                Text(
                  'About',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.0,
                      ),
                ),
                Text(
                  'Contact Us',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.0,
                      ),
                ),
              ].divide(const SizedBox(width: 31.0)),
            ),
          ),
        ],
      ),
    );
  }
}
