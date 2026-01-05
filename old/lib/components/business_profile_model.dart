import '/backend/supabase/supabase.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/text_field_comp2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_profile_widget.dart' show BusinessProfileWidget;
import 'package:flutter/material.dart';

class BusinessProfileModel extends FlutterFlowModel<BusinessProfileWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for nameField.
  late TextFieldComp2Model nameFieldModel;
  // Model for descriptionField.
  late TextFieldComp2Model descriptionFieldModel;
  // Model for phoneField.
  late TextFieldComp2Model phoneFieldModel;
  // Model for emailField.
  late TextFieldComp2Model emailFieldModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<BusinessRow>? updatedBusiness;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    nameFieldModel = createModel(context, () => TextFieldComp2Model());
    descriptionFieldModel = createModel(context, () => TextFieldComp2Model());
    phoneFieldModel = createModel(context, () => TextFieldComp2Model());
    emailFieldModel = createModel(context, () => TextFieldComp2Model());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    nameFieldModel.dispose();
    descriptionFieldModel.dispose();
    phoneFieldModel.dispose();
    emailFieldModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    emptySpaceModel.dispose();
  }
}
