import '/backend/schema/structs/index.dart';
import '/components/resources_sheet_form_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import '/m4_new/business_dashboard_service_box/business_dashboard_service_box_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_services_o_l_d_model.dart';
export 'business_services_o_l_d_model.dart';

class BusinessServicesOLDWidget extends StatefulWidget {
  const BusinessServicesOLDWidget({super.key});

  @override
  State<BusinessServicesOLDWidget> createState() =>
      _BusinessServicesOLDWidgetState();
}

class _BusinessServicesOLDWidgetState extends State<BusinessServicesOLDWidget> {
  late BusinessServicesOLDModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessServicesOLDModel());

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
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: wrapWithModel(
                        model: _model.contentHeaderModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: const ContentHeaderWidget(
                          title: 'Resources',
                          subtitle: 'Create or edit your resources',
                        ),
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: const ResourcesSheetFormWidget(
                                create: true,
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Builder(
                  builder: (context) {
                    final resourcesList =
                        FFAppState().businessResources.toList();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(resourcesList.length,
                            (resourcesListIndex) {
                          final resourcesListItem =
                              resourcesList[resourcesListIndex];
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: ResourcesSheetFormWidget(
                                          create: false,
                                          resource: resourcesListItem,
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/AR_LOGO_NEW_JANUARY_(1).png',
                                      ).image,
                                    ),
                                    borderRadius: BorderRadius.circular(999.0),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    resourcesListItem.name,
                                    'Lauren',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          );
                        }).divide(const SizedBox(width: 12.0)),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: wrapWithModel(
                        model: _model.contentHeaderModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: const ContentHeaderWidget(
                          title: 'Services',
                          subtitle: 'Create or edit your services',
                        ),
                      ),
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.pushNamed(
                          BusinessDashboardAddServicesWidget.routeName,
                          queryParameters: {
                            'create': serializeParam(
                              true,
                              ParamType.bool,
                            ),
                            'serviceId': serializeParam(
                              0,
                              ParamType.int,
                            ),
                            'service': serializeParam(
                              ServiceDataStruct(
                                id: 0,
                                name: '',
                                description: '',
                                priceLowCents: 10000,
                                priceHighCents: 20000,
                                images: '[]',
                                businessId: FFAppState().account.businessId,
                                businessName: FFAppState().businessData.name,
                                serviceCategory: '',
                                profileImage: '',
                                priceCents: 10000,
                                durationMinutes: 30,
                                createdAt: DateTime.fromMicrosecondsSinceEpoch(
                                    1757649600000000),
                              ),
                              ParamType.DataStruct,
                            ),
                          }.withoutNulls,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  final servicesList = FFAppState().servicesData.toList();

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                        List.generate(servicesList.length, (servicesListIndex) {
                      final servicesListItem = servicesList[servicesListIndex];
                      return wrapWithModel(
                        model:
                            _model.businessDashboardServiceBoxModels.getModel(
                          servicesListItem.id.toString(),
                          servicesListIndex,
                        ),
                        updateCallback: () => safeSetState(() {}),
                        child: BusinessDashboardServiceBoxWidget(
                          key: Key(
                            'Keyszq_${servicesListItem.id.toString()}',
                          ),
                          service: servicesListItem,
                        ),
                      );
                    }).divide(const SizedBox(height: 10.0)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
