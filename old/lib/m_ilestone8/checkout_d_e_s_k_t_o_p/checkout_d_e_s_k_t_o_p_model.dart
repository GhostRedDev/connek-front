import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import 'checkout_d_e_s_k_t_o_p_widget.dart' show CheckoutDESKTOPWidget;
import 'package:flutter/material.dart';

class CheckoutDESKTOPModel extends FlutterFlowModel<CheckoutDESKTOPWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
  }
}
