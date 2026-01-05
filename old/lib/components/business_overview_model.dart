import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/event_card_widget.dart';
import '/components/my_bots_greg_widget.dart';
import '/components/service_mini_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'business_overview_widget.dart' show BusinessOverviewWidget;
import 'package:flutter/material.dart';

class BusinessOverviewModel extends FlutterFlowModel<BusinessOverviewWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Model for MyBotsGreg component.
  late MyBotsGregModel myBotsGregModel;
  // Models for ServiceMiniCard dynamic component.
  late FlutterFlowDynamicModels<ServiceMiniCardModel> serviceMiniCardModels;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for EventCard component.
  late EventCardModel eventCardModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    myBotsGregModel = createModel(context, () => MyBotsGregModel());
    serviceMiniCardModels =
        FlutterFlowDynamicModels(() => ServiceMiniCardModel());
    eventCardModel = createModel(context, () => EventCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    myBotsGregModel.dispose();
    serviceMiniCardModels.dispose();
    eventCardModel.dispose();
    emptySpaceModel.dispose();
  }
}
