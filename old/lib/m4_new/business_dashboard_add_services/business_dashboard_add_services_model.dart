import '/components/back_button_widget.dart';
import '/components/images_horizontal_viewer_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import 'business_dashboard_add_services_widget.dart'
    show BusinessDashboardAddServicesWidget;
import 'package:flutter/material.dart';

class BusinessDashboardAddServicesModel
    extends FlutterFlowModel<BusinessDashboardAddServicesWidget> {
  ///  Local state fields for this page.

  List<FFUploadedFile> uploadedImages = [];
  void addToUploadedImages(FFUploadedFile item) => uploadedImages.add(item);
  void removeFromUploadedImages(FFUploadedFile item) =>
      uploadedImages.remove(item);
  void removeAtIndexFromUploadedImages(int index) =>
      uploadedImages.removeAt(index);
  void insertAtIndexInUploadedImages(int index, FFUploadedFile item) =>
      uploadedImages.insert(index, item);
  void updateUploadedImagesAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      uploadedImages[index] = updateFn(uploadedImages[index]);

  FFUploadedFile? profileImageUploaded;

  List<String> imagesToRemove = [];
  void addToImagesToRemove(String item) => imagesToRemove.add(item);
  void removeFromImagesToRemove(String item) => imagesToRemove.remove(item);
  void removeAtIndexFromImagesToRemove(int index) =>
      imagesToRemove.removeAt(index);
  void insertAtIndexInImagesToRemove(int index, String item) =>
      imagesToRemove.insert(index, item);
  void updateImagesToRemoveAtIndex(int index, Function(String) updateFn) =>
      imagesToRemove[index] = updateFn(imagesToRemove[index]);

  List<String> imagesInStorage = [];
  void addToImagesInStorage(String item) => imagesInStorage.add(item);
  void removeFromImagesInStorage(String item) => imagesInStorage.remove(item);
  void removeAtIndexFromImagesInStorage(int index) =>
      imagesInStorage.removeAt(index);
  void insertAtIndexInImagesInStorage(int index, String item) =>
      imagesInStorage.insert(index, item);
  void updateImagesInStorageAtIndex(int index, Function(String) updateFn) =>
      imagesInStorage[index] = updateFn(imagesInStorage[index]);

  List<int> removeResources = [];
  void addToRemoveResources(int item) => removeResources.add(item);
  void removeFromRemoveResources(int item) => removeResources.remove(item);
  void removeAtIndexFromRemoveResources(int index) =>
      removeResources.removeAt(index);
  void insertAtIndexInRemoveResources(int index, int item) =>
      removeResources.insert(index, item);
  void updateRemoveResourcesAtIndex(int index, Function(int) updateFn) =>
      removeResources[index] = updateFn(removeResources[index]);

  List<int> addResources = [];
  void addToAddResources(int item) => addResources.add(item);
  void removeFromAddResources(int item) => addResources.remove(item);
  void removeAtIndexFromAddResources(int index) => addResources.removeAt(index);
  void insertAtIndexInAddResources(int index, int item) =>
      addResources.insert(index, item);
  void updateAddResourcesAtIndex(int index, Function(int) updateFn) =>
      addResources[index] = updateFn(addResources[index]);

  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  bool isDataUploading_uploadDataProfileImagex = false;
  FFUploadedFile uploadedLocalFile_uploadDataProfileImagex =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadDataProfileImageReplacex = false;
  FFUploadedFile uploadedLocalFile_uploadDataProfileImageReplacex =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadDataOLDProfileImageNew = false;
  FFUploadedFile uploadedLocalFile_uploadDataOLDProfileImageNew =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Model for nameField.
  late TextFieldCompModel nameFieldModel;
  // Model for descriptionComp.
  late TextFieldCompModel descriptionCompModel;
  // Model for priceCentsField.
  late TextFieldCompModel priceCentsFieldModel;
  // State field(s) for priceLowField widget.
  FocusNode? priceLowFieldFocusNode;
  TextEditingController? priceLowFieldTextController;
  String? Function(BuildContext, String?)? priceLowFieldTextControllerValidator;
  // State field(s) for priceHighField widget.
  FocusNode? priceHighFieldFocusNode;
  TextEditingController? priceHighFieldTextController;
  String? Function(BuildContext, String?)?
      priceHighFieldTextControllerValidator;
  // Model for durationField.
  late TextFieldCompModel durationFieldModel;
  // Model for categoryField.
  late TextFieldCompModel categoryFieldModel;
  // Model for imagesHorizontalViewer component.
  late ImagesHorizontalViewerModel imagesHorizontalViewerModel;
  bool isDataUploading_uploadedDataImagesx = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadedDataImagesx = [];

  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    nameFieldModel = createModel(context, () => TextFieldCompModel());
    descriptionCompModel = createModel(context, () => TextFieldCompModel());
    priceCentsFieldModel = createModel(context, () => TextFieldCompModel());
    durationFieldModel = createModel(context, () => TextFieldCompModel());
    categoryFieldModel = createModel(context, () => TextFieldCompModel());
    imagesHorizontalViewerModel =
        createModel(context, () => ImagesHorizontalViewerModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    backButtonModel.dispose();
    nameFieldModel.dispose();
    descriptionCompModel.dispose();
    priceCentsFieldModel.dispose();
    priceLowFieldFocusNode?.dispose();
    priceLowFieldTextController?.dispose();

    priceHighFieldFocusNode?.dispose();
    priceHighFieldTextController?.dispose();

    durationFieldModel.dispose();
    categoryFieldModel.dispose();
    imagesHorizontalViewerModel.dispose();
    mobileNavBarModel.dispose();
  }
}
