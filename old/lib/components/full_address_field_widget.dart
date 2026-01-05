import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'full_address_field_model.dart';
export 'full_address_field_model.dart';

class FullAddressFieldWidget extends StatefulWidget {
  const FullAddressFieldWidget({super.key});

  @override
  State<FullAddressFieldWidget> createState() => _FullAddressFieldWidgetState();
}

class _FullAddressFieldWidgetState extends State<FullAddressFieldWidget> {
  late FullAddressFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FullAddressFieldModel());

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
      borderRadius: BorderRadius.circular(6.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Text(
                  'Address',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: wrapWithModel(
                      model: _model.line1FieldModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldCompWidget(
                        initialValue: FFAppState()
                            .businessRegistration
                            .step2BusinessInformation
                            .address
                            .line1,
                        hint: 'Line 1',
                        onChangeCallback: () async {
                          FFAppState().updateBusinessRegistrationStruct(
                            (e) => e
                              ..updateStep2BusinessInformation(
                                (e) => e
                                  ..updateAddress(
                                    (e) => e
                                      ..line1 = _model.line1FieldModel
                                          .textFieldTextController.text,
                                  ),
                              ),
                          );
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: wrapWithModel(
                      model: _model.line2FieldModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldCompWidget(
                        initialValue: FFAppState()
                            .businessRegistration
                            .step2BusinessInformation
                            .address
                            .line2,
                        hint: 'Line 2',
                        onChangeCallback: () async {
                          FFAppState().updateBusinessRegistrationStruct(
                            (e) => e
                              ..updateStep2BusinessInformation(
                                (e) => e
                                  ..updateAddress(
                                    (e) => e
                                      ..line2 = _model.line2FieldModel
                                          .textFieldTextController.text,
                                  ),
                              ),
                          );
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                ].divide(const SizedBox(width: 15.0)),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: wrapWithModel(
                        model: _model.cityFieldModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldCompWidget(
                          initialValue: FFAppState()
                              .businessRegistration
                              .step2BusinessInformation
                              .address
                              .city,
                          hint: 'City',
                          onChangeCallback: () async {
                            FFAppState().updateBusinessRegistrationStruct(
                              (e) => e
                                ..updateStep2BusinessInformation(
                                  (e) => e
                                    ..updateAddress(
                                      (e) => e
                                        ..city = _model.cityFieldModel
                                            .textFieldTextController.text,
                                    ),
                                ),
                            );
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: wrapWithModel(
                        model: _model.postalFieldModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldCompWidget(
                          initialValue: FFAppState()
                              .businessRegistration
                              .step2BusinessInformation
                              .address
                              .postalCode,
                          hint: 'Postal code',
                          onChangeCallback: () async {
                            FFAppState().updateBusinessRegistrationStruct(
                              (e) => e
                                ..updateStep2BusinessInformation(
                                  (e) => e
                                    ..updateAddress(
                                      (e) => e
                                        ..postalCode = _model.postalFieldModel
                                            .textFieldTextController.text,
                                    ),
                                ),
                            );
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 15.0)),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: wrapWithModel(
                        model: _model.stateFieldModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldCompWidget(
                          initialValue: FFAppState()
                              .businessRegistration
                              .step2BusinessInformation
                              .address
                              .state,
                          hint: 'Province',
                          onChangeCallback: () async {
                            FFAppState().updateBusinessRegistrationStruct(
                              (e) => e
                                ..updateStep2BusinessInformation(
                                  (e) => e
                                    ..updateAddress(
                                      (e) => e
                                        ..state = _model.stateFieldModel
                                            .textFieldTextController.text,
                                    ),
                                ),
                            );
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: wrapWithModel(
                        model: _model.countryFieldModel,
                        updateCallback: () => safeSetState(() {}),
                        child: TextFieldCompWidget(
                          initialValue: FFAppState()
                              .businessRegistration
                              .step2BusinessInformation
                              .address
                              .country,
                          hint: 'Country',
                          onChangeCallback: () async {
                            FFAppState().updateBusinessRegistrationStruct(
                              (e) => e
                                ..updateStep2BusinessInformation(
                                  (e) => e
                                    ..updateAddress(
                                      (e) => e
                                        ..country = _model.countryFieldModel
                                            .textFieldTextController.text,
                                    ),
                                ),
                            );
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 15.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
