import '/backend/schema/enums/enums.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/search_bar_widget.dart';
import '/components/search_result_business_card_widget.dart';
import '/components/search_result_service_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/milestone1/empty_search/empty_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_results_model.dart';
export 'search_results_model.dart';

class SearchResultsWidget extends StatefulWidget {
  const SearchResultsWidget({
    super.key,
    required this.prompt,
  });

  final String? prompt;

  @override
  State<SearchResultsWidget> createState() => _SearchResultsWidgetState();
}

class _SearchResultsWidgetState extends State<SearchResultsWidget> {
  late SearchResultsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchResultsModel());

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
            children: [
              wrapWithModel(
                model: _model.emptySpaceTopModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceTopWidget(
                  heightPx: 80,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Encuentra el servicio que necesitas',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontStyle,
                        ),
                  ),
                  Text(
                    'Explora miles de empresas y servicios verificados en nuestra plataforma',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondary300,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ],
              ),
              wrapWithModel(
                model: _model.searchBarModel,
                updateCallback: () => safeSetState(() {}),
                child: const SearchBarWidget(),
              ),
              Text(
                valueOrDefault<String>(
                  '${FFAppState().normalSearchResults.businesses.length.toString()} results found for: ${widget.prompt}',
                  '65 resultados para: Servicios de diseño web',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).neutral100,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Builder(
                  builder: (context) {
                    if (_model.filter == SearchResultTypes.business) {
                      return Builder(
                        builder: (context) {
                          final resultsBusiness = FFAppState()
                              .normalSearchResults
                              .businesses
                              .toList();
                          if (resultsBusiness.isEmpty) {
                            return const Center(
                              child: EmptySearchWidget(),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: resultsBusiness.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 5.0),
                            itemBuilder: (context, resultsBusinessIndex) {
                              final resultsBusinessItem =
                                  resultsBusiness[resultsBusinessIndex];
                              return wrapWithModel(
                                model: _model.searchResultBusinessCardModels
                                    .getModel(
                                  resultsBusinessIndex.toString(),
                                  resultsBusinessIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: SearchResultBusinessCardWidget(
                                  key: Key(
                                    'Keysv3_${resultsBusinessIndex.toString()}',
                                  ),
                                  business: FFAppState()
                                      .normalSearchResults
                                      .businesses
                                      .elementAtOrNull(resultsBusinessIndex)!,
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Builder(
                        builder: (context) {
                          final resultsServices = FFAppState()
                              .normalSearchResults
                              .services
                              .toList();
                          if (resultsServices.isEmpty) {
                            return const Center(
                              child: EmptySearchWidget(),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: resultsServices.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 5.0),
                            itemBuilder: (context, resultsServicesIndex) {
                              final resultsServicesItem =
                                  resultsServices[resultsServicesIndex];
                              return wrapWithModel(
                                model: _model.searchResultServiceCardModels
                                    .getModel(
                                  resultsServicesIndex.toString(),
                                  resultsServicesIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: SearchResultServiceCardWidget(
                                  key: Key(
                                    'Keyyw7_${resultsServicesIndex.toString()}',
                                  ),
                                  service: FFAppState()
                                      .normalSearchResults
                                      .services
                                      .elementAtOrNull(resultsServicesIndex)!,
                                  business: FFAppState()
                                      .normalSearchResults
                                      .businesses
                                      .where((e) =>
                                          resultsServicesItem.businessId ==
                                          e.id)
                                      .toList()
                                      .firstOrNull!,
                                  enableLinkToBusinessPage: true,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
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
