import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_menu_widget.dart' show ProfileMenuWidget;
import 'package:flutter/material.dart';

class ProfileMenuModel extends FlutterFlowModel<ProfileMenuWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for profile.
  late TopMenuOptionModel profileModel;
  // Model for media.
  late TopMenuOptionModel mediaModel;
  // Model for reviews.
  late TopMenuOptionModel reviewsModel;
  // Model for settings.
  late TopMenuOptionModel settingsModel;

  @override
  void initState(BuildContext context) {
    profileModel = createModel(context, () => TopMenuOptionModel());
    mediaModel = createModel(context, () => TopMenuOptionModel());
    reviewsModel = createModel(context, () => TopMenuOptionModel());
    settingsModel = createModel(context, () => TopMenuOptionModel());
  }

  @override
  void dispose() {
    profileModel.dispose();
    mediaModel.dispose();
    reviewsModel.dispose();
    settingsModel.dispose();
  }
}
