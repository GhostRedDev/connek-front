import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/back_button_widget.dart';
import '/components/full_address_field_widget.dart';
import '/components/selection_field_comp_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_business2_widget.dart' show CreateBusiness2Widget;
import 'package:flutter/material.dart';

class CreateBusiness2Model extends FlutterFlowModel<CreateBusiness2Widget> {
  ///  Local state fields for this page.

  String? googleId;

  List<AddressDataStruct> placesQuery = [];
  void addToPlacesQuery(AddressDataStruct item) => placesQuery.add(item);
  void removeFromPlacesQuery(AddressDataStruct item) =>
      placesQuery.remove(item);
  void removeAtIndexFromPlacesQuery(int index) => placesQuery.removeAt(index);
  void insertAtIndexInPlacesQuery(int index, AddressDataStruct item) =>
      placesQuery.insert(index, item);
  void updatePlacesQueryAtIndex(
          int index, Function(AddressDataStruct) updateFn) =>
      placesQuery[index] = updateFn(placesQuery[index]);

  List<String> categories = [];
  void addToCategories(String item) => categories.add(item);
  void removeFromCategories(String item) => categories.remove(item);
  void removeAtIndexFromCategories(int index) => categories.removeAt(index);
  void insertAtIndexInCategories(int index, String item) =>
      categories.insert(index, item);
  void updateCategoriesAtIndex(int index, Function(String) updateFn) =>
      categories[index] = updateFn(categories[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Query Rows] action in CreateBusiness2 widget.
  List<BusinessCatRow>? catsQuery;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for NameField.
  late TextFieldCompModel nameFieldModel;
  // Model for DescriptionField.
  late TextFieldCompModel descriptionFieldModel;
  // Model for CategoryField.
  late SelectionFieldCompModel categoryFieldModel;
  // Model for FullAddressField component.
  late FullAddressFieldModel fullAddressFieldModel;
  // State field(s) for GoogleMapMobile widget.
  LatLng? googleMapMobilesCenter;
  final googleMapMobilesController = Completer<GoogleMapController>();
  // Stores action output result for [Validate Form] action in Button widget.
  bool? validation;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    nameFieldModel = createModel(context, () => TextFieldCompModel());
    descriptionFieldModel = createModel(context, () => TextFieldCompModel());
    categoryFieldModel = createModel(context, () => SelectionFieldCompModel());
    fullAddressFieldModel = createModel(context, () => FullAddressFieldModel());
    nameFieldModel.textFieldTextControllerValidator = _formTextFieldValidator1;
    descriptionFieldModel.textFieldTextControllerValidator =
        _formTextFieldValidator2;
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    nameFieldModel.dispose();
    descriptionFieldModel.dispose();
    categoryFieldModel.dispose();
    fullAddressFieldModel.dispose();
  }

  /// Action blocks.
  Future setFormFields(
    BuildContext context, {
    BusinessRegistration2Struct? result,
  }) async {}

  /// Additional helper methods.

  String? _formTextFieldValidator1(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }

    if (val.length < 2) {
      return 'Business name must be at least 2 characters long';
    }
    if (val.length > 100) {
      return 'Business name cannot exceed 100 characters';
    }

    return null;
  }

  String? _formTextFieldValidator2(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'initialValue is required';
    }

    if (val.length < 25) {
      return 'Minimum 25 characters required';
    }

    return null;
  }
}
