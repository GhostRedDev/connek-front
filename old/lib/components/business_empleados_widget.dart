import '/backend/schema/structs/index.dart';
import '/components/bottom_sheet_resources_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/components/my_bots_greg_widget.dart';
import '/components/recurso_card_widget.dart';
import '/components/staff_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_empleados_model.dart';
export 'business_empleados_model.dart';

class BusinessEmpleadosWidget extends StatefulWidget {
  const BusinessEmpleadosWidget({super.key});

  @override
  State<BusinessEmpleadosWidget> createState() =>
      _BusinessEmpleadosWidgetState();
}

class _BusinessEmpleadosWidgetState extends State<BusinessEmpleadosWidget> {
  late BusinessEmpleadosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessEmpleadosModel());

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
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wrapWithModel(
                model: _model.emptySpaceTopModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceTopWidget(),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).bg2Sec,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondaryAlpha10,
                    width: 1.0,
                  ),
                ),
                child: Column(
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
                            'Empleados',
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (FFAppState().myBots.greg.businessId != 0)
                            wrapWithModel(
                              model: _model.myBotsGregModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const MyBotsGregWidget(),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).bg2Sec,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondaryAlpha10,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Staff',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondary200,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 34.0,
                                height: 28.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).bg1Sec,
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryAlpha10,
                                    width: 1.0,
                                  ),
                                ),
                                child: InkWell(
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
                                          child: BottomSheetResourcesWidget(
                                            create: false,
                                            resource: ResourceDataStruct(
                                              resourceId: 0,
                                              createdAt: DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      1766638800000000),
                                              businessId: 0,
                                              name: '',
                                              active: true,
                                              serviceTime: FFAppState()
                                                  .businessData
                                                  .openingHours,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Icon(
                                    FFIcons.kplusAdd,
                                    color:
                                        FlutterFlowTheme.of(context).neutral100,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final staffs = FFAppState()
                                  .businessResources
                                  .where((e) => e.resourceType == 'staff')
                                  .toList();

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(staffs.length,
                                      (staffsIndex) {
                                    final staffsItem = staffs[staffsIndex];
                                    return wrapWithModel(
                                      model: _model.staffCardModels.getModel(
                                        staffsIndex.toString(),
                                        staffsIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: StaffCardWidget(
                                        key: Key(
                                          'Keyqw8_${staffsIndex.toString()}',
                                        ),
                                        resource: staffsItem,
                                      ),
                                    );
                                  }).divide(const SizedBox(width: 10.0)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).bg2Sec,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondaryAlpha10,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Recursos',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondary200,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 34.0,
                                height: 28.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).bg1Sec,
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryAlpha10,
                                    width: 1.0,
                                  ),
                                ),
                                child: InkWell(
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
                                          child: BottomSheetResourcesWidget(
                                            create: false,
                                            resource: ResourceDataStruct(
                                              resourceId: 0,
                                              createdAt: DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      1766638800000000),
                                              businessId: 0,
                                              name: '',
                                              active: true,
                                              serviceTime: FFAppState()
                                                  .businessData
                                                  .openingHours,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Icon(
                                    FFIcons.kplusAdd,
                                    color:
                                        FlutterFlowTheme.of(context).neutral100,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 5.0)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                      child: Container(
                        height: 237.0,
                        decoration: const BoxDecoration(),
                        child: Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final resources = FFAppState()
                                  .businessResources
                                  .where((e) => e.resourceType != 'staff')
                                  .toList();

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(resources.length,
                                      (resourcesIndex) {
                                    final resourcesItem =
                                        resources[resourcesIndex];
                                    return wrapWithModel(
                                      model: _model.recursoCardModels.getModel(
                                        resourcesIndex.toString(),
                                        resourcesIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: RecursoCardWidget(
                                        key: Key(
                                          'Keyhyg_${resourcesIndex.toString()}',
                                        ),
                                        resource: resourcesItem,
                                      ),
                                    );
                                  }).divide(const SizedBox(width: 10.0)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.emptySpaceModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceWidget(),
              ),
            ].divide(const SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
