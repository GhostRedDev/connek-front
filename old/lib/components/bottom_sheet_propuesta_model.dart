import '/backend/supabase/supabase.dart';
import '/components/lead_card_info_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_sheet_propuesta_widget.dart' show BottomSheetPropuestaWidget;
import 'package:flutter/material.dart';

class BottomSheetPropuestaModel
    extends FlutterFlowModel<BottomSheetPropuestaWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for LeadCardInfoBottomSheet component.
  late LeadCardInfoBottomSheetModel leadCardInfoBottomSheetModel;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for duration widget.
  FocusNode? durationFocusNode;
  TextEditingController? durationTextController;
  String? Function(BuildContext, String?)? durationTextControllerValidator;
  // Stores action output result for [Action Block - multiPurposeDialog] action in Container widget.
  bool? confirm;
  // Stores action output result for [Backend Call - Insert Row] action in Container widget.
  QuoteRow? newQuoteQuery;

  @override
  void initState(BuildContext context) {
    leadCardInfoBottomSheetModel =
        createModel(context, () => LeadCardInfoBottomSheetModel());
  }

  @override
  void dispose() {
    leadCardInfoBottomSheetModel.dispose();
    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    durationFocusNode?.dispose();
    durationTextController?.dispose();
  }
}
