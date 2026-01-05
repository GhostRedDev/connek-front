import '/components/wallet_transaction_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'client_transactions_widget.dart' show ClientTransactionsWidget;
import 'package:flutter/material.dart';

class ClientTransactionsModel
    extends FlutterFlowModel<ClientTransactionsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for WalletTransaction dynamic component.
  late FlutterFlowDynamicModels<WalletTransactionModel> walletTransactionModels;

  @override
  void initState(BuildContext context) {
    walletTransactionModels =
        FlutterFlowDynamicModels(() => WalletTransactionModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    walletTransactionModels.dispose();
  }
}
