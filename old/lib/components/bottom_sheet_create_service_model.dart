import '/components/images_horizontal_viewer_widget.dart';
import '/components/recurso_copilot_service_add_widget.dart';
import '/components/text_field_comp2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_sheet_create_service_widget.dart'
    show BottomSheetCreateServiceWidget;
import 'package:flutter/material.dart';

class BottomSheetCreateServiceModel
    extends FlutterFlowModel<BottomSheetCreateServiceWidget> {
  ///  Local state fields for this component.

  List<String> imagesInStorage = [];
  void addToImagesInStorage(String item) => imagesInStorage.add(item);
  void removeFromImagesInStorage(String item) => imagesInStorage.remove(item);
  void removeAtIndexFromImagesInStorage(int index) =>
      imagesInStorage.removeAt(index);
  void insertAtIndexInImagesInStorage(int index, String item) =>
      imagesInStorage.insert(index, item);
  void updateImagesInStorageAtIndex(int index, Function(String) updateFn) =>
      imagesInStorage[index] = updateFn(imagesInStorage[index]);

  List<String> imagesToRemove = [];
  void addToImagesToRemove(String item) => imagesToRemove.add(item);
  void removeFromImagesToRemove(String item) => imagesToRemove.remove(item);
  void removeAtIndexFromImagesToRemove(int index) =>
      imagesToRemove.removeAt(index);
  void insertAtIndexInImagesToRemove(int index, String item) =>
      imagesToRemove.insert(index, item);
  void updateImagesToRemoveAtIndex(int index, Function(String) updateFn) =>
      imagesToRemove[index] = updateFn(imagesToRemove[index]);

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

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataProfileImage = false;
  FFUploadedFile uploadedLocalFile_uploadDataProfileImage =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadDataProfileImageReplace = false;
  FFUploadedFile uploadedLocalFile_uploadDataProfileImageReplace =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  bool isDataUploading_uploadProfileImageNew = false;
  FFUploadedFile uploadedLocalFile_uploadProfileImageNew =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Model for nameField.
  late TextFieldComp2Model nameFieldModel;
  // Model for descriptionField.
  late TextFieldComp2Model descriptionFieldModel;
  // State field(s) for priceField widget.
  FocusNode? priceFieldFocusNode;
  TextEditingController? priceFieldTextController;
  String? Function(BuildContext, String?)? priceFieldTextControllerValidator;
  // State field(s) for durationField widget.
  FocusNode? durationFieldFocusNode;
  TextEditingController? durationFieldTextController;
  String? Function(BuildContext, String?)? durationFieldTextControllerValidator;
  // Model for categoryField.
  late TextFieldComp2Model categoryFieldModel;
  bool isDataUploading_uploadedDataImages = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadedDataImages = [];

  // Model for imagesHorizontalViewer component.
  late ImagesHorizontalViewerModel imagesHorizontalViewerModel;
  // Model for RecursoCopilotServiceAdd component.
  late RecursoCopilotServiceAddModel recursoCopilotServiceAddModel;

  @override
  void initState(BuildContext context) {
    nameFieldModel = createModel(context, () => TextFieldComp2Model());
    descriptionFieldModel = createModel(context, () => TextFieldComp2Model());
    categoryFieldModel = createModel(context, () => TextFieldComp2Model());
    imagesHorizontalViewerModel =
        createModel(context, () => ImagesHorizontalViewerModel());
    recursoCopilotServiceAddModel =
        createModel(context, () => RecursoCopilotServiceAddModel());
  }

  @override
  void dispose() {
    nameFieldModel.dispose();
    descriptionFieldModel.dispose();
    priceFieldFocusNode?.dispose();
    priceFieldTextController?.dispose();

    durationFieldFocusNode?.dispose();
    durationFieldTextController?.dispose();

    categoryFieldModel.dispose();
    imagesHorizontalViewerModel.dispose();
    recursoCopilotServiceAddModel.dispose();
  }
}
