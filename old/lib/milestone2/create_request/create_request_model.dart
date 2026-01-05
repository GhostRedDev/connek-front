import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/index.dart';
import 'create_request_widget.dart' show CreateRequestWidget;
import 'package:flutter/material.dart';

class CreateRequestModel extends FlutterFlowModel<CreateRequestWidget> {
  ///  Local state fields for this page.

  BusinessBar? barSelected = BusinessBar.Services;

  bool isHovered = false;

  BusinessDataStruct? businessData;
  void updateBusinessDataStruct(Function(BusinessDataStruct) updateFn) {
    updateFn(businessData ??= BusinessDataStruct());
  }

  List<ServicesRow> servicesBusiness = [];
  void addToServicesBusiness(ServicesRow item) => servicesBusiness.add(item);
  void removeFromServicesBusiness(ServicesRow item) =>
      servicesBusiness.remove(item);
  void removeAtIndexFromServicesBusiness(int index) =>
      servicesBusiness.removeAt(index);
  void insertAtIndexInServicesBusiness(int index, ServicesRow item) =>
      servicesBusiness.insert(index, item);
  void updateServicesBusinessAtIndex(
          int index, Function(ServicesRow) updateFn) =>
      servicesBusiness[index] = updateFn(servicesBusiness[index]);

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for minDesktop widget.
  FocusNode? minDesktopFocusNode;
  TextEditingController? minDesktopTextController;
  String? Function(BuildContext, String?)? minDesktopTextControllerValidator;
  // State field(s) for maxDesktop widget.
  FocusNode? maxDesktopFocusNode;
  TextEditingController? maxDesktopTextController;
  String? Function(BuildContext, String?)? maxDesktopTextControllerValidator;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // State field(s) for descriptionMobile widget.
  FocusNode? descriptionMobileFocusNode;
  TextEditingController? descriptionMobileTextController;
  String? Function(BuildContext, String?)?
      descriptionMobileTextControllerValidator;
  bool isDataUploading_uploadDataRequest = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataRequest = [];

  // State field(s) for minMobile widget.
  FocusNode? minMobileFocusNode;
  TextEditingController? minMobileTextController;
  String? Function(BuildContext, String?)? minMobileTextControllerValidator;
  // State field(s) for maxMobile widget.
  FocusNode? maxMobileFocusNode;
  TextEditingController? maxMobileTextController;
  String? Function(BuildContext, String?)? maxMobileTextControllerValidator;
  // Stores action output result for [Action Block - multiPurposeDialog] action in Button widget.
  bool? response;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    minDesktopFocusNode?.dispose();
    minDesktopTextController?.dispose();

    maxDesktopFocusNode?.dispose();
    maxDesktopTextController?.dispose();

    mobileAppBarModel.dispose();
    descriptionMobileFocusNode?.dispose();
    descriptionMobileTextController?.dispose();

    minMobileFocusNode?.dispose();
    minMobileTextController?.dispose();

    maxMobileFocusNode?.dispose();
    maxMobileTextController?.dispose();

    mobileNavBarModel.dispose();
  }
}
