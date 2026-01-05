import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m_ilestone8/payment_method/payment_method_widget.dart';
import '/m_ilestone8/payment_method_default/payment_method_default_widget.dart';
import 'client_dashboard_wallet_methods_widget.dart'
    show ClientDashboardWalletMethodsWidget;
import 'package:flutter/material.dart';

class ClientDashboardWalletMethodsModel
    extends FlutterFlowModel<ClientDashboardWalletMethodsWidget> {
  ///  Local state fields for this page.

  double currentX = 0.0;

  bool isLocked = true;

  String buttontext = 'Proceed to Payment';

  ///  State fields for stateful widgets in this page.

  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for paymentMethodDefault component.
  late PaymentMethodDefaultModel paymentMethodDefaultModel;
  // Models for paymentMethod dynamic component.
  late FlutterFlowDynamicModels<PaymentMethodModel> paymentMethodModels;
  // Stores action output result for [Backend Call - API (Setup Payment Method)] action in Container widget.
  ApiCallResponse? setupPaymentQuery;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    paymentMethodDefaultModel =
        createModel(context, () => PaymentMethodDefaultModel());
    paymentMethodModels = FlutterFlowDynamicModels(() => PaymentMethodModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    desktopHeaderModel.dispose();
    mobileAppBarModel.dispose();
    paymentMethodDefaultModel.dispose();
    paymentMethodModels.dispose();
    mobileNavBarModel.dispose();
  }
}
