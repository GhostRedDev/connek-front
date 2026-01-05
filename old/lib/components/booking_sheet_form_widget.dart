import '/backend/schema/structs/index.dart';
import '/components/full_calendar_book_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'booking_sheet_form_model.dart';
export 'booking_sheet_form_model.dart';

class BookingSheetFormWidget extends StatefulWidget {
  const BookingSheetFormWidget({
    super.key,
    this.booking,
    required this.create,
  });

  final ClientBookingsFullDataStruct? booking;
  final bool? create;

  @override
  State<BookingSheetFormWidget> createState() => _BookingSheetFormWidgetState();
}

class _BookingSheetFormWidgetState extends State<BookingSheetFormWidget> {
  late BookingSheetFormModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingSheetFormModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On component dispose action.
    () async {
      await action_blocks.initClientBookingSession(
        context,
        dispose: true,
      );
    }();

    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 1.0,
          sigmaY: 1.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0x25FFFFFF),
          ),
          alignment: const AlignmentDirectional(0.0, 1.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!widget.create!)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 7.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            -2.0,
                          ),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 0.0, 16.0),
                            child: Text(
                              'Update a booking',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.outfit(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          wrapWithModel(
                            model: _model.fullCalendarBookModel,
                            updateCallback: () => safeSetState(() {}),
                            child: FullCalendarBookWidget(
                              create: false,
                              bookAction:
                                  (startTime, endTime, bookingDate) async {
                                await action_blocks.updateBooking(
                                  context,
                                  bookingId: widget.booking?.id,
                                  startTimeUtc:
                                      functions.parseDayTimeToISOString(
                                          FFAppState()
                                              .clientBookingSession
                                              .slotSelected
                                              .day,
                                          FFAppState()
                                              .clientBookingSession
                                              .slotSelected
                                              .startTime),
                                  requestId: widget.booking?.requestId,
                                  serviceId:
                                      widget.booking?.requests.serviceId,
                                  resourceId: FFAppState()
                                      .clientBookingSession
                                      .resourceSelected
                                      .resourceId,
                                  endTimeUtc: null,
                                  businessId: widget.booking?.businessId,
                                  addressId: widget.booking?.addressId,
                                );
                                await action_blocks.loadBookings(context);
                                Navigator.pop(context);
                              },
                              deleteAction: () async {
                                _model.confirm =
                                    await action_blocks.multiPurposeDialog(
                                  context,
                                  title:
                                      'Are you sure you want to cancel your booking?',
                                  texto: 'You cannot go back',
                                  cancel: 'Cancel',
                                  confirm: 'Confirm',
                                );
                                if (_model.confirm!) {
                                  await action_blocks.deleteBooking(
                                    context,
                                    bookingId: widget.booking?.id,
                                  );
                                  await action_blocks.loadBookings(context);
                                  Navigator.pop(context);
                                }

                                safeSetState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 44.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: 'Close',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 2.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
