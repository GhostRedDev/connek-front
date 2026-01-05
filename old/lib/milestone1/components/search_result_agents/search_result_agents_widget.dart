import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_result_agents_model.dart';
export 'search_result_agents_model.dart';

class SearchResultAgentsWidget extends StatefulWidget {
  const SearchResultAgentsWidget({
    super.key,
    required this.agentId,
    required this.agentName,
  });

  final int? agentId;
  final String? agentName;

  @override
  State<SearchResultAgentsWidget> createState() =>
      _SearchResultAgentsWidgetState();
}

class _SearchResultAgentsWidgetState extends State<SearchResultAgentsWidget> {
  late SearchResultAgentsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchResultAgentsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ))
          Container(
            height: 49.0,
            decoration: BoxDecoration(
              color: const Color(0xFFD7E7FF),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.network(
                      'https://picsum.photos/seed/135/600',
                      width: 33.0,
                      height: 33.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      () {
                        if (widget.agentId == 1) {
                          return 'Chat with Greg';
                        } else if (widget.agentId == 2) {
                          return 'Booking';
                        } else if (widget.agentId == 3) {
                          return 'Request a quote';
                        } else {
                          return '';
                        }
                      }(),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: const Color(0xFF222831),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (responsiveVisibility(
          context: context,
          phone: false,
          tablet: false,
        ))
          Container(
            height: 49.0,
            decoration: BoxDecoration(
              color: const Color(0xFFD7E7FF),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.network(
                      'https://picsum.photos/seed/135/600',
                      width: 33.0,
                      height: 33.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Text(
                      () {
                        if (widget.agentId == 1) {
                          return 'Chat with Greg';
                        } else if (widget.agentId == 2) {
                          return 'Booking';
                        } else if (widget.agentId == 3) {
                          return 'Request a quote';
                        } else {
                          return '';
                        }
                      }(),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: const Color(0xFF222831),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
