import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header_profile/content_header_profile_widget.dart';
import '/m4_new/components/profile_gallery/profile_gallery_widget.dart';
import 'profile_media_widget.dart' show ProfileMediaWidget;
import 'package:flutter/material.dart';

class ProfileMediaModel extends FlutterFlowModel<ProfileMediaWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ContentHeaderProfile component.
  late ContentHeaderProfileModel contentHeaderProfileModel;
  bool isDataUploading_uploadDataG2z = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataG2z = [];

  // Model for ProfileGallery component.
  late ProfileGalleryModel profileGalleryModel;

  @override
  void initState(BuildContext context) {
    contentHeaderProfileModel =
        createModel(context, () => ContentHeaderProfileModel());
    profileGalleryModel = createModel(context, () => ProfileGalleryModel());
  }

  @override
  void dispose() {
    contentHeaderProfileModel.dispose();
    profileGalleryModel.dispose();
  }
}
