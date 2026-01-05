import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components_deprecated/chat_ind_contact/chat_ind_contact_widget.dart';
import 'chat_tipo_contact_widget.dart' show ChatTipoContactWidget;
import 'package:flutter/material.dart';

class ChatTipoContactModel extends FlutterFlowModel<ChatTipoContactWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for chat_ind_contact component.
  late ChatIndContactModel chatIndContactModel1;
  // Model for chat_ind_contact component.
  late ChatIndContactModel chatIndContactModel2;

  @override
  void initState(BuildContext context) {
    chatIndContactModel1 = createModel(context, () => ChatIndContactModel());
    chatIndContactModel2 = createModel(context, () => ChatIndContactModel());
  }

  @override
  void dispose() {
    chatIndContactModel1.dispose();
    chatIndContactModel2.dispose();
  }
}
