import '/flutter_flow/flutter_flow_util.dart';
import '/m_ilestone8/payment_method2/payment_method2_widget.dart';
import 'payment_methods_list_widget.dart' show PaymentMethodsListWidget;
import 'package:flutter/material.dart';

class PaymentMethodsListModel
    extends FlutterFlowModel<PaymentMethodsListWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for paymentMethod2 component.
  late PaymentMethod2Model paymentMethod2Model1;

  @override
  void initState(BuildContext context) {
    paymentMethod2Model1 = createModel(context, () => PaymentMethod2Model());
  }

  @override
  void dispose() {
    paymentMethod2Model1.dispose();
  }
}
