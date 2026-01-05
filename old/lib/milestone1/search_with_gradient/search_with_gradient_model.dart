import '/flutter_flow/flutter_flow_util.dart';
import '/milestone1/resultado_test_grande/resultado_test_grande_widget.dart';
import 'search_with_gradient_widget.dart' show SearchWithGradientWidget;
import 'package:flutter/material.dart';

class SearchWithGradientModel
    extends FlutterFlowModel<SearchWithGradientWidget> {
  ///  Local state fields for this page.

  int? selectedService = 0;

  List<int> services = [];
  void addToServices(int item) => services.add(item);
  void removeFromServices(int item) => services.remove(item);
  void removeAtIndexFromServices(int index) => services.removeAt(index);
  void insertAtIndexInServices(int index, int item) =>
      services.insert(index, item);
  void updateServicesAtIndex(int index, Function(int) updateFn) =>
      services[index] = updateFn(services[index]);

  ///  State fields for stateful widgets in this page.

  // Models for resultadoTestGrande dynamic component.
  late FlutterFlowDynamicModels<ResultadoTestGrandeModel>
      resultadoTestGrandeModels;

  @override
  void initState(BuildContext context) {
    resultadoTestGrandeModels =
        FlutterFlowDynamicModels(() => ResultadoTestGrandeModel());
  }

  @override
  void dispose() {
    resultadoTestGrandeModels.dispose();
  }
}
