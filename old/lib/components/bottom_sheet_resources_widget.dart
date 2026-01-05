import '/backend/schema/structs/index.dart';
import '/components/text_field_comp2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_sheet_resources_model.dart';
export 'bottom_sheet_resources_model.dart';

class BottomSheetResourcesWidget extends StatefulWidget {
  const BottomSheetResourcesWidget({
    super.key,
    required this.create,
    this.resource,
  });

  final bool? create;
  final ResourceDataStruct? resource;

  @override
  State<BottomSheetResourcesWidget> createState() =>
      _BottomSheetResourcesWidgetState();
}

class _BottomSheetResourcesWidgetState
    extends State<BottomSheetResourcesWidget> {
  late BottomSheetResourcesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomSheetResourcesModel());

    _model.switchValue = true;
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

    return Align(
      alignment: const AlignmentDirectional(0.0, 1.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(49.0),
          topRight: Radius.circular(49.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).bg1Sec,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(49.0),
              topRight: Radius.circular(49.0),
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 85.0,
                          decoration: const BoxDecoration(),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (widget.create ?? true)
                              Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/3dicons-tools-dynamic-clay.png',
                                        width: 150.0,
                                        height: 150.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Añade un nuevo recurso',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    wrapWithModel(
                                      model: _model.nameFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldComp2Widget(
                                        title: 'Name',
                                        initialValue: widget.resource!.name,
                                        minLines: 1,
                                        hint: 'Ex: Gabriel',
                                        onChangeCallback: () async {},
                                        onFocusChangeCallback: () async {},
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Staff',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  6.0, 5.0, 0.0, 0.0),
                                          child: Switch.adaptive(
                                            value: _model.switchValue!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue = newValue);
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .white,
                                            activeTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary200,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            inactiveThumbColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (widget.create ?? true)
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await action_blocks.createResource(
                                            context,
                                            resourceName: _model.nameFieldModel
                                                .textFieldTextController.text,
                                            serviceTime: FFAppState()
                                                .businessData
                                                .openingHours,
                                            resourceType: _model.switchValue!
                                                ? 'staff'
                                                : 'resource',
                                          );
                                          await action_blocks
                                              .loadResources(context);
                                          Navigator.pop(context);
                                        },
                                        text: 'Añadir recurso',
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 45.0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 8.0, 15.0, 8.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .neutral100,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .bg1Sec,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(1000.0),
                                          hoverColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryAlpha10,
                                          hoverElevation: 1.0,
                                        ),
                                      ),
                                    if (!widget.create!)
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await action_blocks.updateResource(
                                            context,
                                            resourceId:
                                                widget.resource?.resourceId,
                                            name: _model.nameFieldModel
                                                .textFieldTextController.text,
                                            active: true,
                                          );
                                          await action_blocks
                                              .loadResources(context);
                                          Navigator.pop(context);
                                        },
                                        text: 'Editar recurso',
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 45.0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 8.0, 15.0, 8.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .neutral100,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .bg1Sec,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(1000.0),
                                          hoverColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryAlpha10,
                                          hoverElevation: 1.0,
                                        ),
                                      ),
                                    if (!widget.create!)
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await action_blocks.deleteResource(
                                            context,
                                            resourceId:
                                                widget.resource?.resourceId,
                                          );
                                          await action_blocks
                                              .loadResources(context);
                                          Navigator.pop(context);
                                        },
                                        text: 'Borrar recurso',
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 45.0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 8.0, 15.0, 8.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .neutral100,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .bg1Sec,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(1000.0),
                                          hoverColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryAlpha10,
                                          hoverElevation: 1.0,
                                        ),
                                      ),
                                  ].divide(const SizedBox(height: 15.0)),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(height: 10.0)),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40.0,
                          decoration: const BoxDecoration(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 139.0,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SvgPicture.asset(
                            'assets/images/SeparatorBottomSheet.svg',
                            fit: BoxFit.none,
                            alignment: const Alignment(0.0, -1.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .neutralAlpha10,
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryAlpha10,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Icon(
                                    FFIcons.kcloseLine,
                                    color:
                                        FlutterFlowTheme.of(context).neutral100,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ].divide(const SizedBox(height: 30.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
