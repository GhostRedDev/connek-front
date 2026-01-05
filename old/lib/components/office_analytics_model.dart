import '/components/alerts_i_a_widget.dart';
import '/components/bot_analytics_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'office_analytics_widget.dart' show OfficeAnalyticsWidget;
import 'package:flutter/material.dart';

class OfficeAnalyticsModel extends FlutterFlowModel<OfficeAnalyticsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for BotAnalytics component.
  late BotAnalyticsModel botAnalyticsModel;
  // Model for AlertsIA component.
  late AlertsIAModel alertsIAModel1;
  // Model for AlertsIA component.
  late AlertsIAModel alertsIAModel2;
  // Model for AlertsIA component.
  late AlertsIAModel alertsIAModel3;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    botAnalyticsModel = createModel(context, () => BotAnalyticsModel());
    alertsIAModel1 = createModel(context, () => AlertsIAModel());
    alertsIAModel2 = createModel(context, () => AlertsIAModel());
    alertsIAModel3 = createModel(context, () => AlertsIAModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    botAnalyticsModel.dispose();
    alertsIAModel1.dispose();
    alertsIAModel2.dispose();
    alertsIAModel3.dispose();
    emptySpaceModel.dispose();
  }
}
