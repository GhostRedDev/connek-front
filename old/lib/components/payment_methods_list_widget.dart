import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/m_ilestone8/payment_method2/payment_method2_widget.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_methods_list_model.dart';
export 'payment_methods_list_model.dart';

/// Create a component for selecting payment methods.
///
/// In it you should have all the payment methods showing and a button to Add
/// new. Show the method (visa, mastercard, etc), the last 4 digits followed
/// by a gamma of "*" and the expiry date.
class PaymentMethodsListWidget extends StatefulWidget {
  const PaymentMethodsListWidget({
    super.key,
    this.onClickCallback,
  });

  final Future Function(ClientPaymentMethodsStruct paymentMethod)?
      onClickCallback;

  @override
  State<PaymentMethodsListWidget> createState() =>
      _PaymentMethodsListWidgetState();
}

class _PaymentMethodsListWidgetState extends State<PaymentMethodsListWidget> {
  late PaymentMethodsListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentMethodsListModel());

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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Payment Methods',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            if (FFAppState().clientPaymentMethods.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Default',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (widget.onClickCallback != null) {
                        await widget.onClickCallback?.call(
                          FFAppState()
                              .clientPaymentMethods
                              .where((e) => e.defaultMethod)
                              .toList()
                              .firstOrNull!,
                        );
                        Navigator.pop(context);
                      } else {
                        return;
                      }
                    },
                    child: wrapWithModel(
                      model: _model.paymentMethod2Model1,
                      updateCallback: () => safeSetState(() {}),
                      child: PaymentMethod2Widget(
                        method: FFAppState()
                            .clientPaymentMethods
                            .where((e) => e.defaultMethod)
                            .toList()
                            .firstOrNull!,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Builder(
                    builder: (context) {
                      final methodsNotDefault = FFAppState()
                          .clientPaymentMethods
                          .where((e) => !e.defaultMethod)
                          .toList();

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(methodsNotDefault.length,
                            (methodsNotDefaultIndex) {
                          final methodsNotDefaultItem =
                              methodsNotDefault[methodsNotDefaultIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (widget.onClickCallback != null) {
                                await widget.onClickCallback?.call(
                                  methodsNotDefaultItem,
                                );
                                Navigator.pop(context);
                              } else {
                                return;
                              }
                            },
                            child: PaymentMethod2Widget(
                              key: Key(
                                  'Keyn05_${methodsNotDefaultIndex}_of_${methodsNotDefault.length}'),
                              method: methodsNotDefaultItem,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ].divide(const SizedBox(height: 12.0)),
              ),
            FFButtonWidget(
              onPressed: () async {
                await action_blocks.setupPaymentMethod(context);
              },
              text: '+ Add new payment method',
              options: FFButtonOptions(
                width: double.infinity,
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 15.0, 8.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).neutral100,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.outfit(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).bg1Sec,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                elevation: 0.0,
                borderSide: const BorderSide(
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(1000.0),
                hoverColor: FlutterFlowTheme.of(context).primaryAlpha10,
                hoverElevation: 1.0,
              ),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
