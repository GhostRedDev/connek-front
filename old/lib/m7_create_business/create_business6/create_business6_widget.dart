import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/back_button_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_business6_model.dart';
export 'create_business6_model.dart';

class CreateBusiness6Widget extends StatefulWidget {
  const CreateBusiness6Widget({super.key});

  static String routeName = 'CreateBusiness6';
  static String routePath = 'createBusiness6';

  @override
  State<CreateBusiness6Widget> createState() => _CreateBusiness6WidgetState();
}

class _CreateBusiness6WidgetState extends State<CreateBusiness6Widget> {
  late CreateBusiness6Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateBusiness6Model());

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
        body: Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0x4C31363F)
                                          : const Color(0x4CFFFFFF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0x4C31363F)
                                          : const Color(0x4CFFFFFF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0x4C31363F)
                                          : const Color(0x4CFFFFFF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0x4C31363F)
                                          : const Color(0x4CFFFFFF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0x4C31363F)
                                          : const Color(0x4CFFFFFF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF83B4FF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0x4C31363F)
                                          : const Color(0x4CFFFFFF),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 10.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: wrapWithModel(
                            model: _model.backButtonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const BackButtonWidget(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 15.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            child: Text(
                              'Step 6 of 7',
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: Text(
                            'Deposit details',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryAlpha400,
                                  fontSize: 25.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Text(
                          'Add your deposit details to get paid',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryAlpha400,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ].addToEnd(const SizedBox(height: 20.0)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            wrapWithModel(
                              model: _model.transitFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldCompWidget(
                                title: 'Transit number',
                                initialValue: FFAppState()
                                    .businessRegistration
                                    .step7Deposit
                                    .transitNumber,
                                onChangeCallback: () async {
                                  FFAppState().updateBusinessRegistrationStruct(
                                    (e) => e
                                      ..updateStep7Deposit(
                                        (e) => e
                                          ..transitNumber = _model
                                              .transitFieldModel
                                              .textFieldTextController
                                              .text,
                                      ),
                                  );
                                  safeSetState(() {});
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.instFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldCompWidget(
                                title: 'Institution number',
                                initialValue: FFAppState()
                                    .businessRegistration
                                    .step7Deposit
                                    .institutionNumber,
                                onChangeCallback: () async {
                                  FFAppState().updateBusinessRegistrationStruct(
                                    (e) => e
                                      ..updateStep7Deposit(
                                        (e) => e
                                          ..institutionNumber = _model
                                              .instFieldModel
                                              .textFieldTextController
                                              .text,
                                      ),
                                  );
                                  safeSetState(() {});
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.accountFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldCompWidget(
                                title: 'Account number',
                                initialValue: FFAppState()
                                    .businessRegistration
                                    .step7Deposit
                                    .accountNumber,
                                onChangeCallback: () async {
                                  FFAppState().updateBusinessRegistrationStruct(
                                    (e) => e
                                      ..updateStep7Deposit(
                                        (e) => e
                                          ..accountNumber = _model
                                              .accountFieldModel
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
                              .addToEnd(const SizedBox(height: 40.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    unselectedWidgetColor: const Color(0xFF8D99AE),
                                  ),
                                  child: Checkbox(
                                    value: _model.checkboxValue ??=
                                        _model.checkedTOS,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.checkboxValue = newValue!);
                                      if (newValue!) {
                                        _model.checkedTOS = true;
                                        safeSetState(() {});
                                      } else {
                                        _model.checkedTOS = false;
                                        safeSetState(() {});
                                      }
                                    },
                                    side: (const Color(0xFF8D99AE) != null)
                                        ? const BorderSide(
                                            width: 2,
                                            color: Color(0xFF8D99AE),
                                          )
                                        : null,
                                    activeColor:
                                        FlutterFlowTheme.of(context).primary,
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Al registrarte aceptas todos los ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor44,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          TextSpan(
                                            text: 'términos y condiciones',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
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
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                            mouseCursor:
                                                SystemMouseCursors.click,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                await launchURL(
                                                    'https://www.youtube.com/');
                                              },
                                          ),
                                          TextSpan(
                                            text: ' al igual que nuestras ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor44,
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
                                          TextSpan(
                                            text: 'políticas de privacidad',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            mouseCursor:
                                                SystemMouseCursors.click,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                await launchURL(
                                                    'https://www.youtube.com/');
                                              },
                                          )
                                        ],
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
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                    var shouldSetState = false;
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    if (_model.checkedTOS != true) {
                                      await action_blocks.errorSnackbar(
                                        context,
                                        message:
                                            'You must accept the Terms of service.',
                                      );
                                      await action_blocks.multiPurposeDialog(
                                        context,
                                        title:
                                            'You must accept the terms of service.',
                                        texto: '',
                                        cancel: '',
                                        confirm: 'Ok',
                                      );
                                      if (shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                    _model.createdBusiness =
                                        await ConnekApiGroup.createBusinessCall
                                            .call(
                                      clientId: FFAppState().account.clientId,
                                      line1: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .address
                                          .line1,
                                      line2: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .address
                                          .line2,
                                      postalCode: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .address
                                          .postalCode,
                                      city: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .address
                                          .city,
                                      state: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .address
                                          .state,
                                      country: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .address
                                          .country,
                                      businessName: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .name,
                                      businessEmail: FFAppState()
                                          .businessRegistration
                                          .step3BusinessContact
                                          .businessEmail,
                                      businessUrl: FFAppState()
                                          .businessRegistration
                                          .step3BusinessContact
                                          .websiteUrl,
                                      businessDescription: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .description,
                                      businessGooglePlaceId: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .googleId,
                                      businessType: FFAppState()
                                          .businessRegistration
                                          .step1CompanyType
                                          ?.name,
                                      businessCategoryName: FFAppState()
                                          .businessRegistration
                                          .step2BusinessInformation
                                          .category,
                                      jwtToken: currentJwtToken,
                                      accountNumber: FFAppState()
                                          .businessRegistration
                                          .step7Deposit
                                          .accountNumber,
                                      servicesJson: functions
                                          .addedServiceInCreateBusiness(
                                              FFAppState()
                                                  .businessRegistration
                                                  .step4FirstService),
                                      businessPhone: FFAppState()
                                          .businessRegistration
                                          .step3BusinessContact
                                          .phone
                                          .toString(),
                                      transitNumber: FFAppState()
                                          .businessRegistration
                                          .step7Deposit
                                          .transitNumber,
                                      institutionNumber: FFAppState()
                                          .businessRegistration
                                          .step7Deposit
                                          .institutionNumber,
                                    );

                                    shouldSetState = true;
                                    if ((_model.createdBusiness?.succeeded ??
                                            true) ==
                                        true) {
                                      if (ConnekApiGroup.createBusinessCall
                                          .success(
                                        (_model.createdBusiness?.jsonBody ??
                                            ''),
                                      )!) {
                                        context.pushNamed(
                                          CreateBusiness7Widget.routeName,
                                          queryParameters: {
                                            'businessName': serializeParam(
                                              getJsonField(
                                                ConnekApiGroup
                                                    .createBusinessCall
                                                    .data(
                                                  (_model.createdBusiness
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                r'''$.name''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );

                                        await action_blocks.multiPurposeDialog(
                                          context,
                                          title: 'Congratulations !',
                                          texto:
                                              'You have succesfully created a business in Connek.',
                                          cancel: '',
                                          confirm: 'OK',
                                        );
                                      } else {
                                        await action_blocks.multiPurposeDialog(
                                          context,
                                          title: 'Error creating business. ',
                                          texto: getJsonField(
                                            (_model.createdBusiness?.jsonBody ??
                                                ''),
                                            r'''$.error''',
                                          ).toString(),
                                          cancel: '',
                                          confirm: 'OK',
                                        );
                                      }
                                    } else {
                                      await action_blocks.multiPurposeDialog(
                                        context,
                                        title: 'Server Error',
                                        texto: getJsonField(
                                          (_model.createdBusiness?.jsonBody ??
                                              ''),
                                          r'''$.error''',
                                        ).toString(),
                                        cancel: '',
                                        confirm: 'OK',
                                      );
                                    }

                                    if (shouldSetState) safeSetState(() {});
                                  },
                                  text: 'Completar Registro',
                                  icon: const FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 18.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconAlignment: IconAlignment.end,
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color(0xFF222831)
                                        : const Color(0xFF31363F),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(width: 20.0)),
                        ),
                      ),
                    ].addToEnd(const SizedBox(height: 20.0)),
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
