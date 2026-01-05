import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sheet_business_banner_widget.dart' show SheetBusinessBannerWidget;
import 'package:flutter/material.dart';

class SheetBusinessBannerModel
    extends FlutterFlowModel<SheetBusinessBannerWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataBusinessBanner = false;
  FFUploadedFile uploadedLocalFile_uploadDataBusinessBanner =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - API (Update Business Banner)] action in Button widget.
  ApiCallResponse? uploadedBannerQuery;
  // Stores action output result for [Action Block - loadBusinessData] action in Button widget.
  BusinessDataStruct? businessQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
