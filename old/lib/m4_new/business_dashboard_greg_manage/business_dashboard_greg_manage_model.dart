import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/components/business_dashboard_menu/business_dashboard_menu_widget.dart';
import '/m4_new/components/footer/footer_widget.dart';
import '/m4_new/components/side_bar_desktop/side_bar_desktop_widget.dart';
import '/m4_new/components/social_card/social_card_widget.dart';
import '/m_ilestone4/business_dashboard_welcome/business_dashboard_welcome_widget.dart';
import 'business_dashboard_greg_manage_widget.dart'
    show BusinessDashboardGregManageWidget;
import 'package:flutter/material.dart';

class BusinessDashboardGregManageModel
    extends FlutterFlowModel<BusinessDashboardGregManageWidget> {
  ///  Local state fields for this page.

  String pageSelected = 'overview';

  List<String> questions = [];
  void addToQuestions(String item) => questions.add(item);
  void removeFromQuestions(String item) => questions.remove(item);
  void removeAtIndexFromQuestions(int index) => questions.removeAt(index);
  void insertAtIndexInQuestions(int index, String item) =>
      questions.insert(index, item);
  void updateQuestionsAtIndex(int index, Function(String) updateFn) =>
      questions[index] = updateFn(questions[index]);

  List<String> instructions = [];
  void addToInstructions(String item) => instructions.add(item);
  void removeFromInstructions(String item) => instructions.remove(item);
  void removeAtIndexFromInstructions(int index) => instructions.removeAt(index);
  void insertAtIndexInInstructions(int index, String item) =>
      instructions.insert(index, item);
  void updateInstructionsAtIndex(int index, Function(String) updateFn) =>
      instructions[index] = updateFn(instructions[index]);

  bool active = false;

  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarDesktop component.
  late SideBarDesktopModel sideBarDesktopModel;
  // Model for BusinessDashboardMenu component.
  late BusinessDashboardMenuModel businessDashboardMenuModel;
  // Model for BusinessDashboardWelcome component.
  late BusinessDashboardWelcomeModel businessDashboardWelcomeModel;
  // Model for socialCard component.
  late SocialCardModel socialCardModel1;
  // Model for socialCard component.
  late SocialCardModel socialCardModel2;
  // Model for socialCard component.
  late SocialCardModel socialCardModel3;
  // State field(s) for question widget.
  FocusNode? questionFocusNode1;
  TextEditingController? questionTextController1;
  String? Function(BuildContext, String?)? questionTextController1Validator;
  String? _questionTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // State field(s) for instruction widget.
  FocusNode? instructionFocusNode1;
  TextEditingController? instructionTextController1;
  String? Function(BuildContext, String?)? instructionTextController1Validator;
  String? _instructionTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in IconButton widget.
  bool? val;
  // Model for footer component.
  late FooterModel footerModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in remember widget.
  List<ChatbotRow>? updatedChatbot;
  // State field(s) for question widget.
  FocusNode? questionFocusNode2;
  TextEditingController? questionTextController2;
  String? Function(BuildContext, String?)? questionTextController2Validator;
  String? _questionTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Update Employee)] action in IconButton widget.
  ApiCallResponse? employeeUpdateQuery;
  // State field(s) for instruction widget.
  FocusNode? instructionFocusNode2;
  TextEditingController? instructionTextController2;
  String? Function(BuildContext, String?)? instructionTextController2Validator;
  String? _instructionTextController2Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in IconButton widget.
  bool? vale;
  // Model for socialCard component.
  late SocialCardModel socialCardModel4;
  // Model for socialCard component.
  late SocialCardModel socialCardModel5;
  // Model for socialCard component.
  late SocialCardModel socialCardModel6;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarDesktopModel = createModel(context, () => SideBarDesktopModel());
    businessDashboardMenuModel =
        createModel(context, () => BusinessDashboardMenuModel());
    businessDashboardWelcomeModel =
        createModel(context, () => BusinessDashboardWelcomeModel());
    socialCardModel1 = createModel(context, () => SocialCardModel());
    socialCardModel2 = createModel(context, () => SocialCardModel());
    socialCardModel3 = createModel(context, () => SocialCardModel());
    questionTextController1Validator = _questionTextController1Validator;
    instructionTextController1Validator = _instructionTextController1Validator;
    footerModel = createModel(context, () => FooterModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    questionTextController2Validator = _questionTextController2Validator;
    instructionTextController2Validator = _instructionTextController2Validator;
    socialCardModel4 = createModel(context, () => SocialCardModel());
    socialCardModel5 = createModel(context, () => SocialCardModel());
    socialCardModel6 = createModel(context, () => SocialCardModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarDesktopModel.dispose();
    businessDashboardMenuModel.dispose();
    businessDashboardWelcomeModel.dispose();
    socialCardModel1.dispose();
    socialCardModel2.dispose();
    socialCardModel3.dispose();
    questionFocusNode1?.dispose();
    questionTextController1?.dispose();

    instructionFocusNode1?.dispose();
    instructionTextController1?.dispose();

    footerModel.dispose();
    mobileAppBarModel.dispose();
    questionFocusNode2?.dispose();
    questionTextController2?.dispose();

    instructionFocusNode2?.dispose();
    instructionTextController2?.dispose();

    socialCardModel4.dispose();
    socialCardModel5.dispose();
    socialCardModel6.dispose();
    mobileNavBarModel.dispose();
  }
}
