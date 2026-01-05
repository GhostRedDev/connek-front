import '/components/switch_booking_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'business_dashboard_service_box_desktop_widget.dart'
    show BusinessDashboardServiceBoxDesktopWidget;
import 'package:flutter/material.dart';

class BusinessDashboardServiceBoxDesktopModel
    extends FlutterFlowModel<BusinessDashboardServiceBoxDesktopWidget> {
  ///  Local state fields for this component.

  bool bookingEnabled = true;

  bool joseActive = true;

  ///  State fields for stateful widgets in this component.

  // Model for switchBooking component.
  late SwitchBookingModel switchBookingModel1;
  // Model for switchBooking component.
  late SwitchBookingModel switchBookingModel2;

  @override
  void initState(BuildContext context) {
    switchBookingModel1 = createModel(context, () => SwitchBookingModel());
    switchBookingModel2 = createModel(context, () => SwitchBookingModel());
  }

  @override
  void dispose() {
    switchBookingModel1.dispose();
    switchBookingModel2.dispose();
  }
}
