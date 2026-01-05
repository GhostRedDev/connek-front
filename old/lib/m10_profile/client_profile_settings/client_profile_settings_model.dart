import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'client_profile_settings_widget.dart' show ClientProfileSettingsWidget;
import 'package:flutter/material.dart';

class ClientProfileSettingsModel
    extends FlutterFlowModel<ClientProfileSettingsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue1;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue2;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue3;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue4;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue5;

  @override
  void initState(BuildContext context) {
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
  }

  @override
  void dispose() {
    contentHeaderModel.dispose();
  }
}
