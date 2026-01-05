import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components_deprecated/chat_i_n_d/chat_i_n_d_widget.dart';
import 'chat_tipo_business_widget.dart' show ChatTipoBusinessWidget;
import 'package:flutter/material.dart';

class ChatTipoBusinessModel extends FlutterFlowModel<ChatTipoBusinessWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Chat_IND component.
  late ChatINDModel chatINDModel1;
  // Model for Chat_IND component.
  late ChatINDModel chatINDModel2;
  // Model for Chat_IND component.
  late ChatINDModel chatINDModel3;

  @override
  void initState(BuildContext context) {
    chatINDModel1 = createModel(context, () => ChatINDModel());
    chatINDModel2 = createModel(context, () => ChatINDModel());
    chatINDModel3 = createModel(context, () => ChatINDModel());
  }

  @override
  void dispose() {
    chatINDModel1.dispose();
    chatINDModel2.dispose();
    chatINDModel3.dispose();
  }
}
