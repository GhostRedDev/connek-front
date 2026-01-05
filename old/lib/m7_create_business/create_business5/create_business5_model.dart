import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_business5_widget.dart' show CreateBusiness5Widget;
import 'package:flutter/material.dart';

class CreateBusiness5Model extends FlutterFlowModel<CreateBusiness5Widget> {
  ///  Local state fields for this page.

  FFUploadedFile? idDocument;

  FFUploadedFile? poaDocument;

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
