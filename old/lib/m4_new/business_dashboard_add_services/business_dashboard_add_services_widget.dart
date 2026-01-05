import '/backend/schema/structs/index.dart';
import '/components/back_button_widget.dart';
import '/components/images_horizontal_viewer_widget.dart';
import '/components/text_field_comp_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_dashboard_add_services_model.dart';
export 'business_dashboard_add_services_model.dart';

class BusinessDashboardAddServicesWidget extends StatefulWidget {
  const BusinessDashboardAddServicesWidget({
    super.key,
    this.service,
    this.serviceId,
    bool? create,
  }) : create = create ?? true;

  final ServiceDataStruct? service;
  final int? serviceId;
  final bool create;

  static String routeName = 'BusinessDashboardAddServices';
  static String routePath = 'businessDashboardAddServices';

  @override
  State<BusinessDashboardAddServicesWidget> createState() =>
      _BusinessDashboardAddServicesWidgetState();
}

class _BusinessDashboardAddServicesWidgetState
    extends State<BusinessDashboardAddServicesWidget> {
  late BusinessDashboardAddServicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardAddServicesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.imagesInStorage = functions
          .stringToList(widget.service!.images)
          .toList()
          .cast<String>();
      safeSetState(() {});
    });

    _model.priceLowFieldTextController ??= TextEditingController(
        text: functions
            .centsStringToDollars(widget.service!.priceLowCents.toString())
            .toString());
    _model.priceLowFieldFocusNode ??= FocusNode();

    _model.priceHighFieldTextController ??= TextEditingController(
        text: functions
            .centsStringToDollars(widget.service!.priceHighCents.toString())
            .toString());
    _model.priceHighFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              desktop: false,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    desktop: false,
                  ))
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 80.0,
                      decoration: const BoxDecoration(),
                      child: wrapWithModel(
                        model: _model.mobileAppBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const MobileAppBarWidget(
                          bgTrans: true,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      width: 100.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              wrapWithModel(
                                model: _model.backButtonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const BackButtonWidget(),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget.create
                                      ? 'Add service'
                                      : 'Edit service',
                                  'Add/Edit Service',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                              Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Profile Image',
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
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (_model.profileImageUploaded !=
                                                      null &&
                                                  (_model.profileImageUploaded
                                                          ?.bytes?.isNotEmpty ??
                                                      false))
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    final selectedMedia =
                                                        await selectMedia(
                                                      mediaSource: MediaSource
                                                          .photoGallery,
                                                      multiImage: false,
                                                    );
                                                    if (selectedMedia != null &&
                                                        selectedMedia.every((m) =>
                                                            validateFileFormat(
                                                                m.storagePath,
                                                                context))) {
                                                      safeSetState(() => _model
                                                              .isDataUploading_uploadDataProfileImagex =
                                                          true);
                                                      var selectedUploadedFiles =
                                                          <FFUploadedFile>[];

                                                      try {
                                                        selectedUploadedFiles =
                                                            selectedMedia
                                                                .map((m) =>
                                                                    FFUploadedFile(
                                                                      name: m
                                                                          .storagePath
                                                                          .split(
                                                                              '/')
                                                                          .last,
                                                                      bytes: m
                                                                          .bytes,
                                                                      height: m
                                                                          .dimensions
                                                                          ?.height,
                                                                      width: m
                                                                          .dimensions
                                                                          ?.width,
                                                                      blurHash:
                                                                          m.blurHash,
                                                                      originalFilename:
                                                                          m.originalFilename,
                                                                    ))
                                                                .toList();
                                                      } finally {
                                                        _model.isDataUploading_uploadDataProfileImagex =
                                                            false;
                                                      }
                                                      if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length) {
                                                        safeSetState(() {
                                                          _model.uploadedLocalFile_uploadDataProfileImagex =
                                                              selectedUploadedFiles
                                                                  .first;
                                                        });
                                                      } else {
                                                        safeSetState(() {});
                                                        return;
                                                      }
                                                    }

                                                    _model.profileImageUploaded =
                                                        _model
                                                            .uploadedLocalFile_uploadDataProfileImagex;
                                                    safeSetState(() {});
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.memory(
                                                      _model.profileImageUploaded
                                                              ?.bytes ??
                                                          Uint8List.fromList(
                                                              []),
                                                      width: 100.0,
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              if ((_model.profileImageUploaded ==
                                                          null ||
                                                      (_model.profileImageUploaded
                                                              ?.bytes?.isEmpty ??
                                                          true)) &&
                                                  (widget.service
                                                              ?.profileImage !=
                                                          null &&
                                                      widget.service
                                                              ?.profileImage !=
                                                          ''))
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    final selectedMedia =
                                                        await selectMedia(
                                                      mediaSource: MediaSource
                                                          .photoGallery,
                                                      multiImage: false,
                                                    );
                                                    if (selectedMedia != null &&
                                                        selectedMedia.every((m) =>
                                                            validateFileFormat(
                                                                m.storagePath,
                                                                context))) {
                                                      safeSetState(() => _model
                                                              .isDataUploading_uploadDataProfileImageReplacex =
                                                          true);
                                                      var selectedUploadedFiles =
                                                          <FFUploadedFile>[];

                                                      try {
                                                        selectedUploadedFiles =
                                                            selectedMedia
                                                                .map((m) =>
                                                                    FFUploadedFile(
                                                                      name: m
                                                                          .storagePath
                                                                          .split(
                                                                              '/')
                                                                          .last,
                                                                      bytes: m
                                                                          .bytes,
                                                                      height: m
                                                                          .dimensions
                                                                          ?.height,
                                                                      width: m
                                                                          .dimensions
                                                                          ?.width,
                                                                      blurHash:
                                                                          m.blurHash,
                                                                      originalFilename:
                                                                          m.originalFilename,
                                                                    ))
                                                                .toList();
                                                      } finally {
                                                        _model.isDataUploading_uploadDataProfileImageReplacex =
                                                            false;
                                                      }
                                                      if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length) {
                                                        safeSetState(() {
                                                          _model.uploadedLocalFile_uploadDataProfileImageReplacex =
                                                              selectedUploadedFiles
                                                                  .first;
                                                        });
                                                      } else {
                                                        safeSetState(() {});
                                                        return;
                                                      }
                                                    }

                                                    _model.profileImageUploaded =
                                                        _model
                                                            .uploadedLocalFile_uploadDataProfileImageReplacex;
                                                    safeSetState(() {});
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      functions
                                                          .loadServiceProfileImage(
                                                              FFAppState()
                                                                  .account
                                                                  .businessId,
                                                              widget.serviceId
                                                                  ?.toString(),
                                                              widget.service
                                                                  ?.profileImage),
                                                      width: 100.0,
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        'assets/images/error_image.png',
                                                        width: 100.0,
                                                        height: 100.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if ((_model.profileImageUploaded ==
                                                          null ||
                                                      (_model.profileImageUploaded
                                                              ?.bytes?.isEmpty ??
                                                          true)) &&
                                                  (widget.service
                                                              ?.profileImage ==
                                                          null ||
                                                      widget.service
                                                              ?.profileImage ==
                                                          ''))
                                                FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 100.0,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    final selectedMedia =
                                                        await selectMedia(
                                                      mediaSource: MediaSource
                                                          .photoGallery,
                                                      multiImage: false,
                                                    );
                                                    if (selectedMedia != null &&
                                                        selectedMedia.every((m) =>
                                                            validateFileFormat(
                                                                m.storagePath,
                                                                context))) {
                                                      safeSetState(() => _model
                                                              .isDataUploading_uploadDataOLDProfileImageNew =
                                                          true);
                                                      var selectedUploadedFiles =
                                                          <FFUploadedFile>[];

                                                      try {
                                                        selectedUploadedFiles =
                                                            selectedMedia
                                                                .map((m) =>
                                                                    FFUploadedFile(
                                                                      name: m
                                                                          .storagePath
                                                                          .split(
                                                                              '/')
                                                                          .last,
                                                                      bytes: m
                                                                          .bytes,
                                                                      height: m
                                                                          .dimensions
                                                                          ?.height,
                                                                      width: m
                                                                          .dimensions
                                                                          ?.width,
                                                                      blurHash:
                                                                          m.blurHash,
                                                                      originalFilename:
                                                                          m.originalFilename,
                                                                    ))
                                                                .toList();
                                                      } finally {
                                                        _model.isDataUploading_uploadDataOLDProfileImageNew =
                                                            false;
                                                      }
                                                      if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length) {
                                                        safeSetState(() {
                                                          _model.uploadedLocalFile_uploadDataOLDProfileImageNew =
                                                              selectedUploadedFiles
                                                                  .first;
                                                        });
                                                      } else {
                                                        safeSetState(() {});
                                                        return;
                                                      }
                                                    }

                                                    _model.profileImageUploaded =
                                                        _model
                                                            .uploadedLocalFile_uploadDataOLDProfileImageNew;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                            ],
                                          ),
                                        ].divide(const SizedBox(width: 15.0)),
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.nameFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Service Name',
                                        initialValue: widget.service?.name,
                                        minLines: 1,
                                        onChangeCallback: () async {},
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.descriptionCompModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Description',
                                        initialValue:
                                            widget.service?.description,
                                        minLines: 5,
                                        onChangeCallback: () async {},
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 5.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(),
                                        child: Text(
                                          'Max 1500 characters',
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .greenAlpha10,
                                                fontSize: 12.0,
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
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.priceCentsFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Price',
                                        initialValue: functions
                                            .centsStringToDollars(widget
                                                .service!.priceCents
                                                .toString())
                                            .toString(),
                                        minLines: 1,
                                        onChangeCallback: () async {},
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Price Low',
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
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
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Price High',
                                                style: FlutterFlowTheme.of(
                                                        context)
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
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
                                              ),
                                            ),
                                          ].divide(const SizedBox(width: 15.0)),
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .priceLowFieldTextController,
                                                  focusNode: _model
                                                      .priceLowFieldFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary300,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              const Color(0xFF808080),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 2.0,
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    filled: true,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .customColor45,
                                                    hoverColor:
                                                        Colors.transparent,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .priceLowFieldTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller: _model
                                                      .priceHighFieldTextController,
                                                  focusNode: _model
                                                      .priceHighFieldFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary300,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              const Color(0xFF808080),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 2.0,
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    filled: true,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .customColor45,
                                                    hoverColor:
                                                        Colors.transparent,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .priceHighFieldTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ].divide(const SizedBox(width: 15.0)),
                                        ),
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.durationFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Duration (minutes)',
                                        initialValue: widget
                                            .service?.durationMinutes
                                            .toString(),
                                        minLines: 1,
                                        onChangeCallback: () async {},
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.categoryFieldModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldCompWidget(
                                        title: 'Category',
                                        initialValue:
                                            widget.service?.serviceCategory,
                                        minLines: 1,
                                        onChangeCallback: () async {},
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Resources',
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
                                          ),
                                          Text(
                                            'Which resources can do this service?',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final resourcesList = FFAppState()
                                                  .businessResources
                                                  .toList();

                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      resourcesList.length,
                                                      (resourcesListIndex) {
                                                    final resourcesListItem =
                                                        resourcesList[
                                                            resourcesListIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (widget
                                                                      .service
                                                                      ?.resources
                                                                      .contains(
                                                                          resourcesListItem
                                                                              .resourceId) ==
                                                                  true) {
                                                                if (_model
                                                                        .removeResources
                                                                        .contains(
                                                                            resourcesListItem.resourceId) ==
                                                                    true) {
                                                                  _model.removeFromRemoveResources(
                                                                      resourcesListItem
                                                                          .resourceId);
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  _model.addToRemoveResources(
                                                                      resourcesListItem
                                                                          .resourceId);
                                                                  safeSetState(
                                                                      () {});
                                                                }
                                                              } else {
                                                                if (_model
                                                                        .addResources
                                                                        .contains(
                                                                            resourcesListItem.resourceId) ==
                                                                    true) {
                                                                  _model.removeFromAddResources(
                                                                      resourcesListItem
                                                                          .resourceId);
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  _model.addToAddResources(
                                                                      resourcesListItem
                                                                          .resourceId);
                                                                  safeSetState(
                                                                      () {});
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 60.0,
                                                              height: 60.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9999.0),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if (widget
                                                                              .service!
                                                                              .resources
                                                                              .contains(resourcesListItem
                                                                                  .resourceId) &&
                                                                          !_model.removeResources.contains(resourcesListItem
                                                                              .resourceId)) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .success;
                                                                      } else if (_model
                                                                          .addResources
                                                                          .contains(resourcesListItem
                                                                              .resourceId)) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .success;
                                                                      } else if (_model
                                                                          .removeResources
                                                                          .contains(
                                                                              resourcesListItem.resourceId)) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .neutralAlpha50;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .primary;
                                                                      }
                                                                    }(),
                                                                    const Color(
                                                                        0xFF00D73B),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              resourcesListItem
                                                                  .name,
                                                              'Name',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).divide(
                                                      const SizedBox(width: 10.0)),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: Visibility(
                                        visible: (_model.uploadedImages.isNotEmpty) ||
                                            (functions
                                                    .stringToList(
                                                        widget.service!.images).isNotEmpty),
                                        child: wrapWithModel(
                                          model: _model
                                              .imagesHorizontalViewerModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: ImagesHorizontalViewerWidget(
                                            title: 'Uploaded images',
                                            images: _model.uploadedImages,
                                            serviceId: widget.serviceId!,
                                            imagesStorage:
                                                _model.imagesInStorage,
                                            callbackRemoveImageFromList:
                                                (fileToRemove) async {
                                              _model.removeFromUploadedImages(
                                                  fileToRemove);
                                              safeSetState(() {});
                                            },
                                            callbackRemoveExistingImage:
                                                (existingImageToRemove) async {
                                              _model.addToImagesToRemove(
                                                  existingImageToRemove);
                                              _model.removeFromImagesInStorage(
                                                  existingImageToRemove);
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final selectedMedia = await selectMedia(
                                          imageQuality: 55,
                                          mediaSource: MediaSource.photoGallery,
                                          multiImage: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          safeSetState(() => _model
                                                  .isDataUploading_uploadedDataImagesx =
                                              true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                          originalFilename: m
                                                              .originalFilename,
                                                        ))
                                                    .toList();
                                          } finally {
                                            _model.isDataUploading_uploadedDataImagesx =
                                                false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFiles_uploadedDataImagesx =
                                                  selectedUploadedFiles;
                                            });
                                          } else {
                                            safeSetState(() {});
                                            return;
                                          }
                                        }

                                        for (int loop1Index = 0;
                                            loop1Index <
                                                _model
                                                    .uploadedLocalFiles_uploadedDataImagesx
                                                    .length;
                                            loop1Index++) {
                                          final currentLoop1Item = _model
                                                  .uploadedLocalFiles_uploadedDataImagesx[
                                              loop1Index];
                                          _model.addToUploadedImages(
                                              currentLoop1Item);
                                          safeSetState(() {});
                                        }
                                      },
                                      text: 'Upload images',
                                      icon: const Icon(
                                        Icons.image,
                                        size: 18.0,
                                      ),
                                      options: FFButtonOptions(
                                        width: 167.8,
                                        height: 36.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconAlignment: IconAlignment.start,
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? const Color(0xFF222831)
                                            : const Color(0xFF31363F),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            if (widget.create) {
                                              await action_blocks.createService(
                                                context,
                                                name: _model
                                                    .nameFieldModel
                                                    .textFieldTextController
                                                    .text,
                                                description: _model
                                                    .descriptionCompModel
                                                    .textFieldTextController
                                                    .text,
                                                priceHighCents: (double.parse(_model
                                                            .priceHighFieldTextController
                                                            .text) *
                                                        100)
                                                    .toInt(),
                                                priceLowCents: (double.parse(_model
                                                            .priceLowFieldTextController
                                                            .text) *
                                                        100)
                                                    .toInt(),
                                                category: _model
                                                    .categoryFieldModel
                                                    .textFieldTextController
                                                    .text,
                                                images: _model.uploadedImages,
                                                durationMinutes: int.tryParse(
                                                    _model
                                                        .durationFieldModel
                                                        .textFieldTextController
                                                        .text),
                                                priceCents: functions
                                                    .dollarsStringToCents(_model
                                                        .priceCentsFieldModel
                                                        .textFieldTextController
                                                        .text),
                                                profileImage:
                                                    _model.profileImageUploaded,
                                                resourcesList: functions
                                                    .combineResourcesEditServicePage(
                                                        _model.addResources
                                                            .toList(),
                                                        _model.removeResources
                                                            .toList(),
                                                        widget
                                                            .service!.resources
                                                            .toList()),
                                              );
                                            } else {
                                              await action_blocks.updateService(
                                                context,
                                                serviceId: widget.serviceId,
                                                name: _model
                                                    .nameFieldModel
                                                    .textFieldTextController
                                                    .text,
                                                priceLowCents: functions
                                                    .dollarsStringToCents(_model
                                                        .priceLowFieldTextController
                                                        .text),
                                                priceHighCents: functions
                                                    .dollarsStringToCents(_model
                                                        .priceHighFieldTextController
                                                        .text),
                                                priceCents: functions
                                                    .dollarsStringToCents(_model
                                                        .priceCentsFieldModel
                                                        .textFieldTextController
                                                        .text),
                                                durationMinutes: int.tryParse(
                                                    _model
                                                        .durationFieldModel
                                                        .textFieldTextController
                                                        .text),
                                                description: _model
                                                    .descriptionCompModel
                                                    .textFieldTextController
                                                    .text,
                                                images: _model.uploadedImages,
                                                imagesToRemove:
                                                    functions.listToString(
                                                        _model.imagesToRemove
                                                            .toList()),
                                                serviceCategory: _model
                                                    .categoryFieldModel
                                                    .textFieldTextController
                                                    .text,
                                                profileImage:
                                                    _model.profileImageUploaded,
                                                resourcesList: functions
                                                    .combineResourcesEditServicePage(
                                                        _model.addResources
                                                            .toList(),
                                                        _model.removeResources
                                                            .toList(),
                                                        widget
                                                            .service!.resources
                                                            .toList()),
                                              );
                                            }

                                            await action_blocks
                                                .loadServices(context);
                                            context.safePop();
                                          },
                                          text: valueOrDefault<String>(
                                            widget.create
                                                ? 'Create'
                                                : 'Update',
                                            'Create/Update',
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color(0x1A222831)
                                                    : const Color(0x1A83B4FF),
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            context.safePop();
                                          },
                                          text: 'Cancel',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: const Color(0x4DFF5963),
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.outfit(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ].divide(const SizedBox(width: 10.0)),
                                    ),
                                  ]
                                      .divide(const SizedBox(height: 10.0))
                                      .addToEnd(const SizedBox(height: 30.0)),
                                ),
                              ),
                            ].divide(const SizedBox(height: 15.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (responsiveVisibility(
                    context: context,
                    desktop: false,
                  ))
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      height: 80.0,
                      decoration: const BoxDecoration(
                        color: Color(0x0083B4FF),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          wrapWithModel(
                            model: _model.mobileNavBarModel,
                            updateCallback: () => safeSetState(() {}),
                            child: const MobileNavBarWidget(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
