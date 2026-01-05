import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/back_button_widget.dart';
import '/components/full_calendar_book_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import 'client_booking_service_widget.dart' show ClientBookingServiceWidget;
import 'package:flutter/material.dart';

class ClientBookingServiceModel
    extends FlutterFlowModel<ClientBookingServiceWidget> {
  ///  Local state fields for this page.

  String leadsFilter = 'all';

  String requestQueryFilter = 'all';

  String filter = 'All';

  List<LeadsRow> leads = [];
  void addToLeads(LeadsRow item) => leads.add(item);
  void removeFromLeads(LeadsRow item) => leads.remove(item);
  void removeAtIndexFromLeads(int index) => leads.removeAt(index);
  void insertAtIndexInLeads(int index, LeadsRow item) =>
      leads.insert(index, item);
  void updateLeadsAtIndex(int index, Function(LeadsRow) updateFn) =>
      leads[index] = updateFn(leads[index]);

  List<BusinessRow> businesses = [];
  void addToBusinesses(BusinessRow item) => businesses.add(item);
  void removeFromBusinesses(BusinessRow item) => businesses.remove(item);
  void removeAtIndexFromBusinesses(int index) => businesses.removeAt(index);
  void insertAtIndexInBusinesses(int index, BusinessRow item) =>
      businesses.insert(index, item);
  void updateBusinessesAtIndex(int index, Function(BusinessRow) updateFn) =>
      businesses[index] = updateFn(businesses[index]);

  ResourceDataStruct? selectedResource;
  void updateSelectedResourceStruct(Function(ResourceDataStruct) updateFn) {
    updateFn(selectedResource ??= ResourceDataStruct());
  }

  List<BookingSlotStruct> bookingSlots = [];
  void addToBookingSlots(BookingSlotStruct item) => bookingSlots.add(item);
  void removeFromBookingSlots(BookingSlotStruct item) =>
      bookingSlots.remove(item);
  void removeAtIndexFromBookingSlots(int index) => bookingSlots.removeAt(index);
  void insertAtIndexInBookingSlots(int index, BookingSlotStruct item) =>
      bookingSlots.insert(index, item);
  void updateBookingSlotsAtIndex(
          int index, Function(BookingSlotStruct) updateFn) =>
      bookingSlots[index] = updateFn(bookingSlots[index]);

  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for FullCalendarBook component.
  late FullCalendarBookModel fullCalendarBookModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    fullCalendarBookModel = createModel(context, () => FullCalendarBookModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    backButtonModel.dispose();
    fullCalendarBookModel.dispose();
    mobileNavBar2Model.dispose();
  }
}
