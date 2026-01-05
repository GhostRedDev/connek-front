import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'social_card_model.dart';
export 'social_card_model.dart';

class SocialCardWidget extends StatefulWidget {
  const SocialCardWidget({
    super.key,
    required this.socialName,
    this.isSet,
    this.link,
  });

  final String? socialName;
  final bool? isSet;
  final String? link;

  @override
  State<SocialCardWidget> createState() => _SocialCardWidgetState();
}

class _SocialCardWidgetState extends State<SocialCardWidget> {
  late SocialCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SocialCardModel());

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
      width: 180.0,
      height: 140.0,
      decoration: BoxDecoration(
        color: () {
          if (widget.socialName == 'Instagram') {
            return const Color(0x1A833AB4);
          } else if (widget.socialName == 'Whatsapp') {
            return const Color(0x1A25D366);
          } else if (widget.socialName == 'Facebook') {
            return const Color(0x1A1877F2);
          } else {
            return const Color(0x00000000);
          }
        }(),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 15.0, 5.0, 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(
                  builder: (context) {
                    if (widget.socialName == 'Instagram') {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        child: Image.asset(
                          'assets/images/logoInsta.png',
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else if (widget.socialName == 'Whatsapp') {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        child: Image.asset(
                          'assets/images/logoWsp.png',
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else if (widget.socialName == 'Facebook') {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        child: Image.asset(
                          'assets/images/logofb.png',
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        child: Image.asset(
                          'assets/images/logofb.png',
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  },
                ),
                if (widget.isSet == true)
                  Text(
                    valueOrDefault<String>(
                      widget.link,
                      '--',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 11.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                Text(
                  () {
                    if (widget.socialName == 'Instagram') {
                      return 'Instagram';
                    } else if (widget.socialName == 'Whatsapp') {
                      return 'Whatsapp';
                    } else {
                      return 'Facebook';
                    }
                  }(),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        color: () {
                          if (widget.socialName == 'Instagram') {
                            return const Color(0xFF833AB4);
                          } else if (widget.socialName == 'Whatsapp') {
                            return const Color(0xFF25D366);
                          } else if (widget.socialName == 'Facebook') {
                            return const Color(0xFF1877F2);
                          } else {
                            return const Color(0x00000000);
                          }
                        }(),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
              ].divide(const SizedBox(height: 5.0)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: 100.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryAlpha30,
                    ),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Connect',
                      options: FFButtonOptions(
                        height: 23.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0x1983B4FF)
                            : const Color(0x1983B4FF),
                        textStyle:
                            FlutterFlowTheme.of(context).labelSmall.override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color(0xFF1D415C)
                                      : const Color(0xFF83B4FF),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ].divide(const SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
