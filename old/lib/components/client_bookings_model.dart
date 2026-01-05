import '/components/booking_card_client_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'client_bookings_widget.dart' show ClientBookingsWidget;
import 'package:flutter/material.dart';

class ClientBookingsModel extends FlutterFlowModel<ClientBookingsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for BookingCardClient dynamic component.
  late FlutterFlowDynamicModels<BookingCardClientModel> bookingCardClientModels;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    bookingCardClientModels =
        FlutterFlowDynamicModels(() => BookingCardClientModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    bookingCardClientModels.dispose();
    emptySpaceModel.dispose();
  }
}
