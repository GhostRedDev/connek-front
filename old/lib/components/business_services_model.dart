import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/event_card_widget.dart';
import '/components/service_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'business_services_widget.dart' show BusinessServicesWidget;
import 'package:flutter/material.dart';

class BusinessServicesModel extends FlutterFlowModel<BusinessServicesWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for EventCard component.
  late EventCardModel eventCardModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for ServiceCard dynamic component.
  late FlutterFlowDynamicModels<ServiceCardModel> serviceCardModels;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    eventCardModel = createModel(context, () => EventCardModel());
    serviceCardModels = FlutterFlowDynamicModels(() => ServiceCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    eventCardModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    serviceCardModels.dispose();
    emptySpaceModel.dispose();
  }
}
