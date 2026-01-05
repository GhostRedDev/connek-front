import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'business_page_banner_model.dart';
export 'business_page_banner_model.dart';

class BusinessPageBannerWidget extends StatefulWidget {
  const BusinessPageBannerWidget({
    super.key,
    required this.filename,
    required this.businessData,
  });

  final String? filename;
  final BusinessDataStruct? businessData;

  @override
  State<BusinessPageBannerWidget> createState() =>
      _BusinessPageBannerWidgetState();
}

class _BusinessPageBannerWidgetState extends State<BusinessPageBannerWidget> {
  late BusinessPageBannerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessPageBannerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Builder(
          builder: (context) {
            if (functions.filenameImageOrVideo(widget.filename!) == 'video') {
              return FlutterFlowVideoPlayer(
                path: valueOrDefault<String>(
                  functions.urlStorageFileVideo('business',
                      '${widget.businessData?.id.toString()}/${widget.filename}'),
                  'https://assets.mixkit.co/videos/1467/1467-720.mp4',
                ),
                videoType: VideoType.network,
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 1.0,
                autoPlay: true,
                looping: true,
                showControls: false,
                allowFullScreen: false,
                allowPlaybackSpeedMenu: false,
                lazyLoad: false,
                pauseOnNavigate: false,
              );
            } else {
              return ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.network(
                  valueOrDefault<String>(
                    functions.urlStorageFile('business',
                        '${widget.businessData?.id.toString()}/${widget.filename}'),
                    'https://picsum.photos/seed/57/600',
                  ),
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
