import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'office_train_header_model.dart';
export 'office_train_header_model.dart';

class OfficeTrainHeaderWidget extends StatefulWidget {
  const OfficeTrainHeaderWidget({super.key});

  @override
  State<OfficeTrainHeaderWidget> createState() =>
      _OfficeTrainHeaderWidgetState();
}

class _OfficeTrainHeaderWidgetState extends State<OfficeTrainHeaderWidget> {
  late OfficeTrainHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OfficeTrainHeaderModel());

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
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FFButtonWidget(
            onPressed: () async {
              FFAppState().officeDashboardPage = OfficePages.myBots;
              FFAppState().update(() {});
            },
            text: 'Mis bots',
            icon: const Icon(
              FFIcons.karrowBack,
              size: 15.0,
            ),
            options: FFButtonOptions(
              height: 40.0,
              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 15.0, 8.0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              iconColor: FlutterFlowTheme.of(context).neutral100,
              color: FlutterFlowTheme.of(context).secondaryAlpha10,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).neutral100,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
              elevation: 0.0,
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).secondaryAlpha10,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(1000.0),
              hoverColor: FlutterFlowTheme.of(context).primary,
              hoverTextColor: FlutterFlowTheme.of(context).primaryText,
              hoverElevation: 1.0,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Greg',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    width: 33.0,
                    height: 33.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).bg2Sec,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/Greg_BG.png',
                          ).image,
                        ),
                      ),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/Greg_Card_M.png',
                            ).image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ].divide(const SizedBox(width: 7.0)),
            ),
          ),
        ],
      ),
    );
  }
}
