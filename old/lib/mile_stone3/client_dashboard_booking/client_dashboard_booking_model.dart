import '/backend/supabase/supabase.dart';
import '/components/full_calendar_book_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/mile_stone3/components3/side_bar_client_dashboard/side_bar_client_dashboard_widget.dart';
import 'client_dashboard_booking_widget.dart' show ClientDashboardBookingWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ClientDashboardBookingModel
    extends FlutterFlowModel<ClientDashboardBookingWidget> {
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

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for SideBarClientDashboard component.
  late SideBarClientDashboardModel sideBarClientDashboardModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // Model for FullCalendarBook component.
  late FullCalendarBookModel fullCalendarBookModel;
  // Stores action output result for [Action Block - multiPurposeDialog] action in FullCalendarBook widget.
  bool? response;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    sideBarClientDashboardModel =
        createModel(context, () => SideBarClientDashboardModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    fullCalendarBookModel = createModel(context, () => FullCalendarBookModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    sideBarClientDashboardModel.dispose();
    mobileAppBarModel.dispose();
    expandableExpandableController.dispose();
    fullCalendarBookModel.dispose();
    mobileNavBarModel.dispose();
  }
}
