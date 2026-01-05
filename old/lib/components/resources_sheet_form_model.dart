import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'resources_sheet_form_widget.dart' show ResourcesSheetFormWidget;
import 'package:flutter/material.dart';

class ResourcesSheetFormModel
    extends FlutterFlowModel<ResourcesSheetFormWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ResourceNameField.
  late TextFieldCompModel resourceNameFieldModel;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Model for UpdateResourceNameField.
  late TextFieldCompModel updateResourceNameFieldModel;

  @override
  void initState(BuildContext context) {
    resourceNameFieldModel = createModel(context, () => TextFieldCompModel());
    updateResourceNameFieldModel =
        createModel(context, () => TextFieldCompModel());
  }

  @override
  void dispose() {
    resourceNameFieldModel.dispose();
    updateResourceNameFieldModel.dispose();
  }
}
