import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/switch_booking_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/m4_new/components/price_low2/price_low2_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_dashboard_service_box_model.dart';
export 'business_dashboard_service_box_model.dart';

class BusinessDashboardServiceBoxWidget extends StatefulWidget {
  const BusinessDashboardServiceBoxWidget({
    super.key,
    required this.service,
  });

  final ServiceDataStruct? service;

  @override
  State<BusinessDashboardServiceBoxWidget> createState() =>
      _BusinessDashboardServiceBoxWidgetState();
}

class _BusinessDashboardServiceBoxWidgetState
    extends State<BusinessDashboardServiceBoxWidget> {
  late BusinessDashboardServiceBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardServiceBoxModel());

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
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF31363F)
            : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    valueOrDefault<String>(
                      functions.loadServiceProfileImage(
                          FFAppState().account.businessId,
                          widget.service?.id.toString(),
                          widget.service?.profileImage),
                      'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/service.jpg',
                    ),
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/error_image.png',
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.service?.name,
                          'Masaje Premium',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w800,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Text(
                        valueOrDefault<String>(
                          widget.service?.serviceCategory,
                          'Massages',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).neutral300,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ],
                  ),
                ),
              ]
                  .divide(const SizedBox(width: 10.0))
                  .addToStart(const SizedBox(width: 10.0))
                  .addToEnd(const SizedBox(width: 10.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
            child: Text(
              valueOrDefault<String>(
                widget.service?.description,
                'Obten los mejores masajes aqui.',
              ),
              maxLines: 2,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                wrapWithModel(
                  model: _model.priceLow2Model,
                  updateCallback: () => safeSetState(() {}),
                  child: PriceLow2Widget(
                    text: valueOrDefault<String>(
                      (int cents) {
                        return "\$${(cents / 100).toStringAsFixed(2)}++";
                      }(widget.service!.priceLowCents),
                      '\$100++',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2.0,
            indent: 10.0,
            endIndent: 10.0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          if (false)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: 100.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x8964A1E9),
                          Color(0x09EEEEEE),
                          Color(0x00EEEEEE)
                        ],
                        stops: [0.0, 0.4, 1.0],
                        begin: AlignmentDirectional(1.0, 0.98),
                        end: AlignmentDirectional(-1.0, -0.98),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondary,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: const BoxDecoration(
                            color: Color(0x194F87C9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            FFIcons.kcalendarAdd,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Text(
                          'Booking: Enable',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 60.0,
                            decoration: const BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.switchBookingModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: SwitchBookingWidget(
                                parameter1: _model.bookingEnabled,
                                changue: () async {
                                  // toggelAppstate
                                  _model.bookingEnabled =
                                      !_model.bookingEnabled;
                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 100.0,
                    height: 115.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x8964A1E9),
                          Color(0x09EEEEEE),
                          Color(0x00EEEEEE)
                        ],
                        stops: [0.0, 0.4, 1.0],
                        begin: AlignmentDirectional(1.0, 0.98),
                        end: AlignmentDirectional(-1.0, -0.98),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondary,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: const BoxDecoration(
                            color: Color(0x194F87C9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            FFIcons.kcalendarAdd,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        Text(
                          'José: Active',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 60.0,
                            decoration: const BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.switchBookingModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: SwitchBookingWidget(
                                parameter1: _model.joseActive,
                                changue: () async {
                                  // toggelAppstate
                                  _model.joseActive = !_model.joseActive;
                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              ]
                  .divide(const SizedBox(width: 10.0))
                  .addToStart(const SizedBox(width: 10.0))
                  .addToEnd(const SizedBox(width: 10.0)),
            ),
          if (false)
            Divider(
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color(0x4C4F87C9)
                  : const Color(0x4C4F87C9),
            ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (false)
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {},
                      text: 'View images',
                      options: FFButtonOptions(
                        height: 35.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              font: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).secondaryAlpha30,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(
                        BusinessDashboardAddServicesWidget.routeName,
                        queryParameters: {
                          'service': serializeParam(
                            widget.service,
                            ParamType.DataStruct,
                          ),
                          'serviceId': serializeParam(
                            widget.service?.id,
                            ParamType.int,
                          ),
                          'create': serializeParam(
                            false,
                            ParamType.bool,
                          ),
                        }.withoutNulls,
                      );
                    },
                    text: 'Edit',
                    icon: const Icon(
                      FFIcons.kedit,
                      size: 18.0,
                    ),
                    options: FFButtonOptions(
                      height: 35.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryAlpha30,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await ServicesTable().delete(
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.service?.id,
                        ),
                      );
                      await action_blocks.loadServices(context);
                      await action_blocks.successSnackbar(
                        context,
                        message: 'Deleted service',
                      );
                      safeSetState(() {});
                    },
                    text: 'Delete',
                    icon: const Icon(
                      FFIcons.ktrash,
                      size: 18.0,
                    ),
                    options: FFButtonOptions(
                      height: 35.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconColor: const Color(0xFFD30000),
                      color: const Color(0x1AFF5963),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: const Color(0xFFD30000),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryAlpha30,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ].divide(const SizedBox(width: 10.0)),
            ),
          ),
        ].addToStart(const SizedBox(height: 10.0)).addToEnd(const SizedBox(height: 10.0)),
      ),
    );
  }
}
