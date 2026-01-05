import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'full_address_field_widget.dart' show FullAddressFieldWidget;
import 'package:flutter/material.dart';

class FullAddressFieldModel extends FlutterFlowModel<FullAddressFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for line1Field.
  late TextFieldCompModel line1FieldModel;
  // Model for line2Field.
  late TextFieldCompModel line2FieldModel;
  // Model for cityField.
  late TextFieldCompModel cityFieldModel;
  // Model for postalField.
  late TextFieldCompModel postalFieldModel;
  // Model for stateField.
  late TextFieldCompModel stateFieldModel;
  // Model for countryField.
  late TextFieldCompModel countryFieldModel;

  @override
  void initState(BuildContext context) {
    line1FieldModel = createModel(context, () => TextFieldCompModel());
    line2FieldModel = createModel(context, () => TextFieldCompModel());
    cityFieldModel = createModel(context, () => TextFieldCompModel());
    postalFieldModel = createModel(context, () => TextFieldCompModel());
    stateFieldModel = createModel(context, () => TextFieldCompModel());
    countryFieldModel = createModel(context, () => TextFieldCompModel());
  }

  @override
  void dispose() {
    line1FieldModel.dispose();
    line2FieldModel.dispose();
    cityFieldModel.dispose();
    postalFieldModel.dispose();
    stateFieldModel.dispose();
    countryFieldModel.dispose();
  }
}
