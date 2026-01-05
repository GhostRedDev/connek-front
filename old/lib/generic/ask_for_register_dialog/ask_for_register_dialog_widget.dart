import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m6_auth/sign_up_form/sign_up_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ask_for_register_dialog_model.dart';
export 'ask_for_register_dialog_model.dart';

class AskForRegisterDialogWidget extends StatefulWidget {
  const AskForRegisterDialogWidget({
    super.key,
    required this.navigateToHome,
    this.businessPageRedirect,
  });

  final bool? navigateToHome;
  final int? businessPageRedirect;

  @override
  State<AskForRegisterDialogWidget> createState() =>
      _AskForRegisterDialogWidgetState();
}

class _AskForRegisterDialogWidgetState
    extends State<AskForRegisterDialogWidget> {
  late AskForRegisterDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AskForRegisterDialogModel());

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 3.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You must be signed up to Connek.',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.roboto(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
              ),
              wrapWithModel(
                model: _model.signUpFormModel,
                updateCallback: () => safeSetState(() {}),
                child: const SignUpFormWidget(
                  navigateToHome: false,
                ),
              ),
            ].divide(const SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
