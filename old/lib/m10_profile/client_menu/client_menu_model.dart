import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'client_menu_widget.dart' show ClientMenuWidget;
import 'package:flutter/material.dart';

class ClientMenuModel extends FlutterFlowModel<ClientMenuWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for requests.
  late TopMenuOptionModel requestsModel;
  // Model for bookings.
  late TopMenuOptionModel bookingsModel;
  // Model for bookmarks.
  late TopMenuOptionModel bookmarksModel;
  // Model for wallet.
  late TopMenuOptionModel walletModel;

  @override
  void initState(BuildContext context) {
    requestsModel = createModel(context, () => TopMenuOptionModel());
    bookingsModel = createModel(context, () => TopMenuOptionModel());
    bookmarksModel = createModel(context, () => TopMenuOptionModel());
    walletModel = createModel(context, () => TopMenuOptionModel());
  }

  @override
  void dispose() {
    requestsModel.dispose();
    bookingsModel.dispose();
    bookmarksModel.dispose();
    walletModel.dispose();
  }
}
