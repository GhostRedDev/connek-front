import '/components/numbers_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_email_widget.dart' show ConfirmEmailWidget;
import 'package:flutter/material.dart';

class ConfirmEmailModel extends FlutterFlowModel<ConfirmEmailWidget> {
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
