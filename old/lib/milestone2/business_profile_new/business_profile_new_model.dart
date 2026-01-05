import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/desktop_header/desktop_header_widget.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/m4_new/components/footer/footer_widget.dart';
import '/milestone2/components/business_page_about_us/business_page_about_us_widget.dart';
import '/milestone2/components/business_page_banner/business_page_banner_widget.dart';
import '/milestone2/components/business_page_service_card/business_page_service_card_widget.dart';
import '/index.dart';
import 'business_profile_new_widget.dart' show BusinessProfileNewWidget;
import 'package:flutter/material.dart';

class BusinessProfileNewModel
    extends FlutterFlowModel<BusinessProfileNewWidget> {
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

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - loadBusinessData] action in BusinessProfileNew widget.
  BusinessDataStruct? parsedBusinessData;
  // State field(s) for desktop widget.
  bool desktopHovered = false;
  // Models for BusinessPageServiceCard dynamic component.
  late FlutterFlowDynamicModels<BusinessPageServiceCardModel>
      businessPageServiceCardModels1;
  // Models for BusinessPageServiceCard dynamic component.
  late FlutterFlowDynamicModels<BusinessPageServiceCardModel>
      businessPageServiceCardModels2;
  // Model for footer component.
  late FooterModel footerModel;
  // Model for desktopHeader component.
  late DesktopHeaderModel desktopHeaderModel;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for BusinessPageBanner component.
  late BusinessPageBannerModel businessPageBannerModel;
  // Model for BusinessPageAboutUs component.
  late BusinessPageAboutUsModel businessPageAboutUsModel;
  // Models for BusinessPageServiceCard dynamic component.
  late FlutterFlowDynamicModels<BusinessPageServiceCardModel>
      businessPageServiceCardModels3;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    businessPageServiceCardModels1 =
        FlutterFlowDynamicModels(() => BusinessPageServiceCardModel());
    businessPageServiceCardModels2 =
        FlutterFlowDynamicModels(() => BusinessPageServiceCardModel());
    footerModel = createModel(context, () => FooterModel());
    desktopHeaderModel = createModel(context, () => DesktopHeaderModel());
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    businessPageBannerModel =
        createModel(context, () => BusinessPageBannerModel());
    businessPageAboutUsModel =
        createModel(context, () => BusinessPageAboutUsModel());
    businessPageServiceCardModels3 =
        FlutterFlowDynamicModels(() => BusinessPageServiceCardModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    businessPageServiceCardModels1.dispose();
    businessPageServiceCardModels2.dispose();
    footerModel.dispose();
    desktopHeaderModel.dispose();
    mobileAppBarModel.dispose();
    businessPageBannerModel.dispose();
    businessPageAboutUsModel.dispose();
    businessPageServiceCardModels3.dispose();
    mobileNavBarModel.dispose();
  }
}
