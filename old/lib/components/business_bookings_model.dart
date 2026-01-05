import '/components/booking_card_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'business_bookings_widget.dart' show BusinessBookingsWidget;
import 'package:flutter/material.dart';

class BusinessBookingsModel extends FlutterFlowModel<BusinessBookingsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for BookingCard dynamic component.
  late FlutterFlowDynamicModels<BookingCardModel> bookingCardModels;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    bookingCardModels = FlutterFlowDynamicModels(() => BookingCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    bookingCardModels.dispose();
    emptySpaceModel.dispose();
  }
}
