import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/filter_option/filter_option_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/milestone2/components/business_page_about_us/business_page_about_us_widget.dart';
import '/milestone2/components/business_page_service_card/business_page_service_card_widget.dart';
import '/index.dart';
import 'business_profile_new_page_widget.dart'
    show BusinessProfileNewPageWidget;
import 'package:flutter/material.dart';

class BusinessProfileNewPageModel
    extends FlutterFlowModel<BusinessProfileNewPageWidget> {
  ///  Local state fields for this page.

  BusinessBar? barSelected = BusinessBar.Services;

  bool isHovered = false;

  BusinessDataStruct? businessData;
  void updateBusinessDataStruct(Function(BusinessDataStruct) updateFn) {
    updateFn(businessData ??= BusinessDataStruct());
  }

  List<ServiceDataStruct> servicesBusiness = [];
  void addToServicesBusiness(ServiceDataStruct item) =>
      servicesBusiness.add(item);
  void removeFromServicesBusiness(ServiceDataStruct item) =>
      servicesBusiness.remove(item);
  void removeAtIndexFromServicesBusiness(int index) =>
      servicesBusiness.removeAt(index);
  void insertAtIndexInServicesBusiness(int index, ServiceDataStruct item) =>
      servicesBusiness.insert(index, item);
  void updateServicesBusinessAtIndex(
          int index, Function(ServiceDataStruct) updateFn) =>
      servicesBusiness[index] = updateFn(servicesBusiness[index]);

  String? btnClick;

  ServiceDataStruct? expandedService;
  void updateExpandedServiceStruct(Function(ServiceDataStruct) updateFn) {
    updateFn(expandedService ??= ServiceDataStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - loadBusinessData] action in BusinessProfileNewPage widget.
  BusinessDataStruct? parsedBusinessData;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for BusinessPageAboutUs component.
  late BusinessPageAboutUsModel businessPageAboutUsModel;
  // Models for BusinessPageServiceCard dynamic component.
  late FlutterFlowDynamicModels<BusinessPageServiceCardModel>
      businessPageServiceCardModels;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel1;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel2;
  // Model for filterOption component.
  late FilterOptionModel filterOptionModel3;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    businessPageAboutUsModel =
        createModel(context, () => BusinessPageAboutUsModel());
    businessPageServiceCardModels =
        FlutterFlowDynamicModels(() => BusinessPageServiceCardModel());
    filterOptionModel1 = createModel(context, () => FilterOptionModel());
    filterOptionModel2 = createModel(context, () => FilterOptionModel());
    filterOptionModel3 = createModel(context, () => FilterOptionModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    businessPageAboutUsModel.dispose();
    businessPageServiceCardModels.dispose();
    filterOptionModel1.dispose();
    filterOptionModel2.dispose();
    filterOptionModel3.dispose();
    mobileNavBarModel.dispose();
  }
}
