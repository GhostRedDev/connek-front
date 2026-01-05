import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'post_type_published_model.dart';
export 'post_type_published_model.dart';

class PostTypePublishedWidget extends StatefulWidget {
  const PostTypePublishedWidget({super.key});

  @override
  State<PostTypePublishedWidget> createState() =>
      _PostTypePublishedWidgetState();
}

class _PostTypePublishedWidgetState extends State<PostTypePublishedWidget> {
  late PostTypePublishedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostTypePublishedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.0,
      height: 23.0,
      decoration: BoxDecoration(
        color: const Color(0x344EFF7F),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.remove_red_eye_sharp,
            color: Color(0xFF74FF9A),
            size: 17.0,
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Text(
              'Published',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: const Color(0xFF74FF9A),
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ),
        ].divide(const SizedBox(width: 2.0)),
      ),
    );
  }
}
