import '/components/nav_bar_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mobile_nav_bar2_widget.dart' show MobileNavBar2Widget;
import 'package:flutter/material.dart';

class MobileNavBar2Model extends FlutterFlowModel<MobileNavBar2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for clientOption.
  late NavBarOptionModel clientOptionModel;
  // Model for businessOption.
  late NavBarOptionModel businessOptionModel;
  // Model for officeOption.
  late NavBarOptionModel officeOptionModel;
  // Model for profileOption.
  late NavBarOptionModel profileOptionModel;

  @override
  void initState(BuildContext context) {
    clientOptionModel = createModel(context, () => NavBarOptionModel());
    businessOptionModel = createModel(context, () => NavBarOptionModel());
    officeOptionModel = createModel(context, () => NavBarOptionModel());
    profileOptionModel = createModel(context, () => NavBarOptionModel());
  }

  @override
  void dispose() {
    clientOptionModel.dispose();
    businessOptionModel.dispose();
    officeOptionModel.dispose();
    profileOptionModel.dispose();
  }
}
