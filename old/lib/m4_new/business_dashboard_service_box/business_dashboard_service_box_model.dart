import '/components/switch_booking_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/price_low2/price_low2_widget.dart';
import 'business_dashboard_service_box_widget.dart'
    show BusinessDashboardServiceBoxWidget;
import 'package:flutter/material.dart';

class BusinessDashboardServiceBoxModel
    extends FlutterFlowModel<BusinessDashboardServiceBoxWidget> {
  ///  Local state fields for this component.

  bool bookingEnabled = true;

  bool joseActive = true;

  ///  State fields for stateful widgets in this component.

  // Model for priceLow2 component.
  late PriceLow2Model priceLow2Model;
  // Model for switchBooking component.
  late SwitchBookingModel switchBookingModel1;
  // Model for switchBooking component.
  late SwitchBookingModel switchBookingModel2;

  @override
  void initState(BuildContext context) {
    priceLow2Model = createModel(context, () => PriceLow2Model());
    switchBookingModel1 = createModel(context, () => SwitchBookingModel());
    switchBookingModel2 = createModel(context, () => SwitchBookingModel());
  }

  @override
  void dispose() {
    priceLow2Model.dispose();
    switchBookingModel1.dispose();
    switchBookingModel2.dispose();
  }
}
