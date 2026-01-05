import '/flutter_flow/flutter_flow_util.dart';
import 'business_page_about_us_widget.dart' show BusinessPageAboutUsWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BusinessPageAboutUsModel
    extends FlutterFlowModel<BusinessPageAboutUsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
  }
}
