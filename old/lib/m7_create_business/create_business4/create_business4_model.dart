import '/backend/schema/structs/index.dart';
import '/components/back_button_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_business4_widget.dart' show CreateBusiness4Widget;
import 'package:flutter/material.dart';

class CreateBusiness4Model extends FlutterFlowModel<CreateBusiness4Widget> {
  ///  Local state fields for this page.

  List<FFUploadedFile> photos = [];
  void addToPhotos(FFUploadedFile item) => photos.add(item);
  void removeFromPhotos(FFUploadedFile item) => photos.remove(item);
  void removeAtIndexFromPhotos(int index) => photos.removeAt(index);
  void insertAtIndexInPhotos(int index, FFUploadedFile item) =>
      photos.insert(index, item);
  void updatePhotosAtIndex(int index, Function(FFUploadedFile) updateFn) =>
      photos[index] = updateFn(photos[index]);

  AddedServiceStruct? services;
  void updateServicesStruct(Function(AddedServiceStruct) updateFn) {
    updateFn(services ??= AddedServiceStruct());
  }

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for ServiceName.
  late TextFieldCompModel serviceNameModel;
  // Model for ServiceDescription.
  late TextFieldCompModel serviceDescriptionModel;
  // Model for ServicePrice.
  late TextFieldCompModel servicePriceModel;
  // Model for ServiceCategory.
  late TextFieldCompModel serviceCategoryModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    serviceNameModel = createModel(context, () => TextFieldCompModel());
    serviceDescriptionModel = createModel(context, () => TextFieldCompModel());
    servicePriceModel = createModel(context, () => TextFieldCompModel());
    serviceCategoryModel = createModel(context, () => TextFieldCompModel());
    serviceNameModel.textFieldTextControllerValidator =
        _formTextFieldValidator1;
    serviceDescriptionModel.textFieldTextControllerValidator =
        _formTextFieldValidator2;
    servicePriceModel.textFieldTextControllerValidator =
        _formTextFieldValidator3;
    serviceCategoryModel.textFieldTextControllerValidator =
        _formTextFieldValidator4;
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    serviceNameModel.dispose();
    serviceDescriptionModel.dispose();
    servicePriceModel.dispose();
    serviceCategoryModel.dispose();
  }

  /// Additional helper methods.

  String? _formTextFieldValidator1(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }

    if (val.length < 2) {
      return 'Must be at least 2 characters';
    }

    return null;
  }

  String? _formTextFieldValidator2(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Description is required';
    }

    if (val.length < 10) {
      return 'Must be at least 10 characters';
    }

    return null;
  }

  String? _formTextFieldValidator3(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Price is required';
    }

    if (!RegExp('^(?!0+(\\.0{1,2})?\$)\\d+(\\.\\d{1,2})?\$').hasMatch(val)) {
      return 'Please enter a valid price (numbers only, up to 2 decimal places, e.g. 100 or 100.20).';
    }
    return null;
  }

  String? _formTextFieldValidator4(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Category is required';
    }

    return null;
  }
}
