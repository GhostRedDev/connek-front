import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'images_horizontal_viewer_model.dart';
export 'images_horizontal_viewer_model.dart';

class ImagesHorizontalViewerWidget extends StatefulWidget {
  const ImagesHorizontalViewerWidget({
    super.key,
    required this.images,
    String? title,
    required this.callbackRemoveImageFromList,
    int? serviceId,
    required this.imagesStorage,
    required this.callbackRemoveExistingImage,
  })  : title = title ?? 'title',
        serviceId = serviceId ?? 0;

  final List<FFUploadedFile>? images;
  final String title;
  final Future Function(FFUploadedFile fileToRemove)?
      callbackRemoveImageFromList;
  final int serviceId;
  final List<String>? imagesStorage;
  final Future Function(String existingImageToRemove)?
      callbackRemoveExistingImage;

  @override
  State<ImagesHorizontalViewerWidget> createState() =>
      _ImagesHorizontalViewerWidgetState();
}

class _ImagesHorizontalViewerWidgetState
    extends State<ImagesHorizontalViewerWidget> {
  late ImagesHorizontalViewerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImagesHorizontalViewerModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: const Color(0xFFF2F2F2),
                  width: 3.0,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (true)
                      Builder(
                        builder: (context) {
                          final images = widget.images!.toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, imagesIndex) {
                              final imagesItem = images[imagesIndex];
                              return Stack(
                                alignment: const AlignmentDirectional(1.0, -1.0),
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      imagesItem.bytes ??
                                          Uint8List.fromList([]),
                                      width: 120.0,
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderRadius: 9999.0,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: FlutterFlowTheme.of(context)
                                          .neutralAlpha50,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      await widget.callbackRemoveImageFromList
                                          ?.call(
                                        imagesItem,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    Builder(
                      builder: (context) {
                        final images = widget.imagesStorage!.toList();

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, imagesIndex) {
                            final imagesItem = images[imagesIndex];
                            return Stack(
                              alignment: const AlignmentDirectional(1.0, -1.0),
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    functions.urlStorageFile('business',
                                        '${FFAppState().account.businessId.toString()}/services/${widget.serviceId.toString()}/$imagesItem'),
                                    width: 120.0,
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 9999.0,
                                  icon: Icon(
                                    Icons.cancel,
                                    color: FlutterFlowTheme.of(context)
                                        .neutralAlpha50,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    await widget.callbackRemoveExistingImage
                                        ?.call(
                                      imagesItem,
                                    );
                                    safeSetState(() {});
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
