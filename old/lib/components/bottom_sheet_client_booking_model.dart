import '/components/full_calendar_book_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_sheet_client_booking_widget.dart'
    show BottomSheetClientBookingWidget;
import 'package:flutter/material.dart';

class BottomSheetClientBookingModel
    extends FlutterFlowModel<BottomSheetClientBookingWidget> {
  ///  Local state fields for this component.

  bool reschedule = false;

  ///  State fields for stateful widgets in this component.

  // Model for FullCalendarBook component.
  late FullCalendarBookModel fullCalendarBookModel;
  // Stores action output result for [Action Block - multiPurposeDialog] action in FullCalendarBook widget.
  bool? confirm;

  @override
  void initState(BuildContext context) {
    fullCalendarBookModel = createModel(context, () => FullCalendarBookModel());
  }

  @override
  void dispose() {
    fullCalendarBookModel.dispose();
  }
}
