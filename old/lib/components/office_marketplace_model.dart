import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/marketplace_bot_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'office_marketplace_widget.dart' show OfficeMarketplaceWidget;
import 'package:flutter/material.dart';

class OfficeMarketplaceModel extends FlutterFlowModel<OfficeMarketplaceWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // Model for MarketplaceBot component.
  late MarketplaceBotModel marketplaceBotModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    marketplaceBotModel = createModel(context, () => MarketplaceBotModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    marketplaceBotModel.dispose();
    emptySpaceModel.dispose();
  }
}
