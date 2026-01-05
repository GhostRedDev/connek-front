import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'post_type_private_model.dart';
export 'post_type_private_model.dart';

class PostTypePrivateWidget extends StatefulWidget {
  const PostTypePrivateWidget({super.key});

  @override
  State<PostTypePrivateWidget> createState() => _PostTypePrivateWidgetState();
}

class _PostTypePrivateWidgetState extends State<PostTypePrivateWidget> {
  late PostTypePrivateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostTypePrivateModel());

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
      width: 71.0,
      height: 23.0,
      decoration: BoxDecoration(
        color: const Color(0x7D212121),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.eyeSlash,
            color: Colors.white,
            size: 17.0,
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Text(
              'Private',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Colors.white,
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
