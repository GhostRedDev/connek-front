import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'client_requests_widget.dart' show ClientRequestsWidget;
import 'package:flutter/material.dart';

class ClientRequestsModel extends FlutterFlowModel<ClientRequestsWidget> {
  ///  Local state fields for this component.

  RequestsFilter? requestFilter = RequestsFilter.all;

  List<ClientRequestStruct> requestList = [];
  void addToRequestList(ClientRequestStruct item) => requestList.add(item);
  void removeFromRequestList(ClientRequestStruct item) =>
      requestList.remove(item);
  void removeAtIndexFromRequestList(int index) => requestList.removeAt(index);
  void insertAtIndexInRequestList(int index, ClientRequestStruct item) =>
      requestList.insert(index, item);
  void updateRequestListAtIndex(
          int index, Function(ClientRequestStruct) updateFn) =>
      requestList[index] = updateFn(requestList[index]);

  ///  State fields for stateful widgets in this component.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  // Model for ContentHeader component.
  late ContentHeaderModel contentHeaderModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    emptySpaceModel.dispose();
  }
}
