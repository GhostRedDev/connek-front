import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'full_calendar_book_widget.dart' show FullCalendarBookWidget;
import 'package:flutter/material.dart';

class FullCalendarBookModel extends FlutterFlowModel<FullCalendarBookWidget> {
  ///  Local state fields for this component.

  BookingSlotStruct? selectedSlot;
  void updateSelectedSlotStruct(Function(BookingSlotStruct) updateFn) {
    updateFn(selectedSlot ??= BookingSlotStruct());
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
