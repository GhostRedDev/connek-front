import '/components/full_calendar_book_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'booking_sheet_form_widget.dart' show BookingSheetFormWidget;
import 'package:flutter/material.dart';

class BookingSheetFormModel extends FlutterFlowModel<BookingSheetFormWidget> {
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
