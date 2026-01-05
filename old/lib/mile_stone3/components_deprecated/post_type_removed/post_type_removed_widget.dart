import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'post_type_removed_model.dart';
export 'post_type_removed_model.dart';

class PostTypeRemovedWidget extends StatefulWidget {
  const PostTypeRemovedWidget({super.key});

  @override
  State<PostTypeRemovedWidget> createState() => _PostTypeRemovedWidgetState();
}

class _PostTypeRemovedWidgetState extends State<PostTypeRemovedWidget> {
  late PostTypeRemovedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostTypeRemovedModel());

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
      width: 149.0,
      height: 23.0,
      decoration: BoxDecoration(
        color: const Color(0xB3FF4A4A),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.info,
            color: Color(0xFFFFD8D8),
            size: 17.0,
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Text(
              'Removed by Connek',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: const Color(0xFFFFD8D8),
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
