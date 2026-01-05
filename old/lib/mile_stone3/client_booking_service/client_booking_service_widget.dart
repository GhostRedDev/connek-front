import '/backend/supabase/supabase.dart';
import '/components/back_button_widget.dart';
import '/components/full_calendar_book_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar2/mobile_nav_bar2_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'client_booking_service_model.dart';
export 'client_booking_service_model.dart';

class ClientBookingServiceWidget extends StatefulWidget {
  const ClientBookingServiceWidget({super.key});

  static String routeName = 'ClientBookingService';
  static String routePath = 'clientBooking';

  @override
  State<ClientBookingServiceWidget> createState() =>
      _ClientBookingServiceWidgetState();
}

class _ClientBookingServiceWidgetState
    extends State<ClientBookingServiceWidget> {
  late ClientBookingServiceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientBookingServiceModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      await action_blocks.initClientBookingSession(
        context,
        dispose: true,
      );
    }();

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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).bg1Sec,
          body: Visibility(
            visible: responsiveVisibility(
              context: context,
              desktop: false,
            ),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF222831),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: const BoxDecoration(),
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 0.0),
                                      child: Text(
                                        'Book now',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              valueOrDefault<String>(
                                                'Business: ${FFAppState().clientBookingSession.business.name}',
                                                'Business: Home Improvement',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                              FFAppState()
                                                  .clientBookingSession
                                                  .services
                                                  .name,
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                            FutureBuilder<List<AddressesRow>>(
                                              future: AddressesTable()
                                                  .querySingleRow(
                                                queryFn: (q) => q
                                                    .eqOrNull(
                                                      'id',
                                                      FFAppState()
                                                          .clientBookingSession
                                                          .business
                                                          .addressId,
                                                    )
                                                    .eqOrNull(
                                                      'location',
                                                      true,
                                                    ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitRipple(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<AddressesRow>
                                                    textAddressesRowList =
                                                    snapshot.data!;

                                                final textAddressesRow =
                                                    textAddressesRowList
                                                            .isNotEmpty
                                                        ? textAddressesRowList
                                                            .first
                                                        : null;

                                                return Text(
                                                  valueOrDefault<String>(
                                                    textAddressesRow?.line1,
                                                    '123 Main Street',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                );
                                              },
                                            ),
                                          ].divide(const SizedBox(height: 5.0)),
                                        ),
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.fullCalendarBookModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: FullCalendarBookWidget(
                                        create: true,
                                        bookAction: (startTime, endTime,
                                            bookingDate) async {
                                          await action_blocks.createBooking(
                                            context,
                                            businessId: FFAppState()
                                                .clientBookingSession
                                                .business
                                                .id,
                                            addressId: FFAppState()
                                                .clientBookingSession
                                                .business
                                                .addressId,
                                            requestId: 0,
                                            startTime: functions
                                                .parseDayTimeToISO(
                                                    FFAppState()
                                                        .clientBookingSession
                                                        .slotSelected
                                                        .day,
                                                    FFAppState()
                                                        .clientBookingSession
                                                        .slotSelected
                                                        .startTime)
                                                ?.toString(),
                                            endTime: functions
                                                .parseDayTimeToISO(
                                                    FFAppState()
                                                        .clientBookingSession
                                                        .slotSelected
                                                        .day,
                                                    FFAppState()
                                                        .clientBookingSession
                                                        .slotSelected
                                                        .endTime)
                                                ?.toString(),
                                            serviceId: FFAppState()
                                                .clientBookingSession
                                                .services
                                                .id,
                                            request: null,
                                            leadId: 0,
                                            quoteId: 0,
                                            resourceId: FFAppState()
                                                .clientBookingSession
                                                .resourceSelected
                                                .resourceId,
                                            oboBusinessId:
                                                FFAppState().account.businessId,
                                          );
                                        },
                                        deleteAction: () async {},
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(height: 15.0))
                                      .addToEnd(const SizedBox(height: 25.0)),
                                ),
                              ),
                            ],
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
                              model: _model.mobileNavBar2Model,
                              updateCallback: () => safeSetState(() {}),
                              child: const MobileNavBar2Widget(),
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
      ),
    );
  }
}
