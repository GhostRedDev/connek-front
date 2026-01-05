import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/business_profile_form/business_profile_form_widget.dart';
import 'business_profile_profile_widget.dart' show BusinessProfileProfileWidget;
import 'package:flutter/material.dart';

class BusinessProfileProfileModel
    extends FlutterFlowModel<BusinessProfileProfileWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for BusinessProfileForm component.
  late BusinessProfileFormModel businessProfileFormModel;

  @override
  void initState(BuildContext context) {
    businessProfileFormModel =
        createModel(context, () => BusinessProfileFormModel());
  }

  @override
  void dispose() {
    businessProfileFormModel.dispose();
  }
}
