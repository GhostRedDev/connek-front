import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_gallery_model.dart';
export 'profile_gallery_model.dart';

class ProfileGalleryWidget extends StatefulWidget {
  const ProfileGalleryWidget({
    super.key,
    required this.filesUrl,
  });

  final List<String>? filesUrl;

  @override
  State<ProfileGalleryWidget> createState() => _ProfileGalleryWidgetState();
}

class _ProfileGalleryWidgetState extends State<ProfileGalleryWidget> {
  late ProfileGalleryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileGalleryModel());

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

    return Builder(
      builder: (context) {
        final images = widget.filesUrl!.toList();

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 0.8,
          ),
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (context, imagesIndex) {
            final imagesItem = images[imagesIndex];
            return Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).secondary100,
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 20.0,
                          icon: Icon(
                            Icons.cancel,
                            color: FlutterFlowTheme.of(context).info,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            await action_blocks.deleteStorage(
                              context,
                              bucket: 'business',
                              path:
                                  '${FFAppState().account.businessId.toString()}/$imagesItem',
                            );
                            safeSetState(() {});
                            _model.updBusinessData =
                                await action_blocks.loadBusinessData(
                              context,
                              businessId: FFAppState().account.businessId,
                            );
                            FFAppState().businessData = _model.updBusinessData!;
                            FFAppState().update(() {});

                            safeSetState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      functions.urlStorageFile(
                          FFAppState().account.isBusiness
                              ? 'business'
                              : 'client',
                          '${FFAppState().account.isBusiness ? FFAppState().account.businessId.toString() : FFAppState().account.clientId.toString()}/$imagesItem'),
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
