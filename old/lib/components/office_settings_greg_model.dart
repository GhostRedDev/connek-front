import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/greg_blacklist_widget.dart';
import '/components/integration_card_widget.dart';
import '/components/notification_ad_widget.dart';
import '/components/office_train_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'office_settings_greg_widget.dart' show OfficeSettingsGregWidget;
import 'package:flutter/material.dart';

class OfficeSettingsGregModel
    extends FlutterFlowModel<OfficeSettingsGregWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for OfficeTrainHeader component.
  late OfficeTrainHeaderModel officeTrainHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for ToneRadioButton widget.
  FormFieldController<String>? toneRadioButtonValueController;
  // State field(s) for BlackListField widget.
  FocusNode? blackListFieldFocusNode;
  TextEditingController? blackListFieldTextController;
  String? Function(BuildContext, String?)?
      blackListFieldTextControllerValidator;
  // Models for GregBlacklist dynamic component.
  late FlutterFlowDynamicModels<GregBlacklistModel> gregBlacklistModels;
  // Model for IntegrationCard component.
  late IntegrationCardModel integrationCardModel;
  // Model for NotificationAd component.
  late NotificationAdModel notificationAdModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    officeTrainHeaderModel =
        createModel(context, () => OfficeTrainHeaderModel());
    gregBlacklistModels = FlutterFlowDynamicModels(() => GregBlacklistModel());
    integrationCardModel = createModel(context, () => IntegrationCardModel());
    notificationAdModel = createModel(context, () => NotificationAdModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    officeTrainHeaderModel.dispose();
    tabBarController?.dispose();
    blackListFieldFocusNode?.dispose();
    blackListFieldTextController?.dispose();

    gregBlacklistModels.dispose();
    integrationCardModel.dispose();
    notificationAdModel.dispose();
    emptySpaceModel.dispose();
  }

  /// Additional helper methods.
  String? get toneRadioButtonValue => toneRadioButtonValueController?.value;
}
