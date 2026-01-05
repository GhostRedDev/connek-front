import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_sheet_compartir_perfil_model.dart';
export 'bottom_sheet_compartir_perfil_model.dart';

class BottomSheetCompartirPerfilWidget extends StatefulWidget {
  const BottomSheetCompartirPerfilWidget({super.key});

  @override
  State<BottomSheetCompartirPerfilWidget> createState() =>
      _BottomSheetCompartirPerfilWidgetState();
}

class _BottomSheetCompartirPerfilWidgetState
    extends State<BottomSheetCompartirPerfilWidget> {
  late BottomSheetCompartirPerfilModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomSheetCompartirPerfilModel());

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

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(0.0),
        bottomRight: Radius.circular(0.0),
        topLeft: Radius.circular(49.0),
        topRight: Radius.circular(49.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).bg1Sec,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/mesh-gradient_(7).png',
            ).image,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(49.0),
            topRight: Radius.circular(49.0),
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 85.0,
                        decoration: const BoxDecoration(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SvgPicture.asset(
                              'assets/images/Connek_Light.svg',
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: 398.0,
                            height: 398.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).navBg,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              valueOrDefault<String>(
                                functions.urlStorageFile('business',
                                    '${FFAppState().account.businessId.toString()}/${FFAppState().businessData.profileImage}'),
                                'https://img.freepik.com/premium-vector/creative-elegant-abstract-minimalistic-logo-design-vector-any-brand-company_1253202-137644.jpg?semt=ais_hybrid&w=740&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              FFAppState().businessData.name,
                              'My Business Name',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(
                                  text:
                                      'connek.ca/business/${FFAppState().account.businessId.toString()}'));
                            },
                            text: 'Copy to clipboard',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 45.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 8.0, 15.0, 8.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0xFF0D1B2A),
                              textStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(1000.0),
                              hoverColor:
                                  FlutterFlowTheme.of(context).primaryAlpha10,
                              hoverElevation: 1.0,
                            ),
                          ),
                        ].divide(const SizedBox(height: 10.0)),
                      ),
                      Container(
                        width: double.infinity,
                        height: 149.0,
                        decoration: const BoxDecoration(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 139.0,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SvgPicture.asset(
                          'assets/images/SeparatorBottomSheet.svg',
                          fit: BoxFit.none,
                          alignment: const Alignment(0.0, -1.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).neutralAlpha10,
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryAlpha10,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Icon(
                                  FFIcons.kcloseLine,
                                  color: FlutterFlowTheme.of(context).white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(const SizedBox(height: 30.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
