import '/components/numbers_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_phone_number_widget.dart' show ConfirmPhoneNumberWidget;
import 'package:flutter/material.dart';

class ConfirmPhoneNumberModel
    extends FlutterFlowModel<ConfirmPhoneNumberWidget> {
  ///  Local state fields for this page.

  bool remember = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for NumbersFieldComp component.
  late NumbersFieldCompModel numbersFieldCompModel;

  @override
  void initState(BuildContext context) {
    numbersFieldCompModel = createModel(context, () => NumbersFieldCompModel());
  }

  @override
  void dispose() {
    numbersFieldCompModel.dispose();
  }
}
