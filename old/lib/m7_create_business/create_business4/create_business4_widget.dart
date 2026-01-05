import '/components/back_button_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_business4_model.dart';
export 'create_business4_model.dart';

class CreateBusiness4Widget extends StatefulWidget {
  const CreateBusiness4Widget({super.key});

  static String routeName = 'CreateBusiness4';
  static String routePath = 'createBusiness4';

  @override
  State<CreateBusiness4Widget> createState() => _CreateBusiness4WidgetState();
}

class _CreateBusiness4WidgetState extends State<CreateBusiness4Widget> {
  late CreateBusiness4Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateBusiness4Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          alignment: const AlignmentDirectional(0.0, -1.0),
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    FlutterFlowTheme.of(context).primaryBackground,
                    FlutterFlowTheme.of(context).primaryBackground,
                    Theme.of(context).brightness == Brightness.light
                        ? const Color(0x0083B4FF)
                        : const Color(0x4C18202F),
                    Theme.of(context).brightness == Brightness.light
                        ? const Color(0x7883B4FF)
                        : const Color(0x0A4B90FC)
                  ],
                  stops: const [0.0, 0.2, 0.7, 1.0],
                  begin: const AlignmentDirectional(1.0, 0.98),
                  end: const AlignmentDirectional(-1.0, -0.98),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 45.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x4C31363F)
                                                    : const Color(0x4CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x4C31363F)
                                                    : const Color(0x4CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x4C31363F)
                                                    : const Color(0x4CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF83B4FF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x4C31363F)
                                                    : const Color(0x4CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x4C31363F)
                                                    : const Color(0x4CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x4C31363F)
                                                    : const Color(0x4CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                    ].divide(const SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.backButtonModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const BackButtonWidget(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 15.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(),
                                  child: Text(
                                    'Step 4 of 7',
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
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Add your first service',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryAlpha400,
                                            fontSize: 25.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    if (false)
                                      Text(
                                        'Optional',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryAlpha400,
                                              fontSize: 13.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                              Form(
                                key: _model.formKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    wrapWithModel(
                                      model: _model.serviceNameModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Name',
                                        initialValue: FFAppState()
                                            .businessRegistration
                                            .step4FirstService
                                            .name,
                                        onChangeCallback: () async {
                                          FFAppState()
                                              .updateBusinessRegistrationStruct(
                                            (e) => e
                                              ..updateStep4FirstService(
                                                (e) => e
                                                  ..name = _model
                                                      .serviceNameModel
                                                      .textFieldTextController
                                                      .text,
                                              ),
                                          );
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.serviceDescriptionModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Description',
                                        initialValue: FFAppState()
                                            .businessRegistration
                                            .step4FirstService
                                            .description,
                                        minLines: 5,
                                        onChangeCallback: () async {
                                          FFAppState()
                                              .updateBusinessRegistrationStruct(
                                            (e) => e
                                              ..updateStep4FirstService(
                                                (e) => e
                                                  ..description = _model
                                                      .serviceDescriptionModel
                                                      .textFieldTextController
                                                      .text,
                                              ),
                                          );
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.servicePriceModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Price',
                                        initialValue: functions
                                            .centsStringToDollars(FFAppState()
                                                .businessRegistration
                                                .step4FirstService
                                                .priceCents
                                                .toString())
                                            .toString(),
                                        onChangeCallback: () async {
                                          FFAppState()
                                              .updateBusinessRegistrationStruct(
                                            (e) => e
                                              ..updateStep4FirstService(
                                                (e) => e
                                                  ..priceCents = functions
                                                      .dollarsStringToCents(_model
                                                          .servicePriceModel
                                                          .textFieldTextController
                                                          .text),
                                              ),
                                          );
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.serviceCategoryModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Category',
                                        initialValue: FFAppState()
                                            .businessRegistration
                                            .step4FirstService
                                            .category,
                                        onChangeCallback: () async {
                                          FFAppState()
                                              .updateBusinessRegistrationStruct(
                                            (e) => e
                                              ..updateStep4FirstService(
                                                (e) => e
                                                  ..category = _model
                                                      .serviceCategoryModel
                                                      .textFieldTextController
                                                      .text,
                                              ),
                                          );
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(height: 20.0))
                                      .addToStart(const SizedBox(height: 20.0))
                                      .addToEnd(const SizedBox(height: 2.0)),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }

                                            context.pushNamed(
                                              CreateBusiness5Widget.routeName,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    const TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );
                                          },
                                          text: 'Next step',
                                          icon: const FaIcon(
                                            FontAwesomeIcons.arrowRight,
                                            size: 18.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconAlignment: IconAlignment.end,
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0xFF222831)
                                                    : const Color(0xFF31363F),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.outfit(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 20.0)),
                                ),
                              ),
                            ].addToEnd(const SizedBox(height: 40.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
