import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import 'client_book_widget.dart' show ClientBookWidget;
import 'package:flutter/material.dart';

class ClientBookModel extends FlutterFlowModel<ClientBookWidget> {
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
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for minDesktop widget.
  FocusNode? minDesktopFocusNode1;
  TextEditingController? minDesktopTextController1;
  String? Function(BuildContext, String?)? minDesktopTextController1Validator;
  // State field(s) for maxDesktop widget.
  FocusNode? maxDesktopFocusNode1;
  TextEditingController? maxDesktopTextController1;
  String? Function(BuildContext, String?)? maxDesktopTextController1Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for minDesktop widget.
  FocusNode? minDesktopFocusNode2;
  TextEditingController? minDesktopTextController2;
  String? Function(BuildContext, String?)? minDesktopTextController2Validator;
  // State field(s) for maxDesktop widget.
  FocusNode? maxDesktopFocusNode2;
  TextEditingController? maxDesktopTextController2;
  String? Function(BuildContext, String?)? maxDesktopTextController2Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
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
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    minDesktopFocusNode1?.dispose();
    minDesktopTextController1?.dispose();

    maxDesktopFocusNode1?.dispose();
    maxDesktopTextController1?.dispose();

    mobileAppBarModel.dispose();
    textFieldFocusNode2?.dispose();
    textController4?.dispose();

    minDesktopFocusNode2?.dispose();
    minDesktopTextController2?.dispose();

    maxDesktopFocusNode2?.dispose();
    maxDesktopTextController2?.dispose();

    mobileNavBarModel.dispose();
  }
}
