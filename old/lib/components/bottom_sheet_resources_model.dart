import '/components/text_field_comp2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_sheet_resources_widget.dart' show BottomSheetResourcesWidget;
import 'package:flutter/material.dart';

class BottomSheetResourcesModel
    extends FlutterFlowModel<BottomSheetResourcesWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for nameField.
  late TextFieldComp2Model nameFieldModel;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {
    nameFieldModel = createModel(context, () => TextFieldComp2Model());
  }

  @override
  void dispose() {
    nameFieldModel.dispose();
  }
}
