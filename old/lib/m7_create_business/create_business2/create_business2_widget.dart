import '/backend/supabase/supabase.dart';
import '/components/back_button_widget.dart';
import '/components/full_address_field_widget.dart';
import '/components/selection_field_comp_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/m7_create_business/components/business_name_google/business_name_google_widget.dart';
import '/m7_create_business/components/select_location/select_location_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'create_business2_model.dart';
export 'create_business2_model.dart';

class CreateBusiness2Widget extends StatefulWidget {
  const CreateBusiness2Widget({super.key});

  static String routeName = 'CreateBusiness2';
  static String routePath = 'createBusiness2';

  @override
  State<CreateBusiness2Widget> createState() => _CreateBusiness2WidgetState();
}

class _CreateBusiness2WidgetState extends State<CreateBusiness2Widget> {
  late CreateBusiness2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateBusiness2Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.catsQuery = await BusinessCatTable().queryRows(
        queryFn: (q) => q,
      );
      _model.categories = _model.catsQuery!
          .map((e) => e.category)
          .toList()
          .toList()
          .cast<String>();
      safeSetState(() {});
    });

    getCurrentUserLocation(defaultLocation: const LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
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
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: SpinKitRipple(
              color: FlutterFlowTheme.of(context).primary,
              size: 50.0,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
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
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 45.0, 0.0, 0.0),
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
                          ].divide(const SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: wrapWithModel(
                          model: _model.backButtonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: const BackButtonWidget(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: Text(
                          'Step 2 of 7',
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
                                color: FlutterFlowTheme.of(context).primaryText,
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
                        'Business information',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primary200,
                              fontSize: 25.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: const AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: const SizedBox(
                                      height: 310.0,
                                      width: 595.0,
                                      child: BusinessNameGoogleWidget(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 42.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).primaryAlpha400,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/google-my-business-logo_1.png',
                                      height: 200.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Is your business in Google?',
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
                                          color: Colors.white,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            wrapWithModel(
                              model: _model.nameFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldCompWidget(
                                title: 'Name',
                                initialValue: valueOrDefault<String>(
                                  FFAppState()
                                      .businessRegistration
                                      .step2BusinessInformation
                                      .name,
                                  'Business name',
                                ),
                                onChangeCallback: () async {
                                  FFAppState().updateBusinessRegistrationStruct(
                                    (e) => e
                                      ..updateStep2BusinessInformation(
                                        (e) => e
                                          ..name = _model.nameFieldModel
                                              .textFieldTextController.text,
                                      ),
                                  );
                                  safeSetState(() {});
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.descriptionFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldCompWidget(
                                title:
                                    'Describe your business in a few sentences',
                                initialValue: valueOrDefault<String>(
                                  FFAppState()
                                      .businessRegistration
                                      .step2BusinessInformation
                                      .description,
                                  'Business description',
                                ),
                                minLines: 5,
                                onChangeCallback: () async {
                                  FFAppState().updateBusinessRegistrationStruct(
                                    (e) => e
                                      ..updateStep2BusinessInformation(
                                        (e) => e
                                          ..description = _model
                                              .descriptionFieldModel
                                              .textFieldTextController
                                              .text,
                                      ),
                                  );
                                  safeSetState(() {});
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.categoryFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: SelectionFieldCompWidget(
                                title: 'Category',
                                options: _model.categories,
                                onChangeCallback: () async {
                                  FFAppState().updateBusinessRegistrationStruct(
                                    (e) => e
                                      ..updateStep2BusinessInformation(
                                        (e) => e
                                          ..category = _model
                                              .categoryFieldModel.dropDownValue,
                                      ),
                                  );
                                  safeSetState(() {});
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.fullAddressFieldModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const FullAddressFieldWidget(),
                            ),
                          ]
                              .divide(const SizedBox(height: 20.0))
                              .addToStart(const SizedBox(height: 20.0))
                              .addToEnd(const SizedBox(height: 20.0)),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            FlutterFlowGoogleMap(
                              controller: _model.googleMapMobilesController,
                              onCameraIdle: (latLng) =>
                                  _model.googleMapMobilesCenter = latLng,
                              initialLocation: _model.googleMapMobilesCenter ??=
                                  currentUserLocationValue!,
                              markerColor: GoogleMarkerColor.violet,
                              mapType: MapType.normal,
                              style: GoogleMapStyle.standard,
                              initialZoom: 14.0,
                              allowInteraction: false,
                              allowZoom: false,
                              showZoomControls: true,
                              showLocation: true,
                              showCompass: false,
                              showMapToolbar: false,
                              showTraffic: false,
                              centerMapOnMarkerTap: false,
                            ),
                            PointerInterceptor(
                              intercepting: isWeb,
                              child: Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: const AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.6,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              child: const SelectLocationWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 390.0,
                                    height: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00EEEEEE),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.validation = true;
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  safeSetState(() => _model.validation = false);
                                  return;
                                }

                                context.pushNamed(
                                  CreateBusiness3Widget.routeName,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );

                                safeSetState(() {});
                              },
                              text: 'Next step',
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
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].addToEnd(const SizedBox(height: 40.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
