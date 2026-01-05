import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'createbusiness1_widget.dart' show Createbusiness1Widget;
import 'package:flutter/material.dart';

class Createbusiness1Model extends FlutterFlowModel<Createbusiness1Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for backButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
  }
}
