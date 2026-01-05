import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components_deprecated/chat_i_n_d/chat_i_n_d_widget.dart';
import 'chat_t_i_p_o2_widget.dart' show ChatTIPO2Widget;
import 'package:flutter/material.dart';

class ChatTIPO2Model extends FlutterFlowModel<ChatTIPO2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Chat_IND component.
  late ChatINDModel chatINDModel1;
  // Model for Chat_IND component.
  late ChatINDModel chatINDModel2;

  @override
  void initState(BuildContext context) {
    chatINDModel1 = createModel(context, () => ChatINDModel());
    chatINDModel2 = createModel(context, () => ChatINDModel());
  }

  @override
  void dispose() {
    chatINDModel1.dispose();
    chatINDModel2.dispose();
  }
}
