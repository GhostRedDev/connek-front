import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/index.dart';
import 'create_business7_widget.dart' show CreateBusiness7Widget;
import 'package:flutter/material.dart';

class CreateBusiness7Model extends FlutterFlowModel<CreateBusiness7Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
  }
}
