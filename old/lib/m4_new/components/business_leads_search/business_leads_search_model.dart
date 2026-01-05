import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/m4_new/components/mouse_leads_search2/mouse_leads_search2_widget.dart';
import 'business_leads_search_widget.dart' show BusinessLeadsSearchWidget;
import 'package:flutter/material.dart';

class BusinessLeadsSearchModel
    extends FlutterFlowModel<BusinessLeadsSearchWidget> {
  ///  Local state fields for this component.

  String filter = 'All';

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered3 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered4 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered5 = false;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
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
    textFieldFocusNode?.dispose();
    textController?.dispose();

    mouseLeadsSearch02Models.dispose();
  }
}
