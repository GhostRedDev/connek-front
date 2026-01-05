import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import '/generic/filter_option/filter_option_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m_ilestone5/components_chat/mouse2/mouse2_widget.dart';
import 'chat_chats_widget.dart' show ChatChatsWidget;
import 'package:flutter/material.dart';

class ChatChatsModel extends FlutterFlowModel<ChatChatsWidget> {
  ///  Local state fields for this page.

  ChatsFilter? chatsFilter = ChatsFilter.all;

  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel1;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel2;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel3;
  // Models for mouse2 dynamic component.
  late FlutterFlowDynamicModels<Mouse2Model> mouse2Models;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    filterOptionModel1 = createModel(context, () => FilterOptionModel());
    filterOptionModel2 = createModel(context, () => FilterOptionModel());
    filterOptionModel3 = createModel(context, () => FilterOptionModel());
    mouse2Models = FlutterFlowDynamicModels(() => Mouse2Model());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    contentHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    filterOptionModel1.dispose();
    filterOptionModel2.dispose();
    filterOptionModel3.dispose();
    mouse2Models.dispose();
    mobileNavBar2Model.dispose();
  }
}
