import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mouse_leads_model.dart';
export 'mouse_leads_model.dart';

class MouseLeadsWidget extends StatefulWidget {
  const MouseLeadsWidget({
    super.key,
    required this.businessLead,
  });

  final BusinessLeadsStruct? businessLead;

  @override
  State<MouseLeadsWidget> createState() => _MouseLeadsWidgetState();
}

class _MouseLeadsWidgetState extends State<MouseLeadsWidget> {
  late MouseLeadsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MouseLeadsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
      }),
      child: Container(
        decoration: BoxDecoration(
          color: _model.mouseRegionHovered
              ? const Color(0x4C4F87C9)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9999.0),
                          child: Image.network(
                            'https://picsum.photos/seed/359/600',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                valueOrDefault<String>(
                                  (String first, String last) {
                                    return "$first $last";
                                  }(widget.businessLead!.clientFirstName,
                                      widget.businessLead!.clientLastName),
                                  'First Last',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0xFF222831)
                                          : const Color(0xFFEEEEEE),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                'Financial',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: const Color(0xFF9B9B9B),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(const SizedBox(height: 3.0)),
                          ),
                        ),
                      ].divide(const SizedBox(width: 5.0)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '\$ 500000,50',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF83B4FF)
                                  : const Color(0xFF83B4FF),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Expanded(
                  flex: () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 1;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 1;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 1;
                    } else {
                      return 2;
                    }
                  }(),
                  child: Text(
                    valueOrDefault<String>(
                      widget.businessLead?.requestDescription,
                      'Description of request',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF222831)
                                  : Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                ))
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Dec 24, 10:36 AM',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xFF222831)
                                    : Colors.white,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
              ].divide(const SizedBox(width: 5.0)),
            ),
          ].divide(const SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
