import '/components/business_bookings_widget.dart';
import '/components/business_clients_widget.dart';
import '/components/business_empleados_widget.dart';
import '/components/business_factura_widget.dart';
import '/components/business_leads_widget.dart';
import '/components/business_overview_widget.dart';
import '/components/business_profile_widget.dart';
import '/components/business_services_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/m10_profile/business_menu/business_menu_widget.dart';
import 'business_page_widget.dart' show BusinessPageWidget;
import 'package:flutter/material.dart';

class BusinessPageModel extends FlutterFlowModel<BusinessPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for BusinessOverview component.
  late BusinessOverviewModel businessOverviewModel;
  // Model for BusinessClients component.
  late BusinessClientsModel businessClientsModel;
  // Model for BusinessLeads component.
  late BusinessLeadsModel businessLeadsModel;
  // Model for BusinessServices component.
  late BusinessServicesModel businessServicesModel;
  // Model for BusinessEmpleados component.
  late BusinessEmpleadosModel businessEmpleadosModel;
  // Model for BusinessProfile component.
  late BusinessProfileModel businessProfileModel;
  // Model for BusinessFactura component.
  late BusinessFacturaModel businessFacturaModel;
  // Model for BusinessBookings component.
  late BusinessBookingsModel businessBookingsModel;
  // Model for mobileNavBar2 component.
  late MobileNavBar2Model mobileNavBar2Model;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for BusinessMenu component.
  late BusinessMenuModel businessMenuModel;

  @override
  void initState(BuildContext context) {
    businessOverviewModel = createModel(context, () => BusinessOverviewModel());
    businessClientsModel = createModel(context, () => BusinessClientsModel());
    businessLeadsModel = createModel(context, () => BusinessLeadsModel());
    businessServicesModel = createModel(context, () => BusinessServicesModel());
    businessEmpleadosModel =
        createModel(context, () => BusinessEmpleadosModel());
    businessProfileModel = createModel(context, () => BusinessProfileModel());
    businessFacturaModel = createModel(context, () => BusinessFacturaModel());
    businessBookingsModel = createModel(context, () => BusinessBookingsModel());
    mobileNavBar2Model = createModel(context, () => MobileNavBar2Model());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    businessMenuModel = createModel(context, () => BusinessMenuModel());
  }

  @override
  void dispose() {
    businessOverviewModel.dispose();
    businessClientsModel.dispose();
    businessLeadsModel.dispose();
    businessServicesModel.dispose();
    businessEmpleadosModel.dispose();
    businessProfileModel.dispose();
    businessFacturaModel.dispose();
    businessBookingsModel.dispose();
    mobileNavBar2Model.dispose();
    mobileAppBarModel.dispose();
    businessMenuModel.dispose();
  }
}
