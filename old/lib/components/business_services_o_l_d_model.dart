import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import '/m4_new/business_dashboard_service_box/business_dashboard_service_box_widget.dart';
import 'business_services_o_l_d_widget.dart' show BusinessServicesOLDWidget;
import 'package:flutter/material.dart';

class BusinessServicesOLDModel
    extends FlutterFlowModel<BusinessServicesOLDWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel1;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel2;
  // Models for BusinessDashboardServiceBox dynamic component.
  late FlutterFlowDynamicModels<BusinessDashboardServiceBoxModel>
      businessDashboardServiceBoxModels;

  @override
  void initState(BuildContext context) {
    contentHeaderModel1 = createModel(context, () => ContentHeaderModel());
    contentHeaderModel2 = createModel(context, () => ContentHeaderModel());
    businessDashboardServiceBoxModels =
        FlutterFlowDynamicModels(() => BusinessDashboardServiceBoxModel());
  }

  @override
  void dispose() {
    contentHeaderModel1.dispose();
    contentHeaderModel2.dispose();
    businessDashboardServiceBoxModels.dispose();
  }
}
