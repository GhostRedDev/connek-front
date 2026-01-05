import '/components/alerts_i_a_widget.dart';
import '/components/bot_card_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/notification_card_aviso_widget.dart';
import '/components/notification_card_sugeren_widget.dart';
import '/components/notification_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'office_overview_widget.dart' show OfficeOverviewWidget;
import 'package:flutter/material.dart';

class OfficeOverviewModel extends FlutterFlowModel<OfficeOverviewWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Model for BotCard component.
  late BotCardModel botCardModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for AlertsIA component.
  late AlertsIAModel alertsIAModel1;
  // Model for AlertsIA component.
  late AlertsIAModel alertsIAModel2;
  // Model for AlertsIA component.
  late AlertsIAModel alertsIAModel3;
  // Model for NotificationCard component.
  late NotificationCardModel notificationCardModel;
  // Model for NotificationCardAviso component.
  late NotificationCardAvisoModel notificationCardAvisoModel;
  // Model for NotificationCardSugeren component.
  late NotificationCardSugerenModel notificationCardSugerenModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    botCardModel = createModel(context, () => BotCardModel());
    alertsIAModel1 = createModel(context, () => AlertsIAModel());
    alertsIAModel2 = createModel(context, () => AlertsIAModel());
    alertsIAModel3 = createModel(context, () => AlertsIAModel());
    notificationCardModel = createModel(context, () => NotificationCardModel());
    notificationCardAvisoModel =
        createModel(context, () => NotificationCardAvisoModel());
    notificationCardSugerenModel =
        createModel(context, () => NotificationCardSugerenModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    botCardModel.dispose();
    alertsIAModel1.dispose();
    alertsIAModel2.dispose();
    alertsIAModel3.dispose();
    notificationCardModel.dispose();
    notificationCardAvisoModel.dispose();
    notificationCardSugerenModel.dispose();
    emptySpaceModel.dispose();
  }
}
