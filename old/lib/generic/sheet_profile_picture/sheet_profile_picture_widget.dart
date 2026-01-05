import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sheet_profile_picture_model.dart';
export 'sheet_profile_picture_model.dart';

class SheetProfilePictureWidget extends StatefulWidget {
  const SheetProfilePictureWidget({
    super.key,
    required this.forWhat,
  });

  final String? forWhat;

  @override
  State<SheetProfilePictureWidget> createState() =>
      _SheetProfilePictureWidgetState();
}

class _SheetProfilePictureWidgetState extends State<SheetProfilePictureWidget> {
  late SheetProfilePictureModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SheetProfilePictureModel());

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
      height: 270.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(
              0.0,
              -3.0,
            ),
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  final selectedMedia = await selectMediaWithSourceBottomSheet(
                    context: context,
                    imageQuality: 100,
                    allowPhoto: true,
                  );
                  if (selectedMedia != null &&
                      selectedMedia.every(
                          (m) => validateFileFormat(m.storagePath, context))) {
                    safeSetState(
                        () => _model.isDataUploading_uploadData9gk = true);
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
                      _model.isDataUploading_uploadData9gk = false;
                    }
                    if (selectedUploadedFiles.length == selectedMedia.length) {
                      safeSetState(() {
                        _model.uploadedLocalFile_uploadData9gk =
                            selectedUploadedFiles.first;
                      });
                    } else {
                      safeSetState(() {});
                      return;
                    }
                  }

                  if (widget.forWhat == 'clientProfile' ? true : false) {
                    _model.uploadedProfilePictureQuery = await ConnekApiGroup
                        .updateClientProfilePictureCall
                        .call(
                      clientId: FFAppState().account.clientId,
                      file: _model.uploadedLocalFile_uploadData9gk,
                      jwtToken: currentJwtToken,
                    );

                    if ((_model.uploadedProfilePictureQuery?.succeeded ??
                        true)) {
                      await action_blocks.successSnackbar(
                        context,
                        message: 'Success',
                      );
                      await action_blocks.loadClient(context);
                    } else {
                      await action_blocks.errorSnackbar(
                        context,
                        message: getJsonField(
                          (_model.uploadedProfilePictureQuery?.jsonBody ?? ''),
                          r'''$.error''',
                        ).toString(),
                      );
                    }
                  } else if (widget.forWhat == 'businessLogo') {
                    _model.uploadedBusinessLogoQuery =
                        await ConnekApiGroup.updateBusinessLogoCall.call(
                      businessId: FFAppState().account.businessId,
                      file: _model.uploadedLocalFile_uploadData9gk,
                      jwtToken: currentJwtToken,
                    );

                    if ((_model.uploadedBusinessLogoQuery?.succeeded ?? true)) {
                      await action_blocks.successSnackbar(
                        context,
                        message: 'Success',
                      );
                      _model.businessQueryLogo =
                          await action_blocks.loadBusinessData(
                        context,
                        businessId: FFAppState().account.businessId,
                      );
                      FFAppState().businessData = _model.businessQueryLogo!;
                      FFAppState().update(() {});
                    } else {
                      await action_blocks.errorSnackbar(
                        context,
                        message: getJsonField(
                          (_model.uploadedBusinessLogoQuery?.jsonBody ?? ''),
                          r'''$.error''',
                        ).toString(),
                      );
                    }
                  } else if (widget.forWhat == 'businessBanner') {
                    _model.uploadedBusinessBannerQuery =
                        await ConnekApiGroup.updateBusinessBannerCall.call(
                      businessId: FFAppState().account.businessId,
                      file: _model.uploadedLocalFile_uploadData9gk,
                      jwtToken: currentJwtToken,
                    );

                    if ((_model.uploadedBusinessBannerQuery?.succeeded ??
                        true)) {
                      await action_blocks.successSnackbar(
                        context,
                        message: 'Success',
                      );
                      _model.businessQueryBanner =
                          await action_blocks.loadBusinessData(
                        context,
                        businessId: FFAppState().account.businessId,
                      );
                      FFAppState().businessData = _model.businessQueryBanner!;
                      FFAppState().update(() {});
                    } else {
                      await action_blocks.errorSnackbar(
                        context,
                        message: getJsonField(
                          (_model.uploadedBusinessBannerQuery?.jsonBody ?? ''),
                          r'''$.error''',
                        ).toString(),
                      );
                    }
                  } else {
                    await action_blocks.errorSnackbar(
                      context,
                      message: 'Not available yet',
                    );
                  }

                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: 'Change Picture',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 40.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: const Color(0xFF4F87C9),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: 'Cancel',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
