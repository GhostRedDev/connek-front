import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/theme_switch/theme_switch_widget.dart';
import 'control_sheet_widget.dart' show ControlSheetWidget;
import 'package:flutter/material.dart';

class ControlSheetModel extends FlutterFlowModel<ControlSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for themeSwitch component.
  late ThemeSwitchModel themeSwitchModel;
  // Stores action output result for [Action Block - loadBusinessData] action in Container widget.
  BusinessDataStruct? businessDataQuery;

  @override
  void initState(BuildContext context) {
    themeSwitchModel = createModel(context, () => ThemeSwitchModel());
  }

  @override
  void dispose() {
    themeSwitchModel.dispose();
  }
}
