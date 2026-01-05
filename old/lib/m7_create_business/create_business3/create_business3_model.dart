import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_business3_widget.dart' show CreateBusiness3Widget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateBusiness3Model extends FlutterFlowModel<CreateBusiness3Widget> {
  ///  Local state fields for this page.

  List<String> socialList = [];
  void addToSocialList(String item) => socialList.add(item);
  void removeFromSocialList(String item) => socialList.remove(item);
  void removeAtIndexFromSocialList(int index) => socialList.removeAt(index);
  void insertAtIndexInSocialList(int index, String item) =>
      socialList.insert(index, item);
  void updateSocialListAtIndex(int index, Function(String) updateFn) =>
      socialList[index] = updateFn(socialList[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // State field(s) for phoneMobile widget.
  FocusNode? phoneMobileFocusNode;
  TextEditingController? phoneMobileTextController;
  late MaskTextInputFormatter phoneMobileMask;
  String? Function(BuildContext, String?)? phoneMobileTextControllerValidator;
  String? _phoneMobileTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('^\\(\\d{3}\\)\\s\\d{3}-\\d{4}\$').hasMatch(val)) {
      return 'Invalid phone number';
    }
    return null;
  }

  // State field(s) for instagramMobile widget.
  FocusNode? instagramMobileFocusNode;
  TextEditingController? instagramMobileTextController;
  String? Function(BuildContext, String?)?
      instagramMobileTextControllerValidator;
  // State field(s) for xSocialMobile widget.
  FocusNode? xSocialMobileFocusNode;
  TextEditingController? xSocialMobileTextController;
  String? Function(BuildContext, String?)? xSocialMobileTextControllerValidator;
  // State field(s) for fbMobile widget.
  FocusNode? fbMobileFocusNode;
  TextEditingController? fbMobileTextController;
  String? Function(BuildContext, String?)? fbMobileTextControllerValidator;
  // State field(s) for websiteDesktop widget.
  FocusNode? websiteDesktopFocusNode;
  TextEditingController? websiteDesktopTextController;
  String? Function(BuildContext, String?)?
      websiteDesktopTextControllerValidator;
  // State field(s) for mailDesktop widget.
  FocusNode? mailDesktopFocusNode;
  TextEditingController? mailDesktopTextController;
  String? Function(BuildContext, String?)? mailDesktopTextControllerValidator;
  String? _mailDesktopTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Invalid email';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    phoneMobileTextControllerValidator = _phoneMobileTextControllerValidator;
    mailDesktopTextControllerValidator = _mailDesktopTextControllerValidator;
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    phoneMobileFocusNode?.dispose();
    phoneMobileTextController?.dispose();

    instagramMobileFocusNode?.dispose();
    instagramMobileTextController?.dispose();

    xSocialMobileFocusNode?.dispose();
    xSocialMobileTextController?.dispose();

    fbMobileFocusNode?.dispose();
    fbMobileTextController?.dispose();

    websiteDesktopFocusNode?.dispose();
    websiteDesktopTextController?.dispose();

    mailDesktopFocusNode?.dispose();
    mailDesktopTextController?.dispose();
  }
}
