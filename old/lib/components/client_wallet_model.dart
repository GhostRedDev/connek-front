import '/components/client_transactions_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/wallet_balance_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'client_wallet_widget.dart' show ClientWalletWidget;
import 'package:flutter/material.dart';

class ClientWalletModel extends FlutterFlowModel<ClientWalletWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for WalletBalance component.
  late WalletBalanceModel walletBalanceModel;
  // Model for ClientTransactions component.
  late ClientTransactionsModel clientTransactionsModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    walletBalanceModel = createModel(context, () => WalletBalanceModel());
    clientTransactionsModel =
        createModel(context, () => ClientTransactionsModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    walletBalanceModel.dispose();
    clientTransactionsModel.dispose();
    emptySpaceModel.dispose();
  }
}
