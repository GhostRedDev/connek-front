import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/favorite_profile_widget.dart';
import '/components/favorite_service_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'client_bookmarks_widget.dart' show ClientBookmarksWidget;
import 'package:flutter/material.dart';

class ClientBookmarksModel extends FlutterFlowModel<ClientBookmarksWidget> {
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
  // Model for FavoriteProfile component.
  late FavoriteProfileModel favoriteProfileModel;
  // Model for FavoriteService component.
  late FavoriteServiceModel favoriteServiceModel;
  // Model for EmptySpace component.
  late EmptySpaceModel emptySpaceModel;

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    contentHeaderModel = createModel(context, () => ContentHeaderModel());
    favoriteProfileModel = createModel(context, () => FavoriteProfileModel());
    favoriteServiceModel = createModel(context, () => FavoriteServiceModel());
    emptySpaceModel = createModel(context, () => EmptySpaceModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    contentHeaderModel.dispose();
    favoriteProfileModel.dispose();
    favoriteServiceModel.dispose();
    emptySpaceModel.dispose();
  }
}
