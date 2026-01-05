import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'client_profile_profile_widget.dart' show ClientProfileProfileWidget;
import 'package:flutter/material.dart';

class ClientProfileProfileModel
    extends FlutterFlowModel<ClientProfileProfileWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for firstField widget.
  FocusNode? firstFieldFocusNode;
  TextEditingController? firstFieldTextController;
  String? Function(BuildContext, String?)? firstFieldTextControllerValidator;
  // State field(s) for lastField widget.
  FocusNode? lastFieldFocusNode;
  TextEditingController? lastFieldTextController;
  String? Function(BuildContext, String?)? lastFieldTextControllerValidator;
  // State field(s) for aboutMeField widget.
  FocusNode? aboutMeFieldFocusNode;
  TextEditingController? aboutMeFieldTextController;
  String? Function(BuildContext, String?)? aboutMeFieldTextControllerValidator;
  // State field(s) for yearMobile widget.
  FocusNode? yearMobileFocusNode;
  TextEditingController? yearMobileTextController;
  String? Function(BuildContext, String?)? yearMobileTextControllerValidator;
  // State field(s) for monthMobile widget.
  FocusNode? monthMobileFocusNode;
  TextEditingController? monthMobileTextController;
  String? Function(BuildContext, String?)? monthMobileTextControllerValidator;
  // State field(s) for dayMobile widget.
  FocusNode? dayMobileFocusNode;
  TextEditingController? dayMobileTextController;
  String? Function(BuildContext, String?)? dayMobileTextControllerValidator;

  @override
  void initState(BuildContext context) {
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
  }

  @override
  void dispose() {
    contentHeaderModel.dispose();
    firstFieldFocusNode?.dispose();
    firstFieldTextController?.dispose();

    lastFieldFocusNode?.dispose();
    lastFieldTextController?.dispose();

    aboutMeFieldFocusNode?.dispose();
    aboutMeFieldTextController?.dispose();

    yearMobileFocusNode?.dispose();
    yearMobileTextController?.dispose();

    monthMobileFocusNode?.dispose();
    monthMobileTextController?.dispose();

    dayMobileFocusNode?.dispose();
    dayMobileTextController?.dispose();
  }
}
