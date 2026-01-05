import '/backend/schema/structs/index.dart';
import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m_ilestone8/payment_method/payment_method_widget.dart';
import 'checkout_resume_widget.dart' show CheckoutResumeWidget;
import 'package:flutter/material.dart';

class CheckoutResumeModel extends FlutterFlowModel<CheckoutResumeWidget> {
  ///  Local state fields for this page.

  double currentX = 0.0;

  bool isLocked = true;

  String buttontext = 'Proceed to Payment';

  CheckoutTotalsStruct? checkoutTotals;
  void updateCheckoutTotalsStruct(Function(CheckoutTotalsStruct) updateFn) {
    updateFn(checkoutTotals ??= CheckoutTotalsStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for paymentMethod component.
  late PaymentMethodModel paymentMethodModel;
  // Stores action output result for [Action Block - multiPurposeDialog] action in SwipeToPayButton widget.
  bool? response;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    paymentMethodModel = createModel(context, () => PaymentMethodModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    backButtonModel.dispose();
    paymentMethodModel.dispose();
    mobileNavBarModel.dispose();
  }
}
