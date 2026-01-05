import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/business_settings_deposit/business_settings_deposit_widget.dart';
import '/m4_new/components/business_settings_o_l_d/business_settings_o_l_d_widget.dart';
import 'business_profile_settings_widget.dart'
    show BusinessProfileSettingsWidget;
import 'package:flutter/material.dart';

class BusinessProfileSettingsModel
    extends FlutterFlowModel<BusinessProfileSettingsWidget> {
  ///  Local state fields for this component.

  String? view;

  ///  State fields for stateful widgets in this component.

  // Model for BusinessSettingsOLD component.
  late BusinessSettingsOLDModel businessSettingsOLDModel;
  // Model for BusinessSettingsDeposit component.
  late BusinessSettingsDepositModel businessSettingsDepositModel;

  @override
  void initState(BuildContext context) {
    businessSettingsOLDModel =
        createModel(context, () => BusinessSettingsOLDModel());
    businessSettingsDepositModel =
        createModel(context, () => BusinessSettingsDepositModel());
  }

  @override
  void dispose() {
    businessSettingsOLDModel.dispose();
    businessSettingsDepositModel.dispose();
  }
}
