import '/backend/schema/structs/index.dart';
import '/components/empty_space_widget.dart';
import '/components/event_card_widget.dart';
import '/components/review_card_widget.dart';
import '/components/search_result_service_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/components/loading_dialog/loading_dialog_widget.dart';
import 'business_public_page_widget.dart' show BusinessPublicPageWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BusinessPublicPageModel
    extends FlutterFlowModel<BusinessPublicPageWidget> {
  ///  Local state fields for this page.

  BusinessDataStruct? businessData;
  void updateBusinessDataStruct(Function(BusinessDataStruct) updateFn) {
    updateFn(businessData ??= BusinessDataStruct());
  }

  List<ServiceDataStruct> servicesData = [];
  void addToServicesData(ServiceDataStruct item) => servicesData.add(item);
  void removeFromServicesData(ServiceDataStruct item) =>
      servicesData.remove(item);
  void removeAtIndexFromServicesData(int index) => servicesData.removeAt(index);
  void insertAtIndexInServicesData(int index, ServiceDataStruct item) =>
      servicesData.insert(index, item);
  void updateServicesDataAtIndex(
          int index, Function(ServiceDataStruct) updateFn) =>
      servicesData[index] = updateFn(servicesData[index]);

  bool loading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - loadBusinessData] action in BusinessPublicPage widget.
  BusinessDataStruct? parsedBusinessData;
  // Model for loadingDialog component.
  late LoadingDialogModel loadingDialogModel;
  // State field(s) for AboutUsExpandable widget.
  late ExpandableController aboutUsExpandableExpandableController;

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for SearchResultServiceCard dynamic component.
  late FlutterFlowDynamicModels<SearchResultServiceCardModel>
      searchResultServiceCardModels;
  // Model for EventCard component.
  late EventCardModel eventCardModel;
  // Model for ReviewCard component.
  late ReviewCardModel reviewCardModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    loadingDialogModel = createModel(context, () => LoadingDialogModel());
    searchResultServiceCardModels =
        FlutterFlowDynamicModels(() => SearchResultServiceCardModel());
    eventCardModel = createModel(context, () => EventCardModel());
    reviewCardModel = createModel(context, () => ReviewCardModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    loadingDialogModel.dispose();
    aboutUsExpandableExpandableController.dispose();
    tabBarController?.dispose();
    searchResultServiceCardModels.dispose();
    eventCardModel.dispose();
    reviewCardModel.dispose();
    emptySpaceModel.dispose();
  }
}
