import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sheet_profile_picture_widget.dart' show SheetProfilePictureWidget;
import 'package:flutter/material.dart';

class SheetProfilePictureModel
    extends FlutterFlowModel<SheetProfilePictureWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadData9gk = false;
  FFUploadedFile uploadedLocalFile_uploadData9gk =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - API (Update Client Profile Picture)] action in Button widget.
  ApiCallResponse? uploadedProfilePictureQuery;
  // Stores action output result for [Backend Call - API (Update Business Logo)] action in Button widget.
  ApiCallResponse? uploadedBusinessLogoQuery;
  // Stores action output result for [Action Block - loadBusinessData] action in Button widget.
  BusinessDataStruct? businessQueryLogo;
  // Stores action output result for [Backend Call - API (Update Business Banner)] action in Button widget.
  ApiCallResponse? uploadedBusinessBannerQuery;
  // Stores action output result for [Action Block - loadBusinessData] action in Button widget.
  BusinessDataStruct? businessQueryBanner;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
