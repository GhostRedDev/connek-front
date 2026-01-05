import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/numbers_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m_ilestone8/payment_method2/payment_method2_widget.dart';
import 'bottom_sheet_deposit_widget.dart' show BottomSheetDepositWidget;
import 'package:flutter/material.dart';

class BottomSheetDepositModel
    extends FlutterFlowModel<BottomSheetDepositWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for amountField.
  late NumbersFieldCompModel amountFieldModel;
  // Model for paymentMethod2 component.
  late PaymentMethod2Model paymentMethod2Model;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    amountFieldModel = createModel(context, () => NumbersFieldCompModel());
    paymentMethod2Model = createModel(context, () => PaymentMethod2Model());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    amountFieldModel.dispose();
    paymentMethod2Model.dispose();
    emptySpaceModel.dispose();
  }
}
