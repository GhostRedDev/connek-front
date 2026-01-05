import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/mouse_leads_search2/mouse_leads_search2_widget.dart';
import 'business_leads_search_mobile_widget.dart'
    show BusinessLeadsSearchMobileWidget;
import 'package:flutter/material.dart';

class BusinessLeadsSearchMobileModel
    extends FlutterFlowModel<BusinessLeadsSearchMobileWidget> {
  ///  Local state fields for this component.

  String? filter = 'all';

  ///  State fields for stateful widgets in this component.

  // Models for mouseLeadsSearch02.
  late FlutterFlowDynamicModels<MouseLeadsSearch2Model>
      mouseLeadsSearch02Models;

  @override
  void initState(BuildContext context) {
    mouseLeadsSearch02Models =
        FlutterFlowDynamicModels(() => MouseLeadsSearch2Model());
  }

  @override
  void dispose() {
    mouseLeadsSearch02Models.dispose();
  }
}
