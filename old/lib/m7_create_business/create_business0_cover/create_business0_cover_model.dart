import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/index.dart';
import 'create_business0_cover_widget.dart' show CreateBusiness0CoverWidget;
import 'package:flutter/material.dart';

class CreateBusiness0CoverModel
    extends FlutterFlowModel<CreateBusiness0CoverWidget> {
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
