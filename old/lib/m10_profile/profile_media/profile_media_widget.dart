import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/generic/content_header_profile/content_header_profile_widget.dart';
import '/m4_new/components/profile_gallery/profile_gallery_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_media_model.dart';
export 'profile_media_model.dart';

class ProfileMediaWidget extends StatefulWidget {
  const ProfileMediaWidget({super.key});

  @override
  State<ProfileMediaWidget> createState() => _ProfileMediaWidgetState();
}

class _ProfileMediaWidgetState extends State<ProfileMediaWidget> {
  late ProfileMediaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileMediaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.contentHeaderProfileModel,
                updateCallback: () => safeSetState(() {}),
                child: const ContentHeaderProfileWidget(
                  title: 'Media',
                  subtitle: 'See your images',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add media',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 99999.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).primary,
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      final selectedMedia = await selectMedia(
                        mediaSource: MediaSource.photoGallery,
                        multiImage: true,
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        safeSetState(
                            () => _model.isDataUploading_uploadDataG2z = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        try {
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                    originalFilename: m.originalFilename,
                                  ))
                              .toList();
                        } finally {
                          _model.isDataUploading_uploadDataG2z = false;
                        }
                        if (selectedUploadedFiles.length ==
                            selectedMedia.length) {
                          safeSetState(() {
                            _model.uploadedLocalFiles_uploadDataG2z =
                                selectedUploadedFiles;
                          });
                        } else {
                          safeSetState(() {});
                          return;
                        }
                      }

                      if (FFAppState().account.isBusiness == true) {
                        await action_blocks.uploadBusinessFiles(
                          context,
                          files: _model.uploadedLocalFiles_uploadDataG2z,
                        );
                        safeSetState(() {});
                      } else {
                        await action_blocks.uploadClientFiles(
                          context,
                          files: _model.uploadedLocalFiles_uploadDataG2z,
                        );
                      }
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: wrapWithModel(
                  model: _model.profileGalleryModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: ProfileGalleryWidget(
                    filesUrl: FFAppState().account.isBusiness
                        ? functions.stringToList(valueOrDefault<String>(
                            FFAppState().businessData.images,
                            'https://images.pexels.com/photos/33851801/pexels-photo-33851801.jpeg',
                          ))
                        : functions
                            .stringToList(FFAppState().clientProfile.images),
                  ),
                ),
              ),
            ].divide(const SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
