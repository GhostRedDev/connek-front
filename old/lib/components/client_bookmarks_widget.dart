import '/backend/schema/structs/index.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/favorite_profile_widget.dart';
import '/components/favorite_service_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'client_bookmarks_model.dart';
export 'client_bookmarks_model.dart';

class ClientBookmarksWidget extends StatefulWidget {
  const ClientBookmarksWidget({super.key});

  @override
  State<ClientBookmarksWidget> createState() => _ClientBookmarksWidgetState();
}

class _ClientBookmarksWidgetState extends State<ClientBookmarksWidget> {
  late ClientBookmarksModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientBookmarksModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.requestList = FFAppState()
          .clientRequests
          .sortedList(keyOf: (e) => e.createdAt!, desc: true)
          .toList()
          .cast<ClientRequestStruct>();
      safeSetState(() {});
    });

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

    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.emptySpaceTopModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceTopWidget(),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: wrapWithModel(
                  model: _model.contentHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const ContentHeaderWidget(
                    title: 'Bookmarks',
                    subtitle: 'See your favourite business and services',
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: Text(
                          'Empresas',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondary200,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 1.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              wrapWithModel(
                                model: _model.favoriteProfileModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const FavoriteProfileWidget(),
                              ),
                            ].divide(const SizedBox(width: 10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: Text(
                          'Servicios',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondary200,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.favoriteServiceModel,
                          updateCallback: () => safeSetState(() {}),
                          child: const FavoriteServiceWidget(),
                        ),
                      ].divide(const SizedBox(height: 15.0)),
                    ),
                  ),
                ],
              ),
              wrapWithModel(
                model: _model.emptySpaceModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceWidget(),
              ),
            ].divide(const SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
