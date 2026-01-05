import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components_deprecated/chat_i_n_d/chat_i_n_d_widget.dart';
import '/mile_stone3/components_deprecated/chat_ind_contact/chat_ind_contact_widget.dart';
import 'chat_tipo_all_widget.dart' show ChatTipoAllWidget;
import 'package:flutter/material.dart';

class ChatTipoAllModel extends FlutterFlowModel<ChatTipoAllWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Chat_IND component.
  late ChatINDModel chatINDModel1;
  // Model for chat_ind_contact component.
  late ChatIndContactModel chatIndContactModel;
  // Model for Chat_IND component.
  late ChatINDModel chatINDModel2;

  @override
  void initState(BuildContext context) {
    chatINDModel1 = createModel(context, () => ChatINDModel());
    chatIndContactModel = createModel(context, () => ChatIndContactModel());
    chatINDModel2 = createModel(context, () => ChatINDModel());
  }

  @override
  void dispose() {
    chatINDModel1.dispose();
    chatIndContactModel.dispose();
    chatINDModel2.dispose();
  }
}
