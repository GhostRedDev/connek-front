import '/components/cotizar_info_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_sheet_cotizar_widget.dart' show BottomSheetCotizarWidget;
import 'package:flutter/material.dart';

class BottomSheetCotizarModel
    extends FlutterFlowModel<BottomSheetCotizarWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for CotizarInfoCard component.
  late CotizarInfoCardModel cotizarInfoCardModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {
    cotizarInfoCardModel = createModel(context, () => CotizarInfoCardModel());
  }

  @override
  void dispose() {
    cotizarInfoCardModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
