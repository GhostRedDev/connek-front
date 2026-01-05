import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_cancelled_small/request_cancelled_small_widget.dart';
import '/mile_stone3/components3/request_completed_small/request_completed_small_widget.dart';
import '/mile_stone3/components3/request_on_hold_small/request_on_hold_small_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mouse_leads_search2_model.dart';
export 'mouse_leads_search2_model.dart';

class MouseLeadsSearch2Widget extends StatefulWidget {
  const MouseLeadsSearch2Widget({
    super.key,
    required this.lead,
  });

  final BusinessLeadsStruct? lead;

  @override
  State<MouseLeadsSearch2Widget> createState() =>
      _MouseLeadsSearch2WidgetState();
}

class _MouseLeadsSearch2WidgetState extends State<MouseLeadsSearch2Widget> {
  late MouseLeadsSearch2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MouseLeadsSearch2Model());

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
      height: 260.0,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF31363F)
            : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: (Theme.of(context).brightness == Brightness.dark) == true
              ? const Color(0x194F87C9)
              : const Color(0x1A83B4FF),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (false)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NEW',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).customColor46,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  if (responsiveVisibility(
                    context: context,
                    tablet: false,
                    tabletLandscape: false,
                    desktop: false,
                  ))
                    Align(
                      alignment: const AlignmentDirectional(1.0, -1.0),
                      child: Icon(
                        FFIcons.kbell,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ),
                ],
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            valueOrDefault<String>(
                              functions.urlStorageFile('client',
                                  '${widget.lead?.clientId.toString()}/${widget.lead?.clientImageUrl}'),
                              'https://picsum.photos/seed/507/600',
                            ),
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              (String firstName, String lastName) {
                                return "$firstName $lastName";
                              }(widget.lead!.clientFirstName,
                                  widget.lead!.clientLastName),
                              'Daniel Mendoza',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Builder(
                            builder: (context) {
                              if (widget.lead?.status == 'cancelled') {
                                return wrapWithModel(
                                  model: _model.requestCancelledSmallModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const RequestCancelledSmallWidget(),
                                );
                              } else if (widget.lead?.status == 'completed') {
                                return wrapWithModel(
                                  model: _model.requestCompletedSmallModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const RequestCompletedSmallWidget(),
                                );
                              } else {
                                return wrapWithModel(
                                  model: _model.requestOnHoldSmallModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const RequestOnHoldSmallWidget(),
                                );
                              }
                            },
                          ),
                        ].divide(const SizedBox(height: 5.0)),
                      ),
                    ]
                        .divide(const SizedBox(width: 10.0))
                        .addToStart(const SizedBox(width: 10.0))
                        .addToEnd(const SizedBox(width: 10.0)),
                  ),
                  if (false)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: const Color(0x194F87C9),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: Text(
                                  'WEB DESIGN',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: const Color(0xFF4F87C9),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '13/02/2025',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: const Color(0xFF8D99AE),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ].divide(const SizedBox(height: 5.0)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 60.0,
                ),
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.lead?.requestDescription,
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at enim in ligula dictum pharetra sollicitudin sed mi. Pellentesque quis vulputate mi, condimentum condimentum enim.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at enim in ligula dictum pharetra sollicitudin sed mi. Pellentesque quis vulputate mi, condimentum condimentum enim.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at enim in ligula dictum pharetra sollicitudin sed mi. Pellentesque quis vulputate mi, condimentum condimentum enim.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at enim in ligula dictum pharetra sollicitudin sed mi. Pellentesque quis vulputate mi, condimentum condimentum enim.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at enim in ligula dictum pharetra sollicitudin sed mi. Pellentesque quis vulputate mi, condimentum condimentum enim.',
                    ),
                    maxLines: 3,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1.0, 1.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 10.0),
                child: Container(
                  width: 100.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: const Color(0x194F87C9),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FFIcons.kdollarCircle,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              const TextSpan(
                                text: '+\$',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: valueOrDefault<String>(
                                  widget.lead?.requestBudgetMin.toString(),
                                  '100',
                                ),
                                style: const TextStyle(),
                              ),
                              const TextSpan(
                                text: '',
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).success,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 6.0)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(
                    BusinessDashboardLeadDetailWidget.routeName,
                    pathParameters: {
                      'leadId': serializeParam(
                        widget.lead?.id,
                        ParamType.int,
                      ),
                    }.withoutNulls,
                    queryParameters: {
                      'leadDetail': serializeParam(
                        widget.lead,
                        ParamType.DataStruct,
                      ),
                    }.withoutNulls,
                  );
                },
                child: Container(
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: const Color(0x194F87C9),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                      child: Text(
                        'See lead details',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: const Color(0xFF4F87C9),
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ].divide(const SizedBox(height: 10.0)).addToEnd(const SizedBox(height: 15.0)),
        ),
      ),
    );
  }
}
