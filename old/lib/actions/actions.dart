import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/multi_purpose_dialog_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/components/loading_dialog/loading_dialog_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future loadLeads(BuildContext context) async {
  ApiCallResponse? leadsQuery;
  List<BusinessLeadsStruct>? leadsParsed;

  leadsQuery = await ConnekApiGroup.businessLeadsCall.call(
    businessId: FFAppState().account.businessId,
    jwtToken: currentJwtToken,
  );

  if ((leadsQuery.succeeded ?? true)) {
    if (ConnekApiGroup.businessLeadsCall.success(
      (leadsQuery.jsonBody ?? ''),
    )!) {
      leadsParsed = await actions.queryToBusinessLeadsDataAppState(
        getJsonField(
          (leadsQuery.jsonBody ?? ''),
          r'''$.data''',
          true,
        ),
      );
      FFAppState().businessLeads =
          leadsParsed.toList().cast<BusinessLeadsStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error ',
        texto: getJsonField(
          (leadsQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
      FFAppState().businessLeads =
          functions.emptyLeadsList().toList().cast<BusinessLeadsStruct>();
      FFAppState().update(() {});
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Error from server',
      texto: (leadsQuery.bodyText ?? ''),
      cancel: '',
      confirm: '',
    );
  }
}

Future loadEmployeesNotHired(BuildContext context) async {
  List<EmployeesRow>? employeesQuery;
  List<EmployeesStruct>? employeesData;

  employeesQuery = await EmployeesTable().queryRows(
    queryFn: (q) => q,
  );
  employeesData = await actions.employeesToDataType(
    employeesQuery.toList(),
  );
}

Future subscribeToEmployee(
  BuildContext context, {
  required int? employeeId,
}) async {
  ApiCallResponse? stripeCheckout;

  stripeCheckout = await StripeGroup.employeeSubscribeCall.call(
    employeeId: employeeId,
    businessId: FFAppState().account.businessId,
  );

  if ((stripeCheckout.succeeded ?? true)) {
    if (StripeGroup.employeeSubscribeCall.success(
      (stripeCheckout.jsonBody ?? ''),
    )!) {
      await launchURL(StripeGroup.employeeSubscribeCall.redirectUrl(
        (stripeCheckout.jsonBody ?? ''),
      )!);
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Something went wrong.',
          style: FlutterFlowTheme.of(context).titleSmall.override(
                font: GoogleFonts.outfit(
                  fontWeight:
                      FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
        ),
        duration: const Duration(milliseconds: 3000),
        backgroundColor: FlutterFlowTheme.of(context).error,
      ),
    );
  }
}

Future errorSnackbar(
  BuildContext context, {
  required String? message,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
        style: FlutterFlowTheme.of(context).displaySmall.override(
              font: GoogleFonts.outfit(
                fontWeight:
                    FlutterFlowTheme.of(context).displaySmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
              ),
              fontSize: 20.0,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
            ),
      ),
      duration: const Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).error,
    ),
  );
}

Future successSnackbar(
  BuildContext context, {
  required String? message,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message!,
        style: FlutterFlowTheme.of(context).displaySmall.override(
              font: GoogleFonts.outfit(
                fontWeight:
                    FlutterFlowTheme.of(context).displaySmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
              ),
              fontSize: 20.0,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
            ),
      ),
      duration: const Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).primary,
    ),
  );
}

Future loadingDialog(BuildContext context) async {}

Future initAppStates(BuildContext context) async {
  await action_blocks.loadBalances(context);
  await action_blocks.loadBookings(context);
  await action_blocks.loadContactsClient(context);
  await action_blocks.loadPaymentMethods(context);
  await action_blocks.loadTransactions(context);
  await action_blocks.loadDeposits(context);
  if (FFAppState().account.isBusiness) {
    await action_blocks.loadContactsBusiness(context);
    await action_blocks.loadResources(context);
    await action_blocks.loadServices(context);
    await action_blocks.loadGreg(context);
    await action_blocks.loadLeads(context);
  }
  FFAppState().businessDashboardPage = BusinessPages.overview;
  FFAppState().clientDashboardPage = ClientPages.requests;
  FFAppState().pageSelected = Pages.home;
  FFAppState().update(() {});
}

Future loadUserApp(BuildContext context) async {
  List<ClientRow>? client;
  ApiCallResponse? accountsQuery;
  BusinessDataStruct? businessDataQuery;

  // get client
  client = await ClientTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'user_id',
      currentUserUid,
    ),
  );
  accountsQuery = await ConnekApiGroup.getClientAccountsCall.call(
    clientId: client.firstOrNull?.id,
    jwtToken: currentJwtToken,
  );

  FFAppState().clientProfile =
      functions.parseClientProfile(client.firstOrNull!);
  FFAppState().updateAccountStruct(
    (e) => e
      ..clientId = ConnekApiGroup.getClientAccountsCall.clientId(
        (accountsQuery?.jsonBody ?? ''),
      )
      ..isBusiness = ConnekApiGroup.getClientAccountsCall.isBusiness(
        (accountsQuery?.jsonBody ?? ''),
      )
      ..businessId = ConnekApiGroup.getClientAccountsCall.businessId(
        (accountsQuery?.jsonBody ?? ''),
      )
      ..businesses = functions
          .parseBusinessDataMini(getJsonField(
            (accountsQuery?.jsonBody ?? ''),
            r'''$.data.businesses''',
            true,
          )!)
          .toList(),
  );
  FFAppState().update(() {});
  if (FFAppState().account.isBusiness) {
    businessDataQuery = await action_blocks.loadBusinessData(
      context,
      businessId: FFAppState().account.businessId,
    );
    FFAppState().businessData = businessDataQuery;
    FFAppState().update(() {});
  }
}

/// Loads business services
Future loadServices(BuildContext context) async {
  List<ServicesRow>? servicesQuery;

  servicesQuery = await ServicesTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'business_id',
      FFAppState().account.businessId,
    ),
  );
  FFAppState().servicesData = functions
      .parseServicesROW(servicesQuery.toList(),
          FFAppState().account.businessId, FFAppState().businessData.name)
      .toList()
      .cast<ServiceDataStruct>();
  FFAppState().update(() {});
}

Future normalSearch(
  BuildContext context, {
  String? prompt,
}) async {
  ApiCallResponse? searchQuery;

  searchQuery = await ConnekApiGroup.normalSearchCall.call(
    prompt: prompt,
    clientId: FFAppState().account.clientId,
    jwtToken: currentJwtToken,
  );

  FFAppState().addToExamplesIDlist((searchQuery.bodyText ?? ''));
  if ((searchQuery.succeeded ?? true)) {
    if (ConnekApiGroup.normalSearchCall.success(
      (searchQuery.jsonBody ?? ''),
    )!) {
      FFAppState().updateNormalSearchResultsStruct(
        (e) => e
          ..services = functions
              .parseServices(
                  ConnekApiGroup.normalSearchCall
                      .data(
                        (searchQuery?.jsonBody ?? ''),
                      )!
                      .toList(),
                  0)
              .toList()
          ..businesses = functions
              .parseBusinessResults(
                  ConnekApiGroup.normalSearchCall
                      .data(
                        (searchQuery?.jsonBody ?? ''),
                      )!
                      .toList(),
                  0)
              .toList(),
      );
      FFAppState().update(() {});
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error',
        texto: getJsonField(
          (searchQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error.',
      texto: (searchQuery.bodyText ?? ''),
      cancel: '',
      confirm: '',
    );
  }
}

Future createQuote(
  BuildContext context, {
  required DateTime? expiring,
  required String? description,
  required int? leadId,
  int? serviceId,
  required int? amountCents,
  required int? requestId,
}) async {
  bool? response;
  QuoteRow? newQuoteQuery;

  response = await action_blocks.multiPurposeDialog(
    context,
    title: 'Create Quote?',
    texto: 'Are you sure to create a new quote?',
    cancel: 'CANCEL',
    confirm: 'OK',
  );
  if (response == true) {
    newQuoteQuery = await QuoteTable().insert({
      'lead_id': leadId,
      'service_id': serviceId,
      'description': description,
      'expiring': supaSerialize<DateTime>(expiring),
      'amountCents': 0,
    });
    await LeadsTable().update(
      data: {
        'id': leadId,
        'proposal_sent': true,
      },
      matchingRows: (rows) => rows,
    );
    await RequestsTable().update(
      data: {
        'id': requestId,
        'proposal_sent': true,
      },
      matchingRows: (rows) => rows,
    );
  }
}

Future acceptQuote(
  BuildContext context, {
  required int? quoteId,
  required int? leadId,
}) async {
  ApiCallResponse? apiResult4qo;

  apiResult4qo = await ConnekApiGroup.quotesAcceptCall.call(
    quoteId: quoteId,
    leadId: leadId,
  );

  if ((apiResult4qo.succeeded ?? true)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Quote updated sucessfully',
          style: TextStyle(),
        ),
        duration: const Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'It looks like something going wrong',
          style: TextStyle(),
        ),
        duration: const Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}

Future businessVerification(BuildContext context) async {
  ApiCallResponse? verificationQuery;

  verificationQuery = await ConnekApiGroup.getBusinessVerificationCall.call(
    businessStripeId: FFAppState().businessData.stripeId,
    jwtToken: currentJwtToken,
  );

  if ((verificationQuery.succeeded ?? true)) {
    if (ConnekApiGroup.getBusinessVerificationCall.success(
          (verificationQuery.jsonBody ?? ''),
        ) ==
        true) {
      FFAppState().businessVerified = BusinessVerifiedStruct(
        status: ConnekApiGroup.getBusinessVerificationCall.status(
          (verificationQuery.jsonBody ?? ''),
        ),
        missingId: ConnekApiGroup.getBusinessVerificationCall.missingId(
          (verificationQuery.jsonBody ?? ''),
        ),
        missingPoa: ConnekApiGroup.getBusinessVerificationCall.missingPoa(
          (verificationQuery.jsonBody ?? ''),
        ),
      );
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: getJsonField(
          (verificationQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: (verificationQuery.bodyText ?? ''),
    );
  }
}

Future loadBusinessDeposit(BuildContext context) async {
  List<BusinessDepositsRow>? depositQuery;

  depositQuery = await BusinessDepositsTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'business_id',
      FFAppState().account.businessId,
    ),
  );
  FFAppState().businessDeposit = BusinessDepositStruct(
    account: depositQuery.firstOrNull?.account,
    transit: depositQuery.firstOrNull?.transit,
    institution: depositQuery.firstOrNull?.institution,
    automaticTransfers: depositQuery.firstOrNull?.automaticTransfers,
  );
}

Future updateRequestAfterQuote(
  BuildContext context, {
  required QuoteRow? quote,
}) async {
  List<LeadsRow>? updatedLeadQuery;
  List<RequestsRow>? updatedRequestQuery;

  updatedLeadQuery = await LeadsTable().update(
    data: {
      'proposal_sent': true,
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      quote?.leadId,
    ),
    returnRows: true,
  );
  updatedRequestQuery = await RequestsTable().update(
    data: {
      'proposal_sent': true,
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      updatedLeadQuery?.firstOrNull?.requestId,
    ),
    returnRows: true,
  );
  await action_blocks.loadLeads(context);
}

Future loadRequestDetails(
  BuildContext context, {
  required int? requestId,
}) async {
  ApiCallResponse? clientRequestFullQuery;
  ApiCallResponse? acceptedQuoteFull;
  List<BookingsRow>? booking;

  clientRequestFullQuery = await ConnekApiGroup.getClientRequestFullCall.call(
    requestId: requestId,
    jwtToken: currentJwtToken,
  );

  if ((clientRequestFullQuery.succeeded ?? true)) {
    if (ConnekApiGroup.getClientRequestFullCall.success(
      (clientRequestFullQuery.jsonBody ?? ''),
    )!) {
      FFAppState().clientRequestFull = functions
          .parseClientRequestFull(ConnekApiGroup.getClientRequestFullCall.data(
        (clientRequestFullQuery.jsonBody ?? ''),
      ))!;
      FFAppState().update(() {});
      acceptedQuoteFull =
          await ConnekApiGroup.getClientRequestAcceptedQuoteCall.call(
        requestId: requestId,
        jwtToken: currentJwtToken,
      );

      FFAppState().TEMPSTATEJSON =
          ConnekApiGroup.getClientRequestAcceptedQuoteCall.data(
        (acceptedQuoteFull.jsonBody ?? ''),
      );
      if ((acceptedQuoteFull.succeeded ?? true)) {
        if (ConnekApiGroup.getClientRequestAcceptedQuoteCall.success(
              (acceptedQuoteFull.jsonBody ?? ''),
            )! &&
            (ConnekApiGroup.getClientRequestAcceptedQuoteCall.data(
                  (acceptedQuoteFull.jsonBody ?? ''),
                ) !=
                null)) {
          FFAppState().clientRequestAcceptedQuote2 = functions.parseQuotesFull(
              ConnekApiGroup.getClientRequestAcceptedQuoteCall.data(
            (acceptedQuoteFull.jsonBody ?? ''),
          ))!;
          FFAppState().update(() {});
          booking = await BookingsTable().queryRows(
            queryFn: (q) => q.eqOrNull(
              'quote_id',
              ConnekApiGroup.getClientRequestAcceptedQuoteCall.quoteId(
                (acceptedQuoteFull?.jsonBody ?? ''),
              ),
            ),
          );
          FFAppState().clientDashboardBooking = BookingDataStruct(
            id: booking.firstOrNull?.id,
            createdAt: booking.firstOrNull?.createdAt,
            clientId: booking.firstOrNull?.clientId,
            businessId: booking.firstOrNull?.businessId,
            addressId: booking.firstOrNull?.addressId,
            status: booking.firstOrNull?.status,
            requestId: booking.firstOrNull?.requestId,
            startTimeUtc: booking.firstOrNull?.startTimeUtc,
            endTimeUtc: booking.firstOrNull?.endTimeUtc,
          );
          FFAppState().update(() {});
        } else {
          FFAppState().clientRequestAcceptedQuote2 = QuoteFullDataStruct();
          FFAppState().update(() {});
        }
      } else {
        await action_blocks.errorSnackbar(
          context,
          message: 'error server accepted quote',
        );
      }
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'error req',
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'error server req',
    );
  }
}

Future loadRequestQuotes(
  BuildContext context, {
  required List<int>? leadIds,
  required List<BusinessDataStruct>? businesses,
}) async {
  List<QuoteRow>? quoteQuery;

  FFAppState().loopCounts = 0;
  while (FFAppState().loopCounts < leadIds!.length) {
    quoteQuery = await QuoteTable().queryRows(
      queryFn: (q) => q.eqOrNull(
        'lead_id',
        leadIds.elementAtOrNull(FFAppState().loopCounts),
      ),
    );
    if ((quoteQuery).isNotEmpty) {
      FFAppState().addToClientRequestQuotes(ClientRequestQuoteStruct(
        quoteId: quoteQuery.firstOrNull?.id,
        createdAt: quoteQuery.firstOrNull?.createdAt,
        leadId: quoteQuery.firstOrNull?.leadId,
        serviceId: quoteQuery.firstOrNull?.serviceId,
        amountCents: quoteQuery.firstOrNull?.amountCents,
        description: quoteQuery.firstOrNull?.description,
        expiring: quoteQuery.firstOrNull?.expiring,
        paid: quoteQuery.firstOrNull?.paid,
        status: quoteQuery.firstOrNull?.status,
        businessName:
            (businesses?.elementAtOrNull(FFAppState().loopCounts))?.name,
      ));
      FFAppState().update(() {});
    }
    FFAppState().loopCounts = FFAppState().loopCounts + 1;
  }
  FFAppState().loopCounts = 0;
}

Future createRequest(
  BuildContext context, {
  required int? businessId,
  int? serviceId,
  int? budgetMIn,
  int? budgetMax,
  required bool? isDirect,
  required String? description,
  List<FFUploadedFile>? files,
}) async {
  ApiCallResponse? requestQuery;

  requestQuery = await ConnekApiGroup.createRequestNewCall.call(
    clientId: FFAppState().account.clientId,
    isDirect: isDirect,
    description: description,
    serviceId: valueOrDefault<int>(
      serviceId,
      0,
    ),
    budgetMinCents: budgetMIn,
    budgetMaxCents: budgetMax,
    filesList: files,
    businessId: businessId,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        (requestQuery.jsonBody ?? '').toString(),
        style: const TextStyle(),
      ),
      duration: const Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).secondary,
    ),
  );
  if ((requestQuery.succeeded ?? true)) {
    if (ConnekApiGroup.createRequestNewCall.success(
      (requestQuery.jsonBody ?? ''),
    )!) {
      await action_blocks.successSnackbar(
        context,
        message: 'Created Request',
      );

      context.goNamed(ClientDashboardRequestWidget.routeName);

      await action_blocks.loadLeads(context);
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Error creating request. ',
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Error from server creating request. ',
    );
  }
}

Future<dynamic> uploadFiles(
  BuildContext context, {
  required String? bucket,
  required String? path,
  required List<FFUploadedFile>? files,
}) async {
  ApiCallResponse? uploadQuery;

  uploadQuery = await ConnekApiGroup.uploadFileToStorageCall.call(
    bucket: bucket,
    path: path,
    filesList: files,
    jwtToken: currentJwtToken,
  );

  if ((uploadQuery.succeeded ?? true)) {
    if (getJsonField(
      (uploadQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      return getJsonField(
        (uploadQuery.jsonBody ?? ''),
        r'''$.data''',
      );
    }

    await action_blocks.errorSnackbar(
      context,
      message: getJsonField(
        (uploadQuery.jsonBody ?? ''),
        r'''$.error''',
      ).toString(),
    );
    return null;
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Error from server uploading files',
    );
  }

  return null;
}

Future setupPaymentMethod(BuildContext context) async {
  ApiCallResponse? setupPaymentMethodQuery;

  setupPaymentMethodQuery =
      await ConnekApiGroup.setupPaymentMethodConnekCall.call(
    customerId: FFAppState().account.isBusiness
        ? FFAppState().businessData.stripeCustomerId
        : FFAppState().clientProfile.stripeId,
    clientId: FFAppState().account.clientId,
    jwtToken: currentJwtToken,
    businessId: FFAppState().account.businessId,
  );

  if ((setupPaymentMethodQuery.succeeded ?? true)) {
    if (getJsonField(
      (setupPaymentMethodQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await launchURL(getJsonField(
        (setupPaymentMethodQuery.jsonBody ?? ''),
        r'''$.data.url''',
      ).toString());
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error',
        texto: getJsonField(
          (setupPaymentMethodQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: 'Close',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Error from server',
      texto: (setupPaymentMethodQuery.bodyText ?? ''),
      cancel: '',
      confirm: 'Close',
    );
  }
}

Future loadPaymentMethods(BuildContext context) async {
  List<PaymentMethodsRow>? methodsQuery;

  methodsQuery = await PaymentMethodsTable().queryRows(
    queryFn: (q) => q
        .eqOrNull(
          'client_id',
          FFAppState().account.clientId,
        )
        .eqOrNull(
          'business_id',
          FFAppState().account.isBusiness
              ? FFAppState().account.businessId
              : null,
        ),
  );
  FFAppState().clientPaymentMethods = functions
      .parseClientPaymentMethods(methodsQuery.toList())
      .toList()
      .cast<ClientPaymentMethodsStruct>();
  FFAppState().selectedClientPaymentMethod = FFAppState()
              .clientPaymentMethods
              .where((e) => e.defaultMethod)
              .toList().isNotEmpty
      ? FFAppState()
          .clientPaymentMethods
          .where((e) => e.defaultMethod)
          .toList()
          .firstOrNull!
      : FFAppState().clientPaymentMethods.firstOrNull!;
  FFAppState().update(() {});
}

Future chargeClientPaymentMethod(
  BuildContext context, {
  required int? businessId,
  required int? serviceId,
  required String? paymentMethodId,
  required String? description,
  required String? amountCents,
  required int? requestId,
  required int? leadId,
  required int? quoteId,
  required int? bookingId,
}) async {
  ApiCallResponse? chargeQuery;

  chargeQuery = await ConnekApiGroup.chargeSavedPaymentMethodCall.call(
    clientId: FFAppState().account.clientId,
    paymentMethodStripeId: paymentMethodId,
    amountCents: amountCents,
    businessId: businessId,
    description: description,
    jwtToken: currentJwtToken,
    serviceId: serviceId?.toString(),
  );

  if ((chargeQuery.succeeded ?? true)) {
    if (ConnekApiGroup.chargeSavedPaymentMethodCall.success(
      (chargeQuery.jsonBody ?? ''),
    )!) {
      await action_blocks.updatePaymentMade(
        context,
        requestId: requestId,
        leadId: leadId,
        quoteId: quoteId,
        bookingId: bookingId,
      );

      context.pushNamed(
        CheckoutSuccessWidget.routeName,
        queryParameters: {
          'transactionId': serializeParam(
            ConnekApiGroup.chargeSavedPaymentMethodCall.transactionId(
              (chargeQuery.jsonBody ?? ''),
            ),
            ParamType.int,
          ),
        }.withoutNulls,
      );
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Error processing the payment.',
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Server error processing the payment.',
    );
  }
}

Future updatePaymentMade(
  BuildContext context, {
  required int? requestId,
  required int? leadId,
  required int? quoteId,
  required int? bookingId,
}) async {
  List<RequestsRow>? updReq;
  List<LeadsRow>? updLead;
  List<QuoteRow>? updatedQuoteQuery;

  updReq = await RequestsTable().update(
    data: {
      'payment_made': true,
      'status': 'completed',
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      requestId,
    ),
    returnRows: true,
  );
  updLead = await LeadsTable().update(
    data: {
      'payment_made': true,
      'status': 'completed',
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      leadId,
    ),
    returnRows: true,
  );
  await QuoteTable().update(
    data: {
      'paid': true,
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      quoteId,
    ),
  );
  await BookingsTable().update(
    data: {
      'status': 'completed',
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      bookingId,
    ),
  );
}

Future logOutUpdateStates(BuildContext context) async {
  FFAppState().pageSelected = Pages.home;
  FFAppState().businessDashboardPage = BusinessPages.overview;
  FFAppState().clientDashboardPage = ClientPages.requests;
  FFAppState().profilePage = ProfilePages.profile;
  FFAppState().account = AccountStruct();
  FFAppState().clientProfile = ClientDataProfileStruct();
  FFAppState().servicesData = [];
  FFAppState().businessData = BusinessDataStruct();
  FFAppState().clientPayments = [];
  FFAppState().clientBookings = [];
  FFAppState().clientBookingSession = ClientBookingSessionStruct();
  FFAppState().updateMyBotsStruct(
    (e) => e..greg = null,
  );
  FFAppState().update(() {});
}

Future loadBalances(BuildContext context) async {
  ApiCallResponse? balancesQuery;

  balancesQuery = await ConnekApiGroup.getBalancesCall.call(
    clientId: FFAppState().account.clientId,
    jwtToken: currentJwtToken,
    businessId: FFAppState().account.businessId,
  );

  if ((balancesQuery.succeeded ?? true)) {
    if (ConnekApiGroup.getBalancesCall.success(
      (balancesQuery.jsonBody ?? ''),
    )!) {
      FFAppState().balance = getJsonField(
        (balancesQuery.jsonBody ?? ''),
        r'''$.data.balance''',
      );
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Could not get balances',
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Error from server. Could not get balances',
    );
  }
}

Future loadPayments(BuildContext context) async {}

Future<BusinessDataStruct> loadBusinessData(
  BuildContext context, {
  required int? businessId,
}) async {
  ApiCallResponse? getBusinessQuery;

  getBusinessQuery = await ConnekApiGroup.getFullBusinessDataCall.call(
    businessId: businessId,
    jwtToken: currentJwtToken,
  );

  return BusinessDataStruct(
    id: ConnekApiGroup.getFullBusinessDataCall.businessId(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    ownerClientId: ConnekApiGroup.getFullBusinessDataCall.ownerClientId(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    name: ConnekApiGroup.getFullBusinessDataCall.businessName(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    category: ConnekApiGroup.getFullBusinessDataCall.businessCategory(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    description: ConnekApiGroup.getFullBusinessDataCall.businessDescription(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    businessEmail: ConnekApiGroup.getFullBusinessDataCall.businessEmail(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    url: ConnekApiGroup.getFullBusinessDataCall.businessUrl(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    addressId: ConnekApiGroup.getFullBusinessDataCall.addressId(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    businessPhone: ConnekApiGroup.getFullBusinessDataCall.phone(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    googleBusinessId: ConnekApiGroup.getFullBusinessDataCall.googleBusinessId(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    stripeId: ConnekApiGroup.getFullBusinessDataCall.stripeId(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    payments: ConnekApiGroup.getFullBusinessDataCall.payments(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    validated: ConnekApiGroup.getFullBusinessDataCall.validated(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    services: functions.parseServicesListFINAL(
        ConnekApiGroup.getFullBusinessDataCall
            .services(
              (getBusinessQuery.jsonBody ?? ''),
            )!
            .toList(),
        ConnekApiGroup.getFullBusinessDataCall.businessId(
          (getBusinessQuery.jsonBody ?? ''),
        )!,
        ConnekApiGroup.getFullBusinessDataCall.businessName(
          (getBusinessQuery.jsonBody ?? ''),
        )!),
    addresses: functions.wrapAddressInList(AddressDataStruct(
      id: ConnekApiGroup.getFullBusinessDataCall.addressId(
        (getBusinessQuery.jsonBody ?? ''),
      ),
      createdAt: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.created_at''',
      ).toString(),
      line1: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.line_1''',
      ).toString(),
      line2: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.line_2''',
      ).toString(),
      city: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.city''',
      ).toString(),
      postalCode: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.postal_code''',
      ).toString(),
      state: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.state''',
      ).toString(),
      country: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.country''',
      ).toString(),
      location: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.location''',
      ),
      billing: getJsonField(
        ConnekApiGroup.getFullBusinessDataCall.address(
          (getBusinessQuery.jsonBody ?? ''),
        ),
        r'''$.billing''',
      ),
    )),
    profileImage: ConnekApiGroup.getFullBusinessDataCall.profileImage(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    bannerImage: ConnekApiGroup.getFullBusinessDataCall.bannerImage(
      (getBusinessQuery.jsonBody ?? ''),
    ),
    instagramHandle: ConnekApiGroup.getFullBusinessDataCall
        .instagramHandle(
          (getBusinessQuery.jsonBody ?? ''),
        )
        .toString(),
    facebookHandle: ConnekApiGroup.getFullBusinessDataCall
        .facebookHandle(
          (getBusinessQuery.jsonBody ?? ''),
        )
        .toString(),
    tiktokHandle: ConnekApiGroup.getFullBusinessDataCall
        .tiktokHandle(
          (getBusinessQuery.jsonBody ?? ''),
        )
        .toString(),
    whatsappHandle: ConnekApiGroup.getFullBusinessDataCall
        .whatsappHandle(
          (getBusinessQuery.jsonBody ?? ''),
        )
        .toString(),
    images: ConnekApiGroup.getFullBusinessDataCall
        .images(
          (getBusinessQuery.jsonBody ?? ''),
        )
        .toString(),
    openingHours: functions
        .parseOpeningHours(ConnekApiGroup.getFullBusinessDataCall.openingHours(
      (getBusinessQuery.jsonBody ?? ''),
    )),
    stripeCustomerId: getJsonField(
      (getBusinessQuery.jsonBody ?? ''),
      r'''$.data.customer_id''',
    ).toString(),
  );
}

Future loadClient(BuildContext context) async {
  List<ClientRow>? clientQuery;

  // get client
  clientQuery = await ClientTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'user_id',
      currentUserUid,
    ),
  );
  FFAppState().clientProfile =
      functions.parseClientProfile(clientQuery.firstOrNull!);
  FFAppState().updateAccountStruct(
    (e) => e..clientId = clientQuery?.firstOrNull?.id,
  );
  FFAppState().update(() {});
}

Future loadContactsBusiness(BuildContext context) async {
  ApiCallResponse? conversationsQuery;

  conversationsQuery = await ConnekApiGroup.getBusinessChatContactsCall.call(
    businessId: FFAppState().account.businessId,
    jwtToken: currentJwtToken,
  );

  FFAppState().TEMPSTATEJSON = (conversationsQuery.jsonBody ?? '');
  if ((conversationsQuery.succeeded ?? true)) {
    if (getJsonField(
      (conversationsQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      FFAppState().TEMPSTATE = getJsonField(
        (conversationsQuery.jsonBody ?? ''),
        r'''$.data''',
        true,
      )!
          .toList()
          .cast<dynamic>();
      FFAppState().contacts = functions
          .parseConversations(getJsonField(
            (conversationsQuery.jsonBody ?? ''),
            r'''$.data''',
            true,
          )!)
          .toList()
          .cast<ContactDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: getJsonField(
          (conversationsQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Server error getting conversations',
    );
  }
}

Future<ConversationsRow> getOrCreateConversationId(
  BuildContext context, {
  required int? otherClientId,
  required bool? otherBusiness,
  bool? youBusiness,
  int? business1,
  int? business2,
}) async {
  List<ConversationsRow>? conversationQuery1;
  List<ConversationsRow>? conversationQuery2;
  ConversationsRow? insertConversation;

  conversationQuery1 = await ConversationsTable().queryRows(
    queryFn: (q) => q
        .eqOrNull(
          'client1',
          FFAppState().account.clientId,
        )
        .eqOrNull(
          'client2',
          otherClientId,
        )
        .eqOrNull(
          'client1_business',
          youBusiness,
        )
        .eqOrNull(
          'client2_business',
          otherBusiness,
        ),
  );
  if (conversationQuery1.isNotEmpty) {
    return conversationQuery1.firstOrNull!;
  }

  conversationQuery2 = await ConversationsTable().queryRows(
    queryFn: (q) => q
        .eqOrNull(
          'client1',
          otherClientId,
        )
        .eqOrNull(
          'client2',
          FFAppState().account.clientId,
        )
        .eqOrNull(
          'client1_business',
          otherBusiness,
        )
        .eqOrNull(
          'client2_business',
          youBusiness,
        ),
  );
  if (conversationQuery2.isNotEmpty) {
    return conversationQuery2.firstOrNull!;
  }

  insertConversation = await ConversationsTable().insert({
    'client1': FFAppState().account.clientId,
    'client2': otherClientId,
    'client1_business': youBusiness,
    'client2_business': otherBusiness,
    'business1': business1,
    'business2': business2,
  });
  return insertConversation;
}

Future sendMessage(
  BuildContext context, {
  required String? content,
}) async {
  ApiCallResponse? newMessageQuery;

  newMessageQuery = await ConnekApiGroup.postSendMessageCall.call(
    conversationId: FFAppState().activeContact.id,
    sender: FFAppState().account.clientId,
    receiver: FFAppState().activeContact.contact.clientId,
    content: content,
    contentType: 'text',
    jwtToken: currentJwtToken,
  );

  if (!(newMessageQuery.succeeded ?? true)) {
    await action_blocks.errorSnackbar(
      context,
      message: 'Server error sending message',
    );
  }
}

Future loadRequests(BuildContext context) async {
  List<RequestsRow>? requestsQuery;

  requestsQuery = await RequestsTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'client_id',
      FFAppState().account.clientId,
    ),
  );
  FFAppState().clientRequests = functions
      .parseClientRequests(requestsQuery.toList())
      .sortedList(keyOf: (e) => e.createdAt!, desc: true)
      .toList()
      .cast<ClientRequestStruct>();
  FFAppState().update(() {});
}

Future createService(
  BuildContext context, {
  required String? name,
  required String? description,
  int? priceHighCents,
  int? priceLowCents,
  String? category,
  List<FFUploadedFile>? images,
  required int? durationMinutes,
  required int? priceCents,
  FFUploadedFile? profileImage,
  String? resourcesList,
}) async {
  ApiCallResponse? newServiceQuery;

  newServiceQuery = await ConnekApiGroup.createServiceCall.call(
    businessId: FFAppState().account.businessId,
    name: name,
    description: description,
    priceLowCents: priceLowCents,
    priceHighCents: priceHighCents,
    serviceCategory: category,
    imagesList: images?.take(1).toList(),
    priceCents: priceCents,
    durationMinutes: durationMinutes,
    profileImage: profileImage,
    resourcesList: resourcesList,
  );

  if ((newServiceQuery.succeeded ?? true)) {
    if (getJsonField(
      (newServiceQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Service created!',
        texto: 'You will now offer this service to clients.',
        cancel: '',
        confirm: '',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error creating service',
        texto: getJsonField(
          (newServiceQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (newServiceQuery.bodyText ?? ''),
          style: const TextStyle(),
        ),
        duration: const Duration(milliseconds: 7550),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}

Future deleteStorage(
  BuildContext context, {
  required String? bucket,
  required String? path,
}) async {
  ApiCallResponse? apiResult8wy;

  apiResult8wy = await ConnekApiGroup.deleteFileFromStorageCall.call(
    bucket: bucket,
    path: path,
    jwtToken: currentJwtToken,
  );

  if (!(apiResult8wy.succeeded ?? true)) {
    await action_blocks.errorSnackbar(
      context,
      message: 'Error deleting file',
    );
  }
}

Future createBooking(
  BuildContext context, {
  required int? businessId,
  required int? addressId,
  required int? requestId,
  required String? startTime,
  required String? endTime,
  required int? serviceId,
  ClientRequestStruct? request,
  int? leadId,
  int? quoteId,
  int? resourceId,
  int? oboBusinessId,
}) async {
  bool? response;
  ApiCallResponse? bookingQuery;
  bool? cc;
  bool? bb;
  bool? aa;

  response = await action_blocks.multiPurposeDialog(
    context,
    title: 'Create Booking?',
    texto: 'Are you sure to create a new booking?',
    cancel: 'CANCEL',
    confirm: 'OK',
  );
  if (response == true) {
    bookingQuery = await ConnekApiGroup.createBookingCall.call(
      clientId: FFAppState().account.clientId,
      businessId: businessId,
      addressId: addressId,
      requestId: requestId,
      startTimeUtc: startTime,
      endTimeUtc: endTime,
      serviceId: serviceId,
      quoteId: quoteId,
      leadId: leadId,
      resourceId: resourceId,
      jwtToken: currentJwtToken,
      oboBusinessId: oboBusinessId,
    );

    if ((bookingQuery.succeeded ?? true)) {
      if (ConnekApiGroup.createBookingCall.success(
        (bookingQuery.jsonBody ?? ''),
      )!) {
        await action_blocks.loadBookings(context);
        cc = await action_blocks.multiPurposeDialog(
          context,
          title: 'Booking confirmed!',
          texto: 'Booking confirmed!',
          cancel: '',
          confirm: 'OK',
        );
        if (request != null) {
          context.pushNamed(
            ClientDashboardRequestDetail2Widget.routeName,
            queryParameters: {
              'request': serializeParam(
                request,
                ParamType.DataStruct,
              ),
            }.withoutNulls,
          );
        } else {
          FFAppState().clientDashboardPage = ClientPages.bookings;

          context.goNamed(
            ClientPageWidget.routeName,
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        }
      } else {
        bb = await action_blocks.multiPurposeDialog(
          context,
          title: 'Error creating booking',
          texto: getJsonField(
            (bookingQuery.jsonBody ?? ''),
            r'''$.error''',
          ).toString(),
          cancel: 'CANCEL',
          confirm: 'OK',
        );
      }
    } else {
      aa = await action_blocks.multiPurposeDialog(
        context,
        title: 'Server error creating booking',
        texto: (bookingQuery.bodyText ?? ''),
        cancel: 'CANCEL',
        confirm: 'OK',
      );
    }
  }
}

Future loadQuote(
  BuildContext context, {
  required int? leadId,
}) async {}

Future loadLeadDetail(
  BuildContext context, {
  required int? leadId,
}) async {
  ApiCallResponse? leadAcceptedQuoteQuery;
  List<BookingsRow>? bookingQuery;

  leadAcceptedQuoteQuery =
      await ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.call(
    leadId: leadId,
  );

  if ((leadAcceptedQuoteQuery.succeeded ?? true)) {
    if ((ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.data(
              (leadAcceptedQuoteQuery.jsonBody ?? ''),
            ) !=
            null) &&
        ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.success(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        )!) {
      FFAppState().businessLeadAcceptedQuote = QuoteDataStruct(
        id: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.quoteId(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        createdAt: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.createdAt(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        leadId: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.leadId(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        description:
            ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.description(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        status: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.status(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        amountCents:
            ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.amountCents(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        paid: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.paid(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        expiring: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.expiring(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
        serviceId: ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.serviceId(
          (leadAcceptedQuoteQuery.jsonBody ?? ''),
        ),
      );
      FFAppState().update(() {});
      bookingQuery = await BookingsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'quote_id',
          ConnekApiGroup.getBusinessLeadAcceptedQuoteCall.quoteId(
            (leadAcceptedQuoteQuery?.jsonBody ?? ''),
          ),
        ),
      );
      FFAppState().businessLeadBooking = BookingDataStruct(
        id: bookingQuery.firstOrNull?.id,
        createdAt: bookingQuery.firstOrNull?.createdAt,
        clientId: bookingQuery.firstOrNull?.clientId,
        businessId: bookingQuery.firstOrNull?.businessId,
        addressId: bookingQuery.firstOrNull?.addressId,
        status: bookingQuery.firstOrNull?.status,
        requestId: bookingQuery.firstOrNull?.requestId,
        startTimeUtc: bookingQuery.firstOrNull?.startTimeUtc,
        endTimeUtc: bookingQuery.firstOrNull?.endTimeUtc,
      );
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'No accepted quotes yet.',
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Error getting accepted quote from server.',
    );
  }
}

Future goToChat(
  BuildContext context, {
  required int? client2,
  required bool? client2Business,
  int? activeRequest,
  int? activeLead,
  String? activeThread,
  required bool? isBusiness,
  int? businessId,
  int? business2,
}) async {
  ApiCallResponse? conversationQuery;

  conversationQuery =
      await ConnekApiGroup.createConversationIfNotExistsCall.call(
    client1: FFAppState().account.clientId,
    client2: client2,
    client1Business: FFAppState().account.isBusiness,
    client2Business: client2Business,
    botActive: true,
    activeRequest: activeRequest,
    activeLead: activeLead,
    jwtToken: currentJwtToken,
    activeThread: activeThread,
    business1: FFAppState().account.businessId,
    business2: business2,
  );

  if ((conversationQuery.succeeded ?? true) &&
      ConnekApiGroup.createConversationIfNotExistsCall.success(
        (conversationQuery.jsonBody ?? ''),
      )!) {
    if (FFAppState().account.isBusiness) {
      await action_blocks.loadContactsBusiness(context);
    } else {
      await action_blocks.loadContactsClient(context);
    }

    FFAppState().pageSelected = Pages.chat;
    FFAppState().activeContact = FFAppState()
        .contacts
        .where((e) =>
            e.id ==
            getJsonField(
              (conversationQuery?.jsonBody ?? ''),
              r'''$.data.id''',
            ))
        .toList()
        .firstOrNull!;
    FFAppState().update(() {});

    context.pushNamed(ChatPageWidget.routeName);
  }
}

Future updateService(
  BuildContext context, {
  required int? serviceId,
  required String? name,
  required int? priceLowCents,
  required int? priceHighCents,
  required int? priceCents,
  required int? durationMinutes,
  required String? description,
  required List<FFUploadedFile>? images,
  required String? imagesToRemove,
  required String? serviceCategory,
  FFUploadedFile? profileImage,
  String? resourcesList,
}) async {
  ApiCallResponse? updateServiceQuery;

  updateServiceQuery = await ConnekApiGroup.updateServiceCall.call(
    serviceId: serviceId,
    name: name,
    priceLowCents: priceLowCents,
    priceHighCents: priceHighCents,
    priceCents: priceCents,
    durationMinutes: durationMinutes,
    description: description,
    imagesList: images,
    imagesToRemove: imagesToRemove,
    serviceCategory: serviceCategory,
    profileImage: profileImage,
    jwtToken: currentJwtToken,
    resourcesList: resourcesList,
  );

  if ((updateServiceQuery.succeeded ?? true) &&
      getJsonField(
        (updateServiceQuery.jsonBody ?? ''),
        r'''$.success''',
      )) {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Update Service Succesful',
      texto: '',
      cancel: '',
      confirm: '',
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (updateServiceQuery.bodyText ?? ''),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        duration: const Duration(milliseconds: 7950),
        backgroundColor: FlutterFlowTheme.of(context).primary,
      ),
    );
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Error updating service :(',
      texto: getJsonField(
        (updateServiceQuery.jsonBody ?? ''),
        r'''$.error''',
      ).toString(),
      cancel: '',
      confirm: '',
    );
  }
}

Future uploadBusinessFiles(
  BuildContext context, {
  required List<FFUploadedFile>? files,
}) async {
  ApiCallResponse? uploadQuery;

  uploadQuery = await ConnekApiGroup.uploadBusinessFilesCall.call(
    businessId: FFAppState().account.businessId,
    filesList: files,
    jwtToken: currentJwtToken,
  );

  if ((uploadQuery.succeeded ?? true)) {
    if (getJsonField(
      (uploadQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.successSnackbar(
        context,
        message: getJsonField(
          (uploadQuery.jsonBody ?? ''),
          r'''$.data''',
        ).toString(),
      );
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: getJsonField(
          (uploadQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
      );
    }

    return;
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Error from server uploading files',
    );
  }
}

Future<bool> multiPurposeDialog(
  BuildContext context, {
  required String? title,
  required String? texto,
  required String? cancel,
  required String? confirm,
}) async {
  bool? dialogResponse;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            const AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: MultiPurposeDialogWidget(
          title: title!,
          texto: texto,
          cancel: cancel,
          confirm: confirm!,
        ),
      );
    },
  ).then((value) => dialogResponse = value);

  return dialogResponse!;
}

Future loadBookings(BuildContext context) async {
  ApiCallResponse? clientBookings;

  clientBookings = await ConnekApiGroup.getClientBookingsCall.call(
    clientId: FFAppState().account.clientId,
    jwtToken: currentJwtToken,
  );

  if ((clientBookings.succeeded ?? true)) {
    FFAppState().clientBookings = functions
        .parseClientBookings(ConnekApiGroup.getClientBookingsCall
            .data(
              (clientBookings.jsonBody ?? ''),
            )!
            .toList())
        .toList()
        .cast<ClientBookingsFullDataStruct>();
    FFAppState().update(() {});
  }
}

Future toggleLoadingDialog(
  BuildContext context, {
  bool? forceState,
}) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (dialogContext) {
      return Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment:
            const AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
        child: const SizedBox(
          height: 200.0,
          width: 200.0,
          child: LoadingDialogWidget(),
        ),
      );
    },
  );
}

Future loadResources(BuildContext context) async {
  ApiCallResponse? resourcesQuery;

  resourcesQuery = await ConnekApiGroup.getResourcesByBusinessIDCall.call(
    businessId: FFAppState().account.businessId,
    jwtToken: currentJwtToken,
  );

  if ((resourcesQuery.succeeded ?? true)) {
    if (ConnekApiGroup.getResourcesByBusinessIDCall.success(
      (resourcesQuery.jsonBody ?? ''),
    )!) {
      FFAppState().businessResources = functions
          .parseResourceData(ConnekApiGroup.getResourcesByBusinessIDCall
              .data(
                (resourcesQuery.jsonBody ?? ''),
              )!
              .toList())
          .toList()
          .cast<ResourceDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error getting resources',
        texto: getJsonField(
          (resourcesQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error getting resources',
      texto: getJsonField(
        (resourcesQuery.jsonBody ?? ''),
        r'''$.error''',
      ).toString(),
      cancel: '',
      confirm: '',
    );
  }
}

Future createResource(
  BuildContext context, {
  required String? resourceName,
  required BusinessOpeningHoursStruct? serviceTime,
  required String? resourceType,
}) async {
  ApiCallResponse? createResQuery;

  createResQuery = await ConnekApiGroup.createResourceCall.call(
    businessId: FFAppState().account.businessId,
    name: resourceName,
    active: true,
    jwtToken: currentJwtToken,
    serviceTimeJson: serviceTime?.toMap(),
  );

  if ((createResQuery.succeeded ?? true)) {
    if (ConnekApiGroup.createResourceCall.success(
      (createResQuery.jsonBody ?? ''),
    )!) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Resource succesfully created.',
        texto: '${ConnekApiGroup.createResourceCall.name(
          (createResQuery.jsonBody ?? ''),
        )} can now serve your clients.',
        cancel: '',
        confirm: '',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error creating resource.',
        texto: ConnekApiGroup.createResourceCall
            .error(
              (createResQuery.jsonBody ?? ''),
            )
            .toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error',
      texto: '',
      cancel: '',
      confirm: '',
    );
  }
}

Future updateResource(
  BuildContext context, {
  required int? resourceId,
  required String? name,
  required bool? active,
}) async {
  ApiCallResponse? updateResQuery;

  updateResQuery = await ConnekApiGroup.updateResourceCall.call(
    resourceId: resourceId,
    name: name,
    jwtToken: currentJwtToken,
    active: active,
  );

  if ((updateResQuery.succeeded ?? true)) {
    if (getJsonField(
      (updateResQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Resource succesfully created.',
        texto: '${ConnekApiGroup.updateResourceCall.name(
          (updateResQuery.jsonBody ?? ''),
        )} was updated.',
        cancel: '',
        confirm: '',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error creating resource.',
        texto: ConnekApiGroup.updateResourceCall.error(
          (updateResQuery.jsonBody ?? ''),
        ),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error',
      texto: '',
      cancel: '',
      confirm: '',
    );
  }
}

Future deleteResource(
  BuildContext context, {
  required int? resourceId,
}) async {
  ApiCallResponse? delRes;

  delRes = await ConnekApiGroup.deleteResourceCall.call(
    resourceId: resourceId,
    jwtToken: currentJwtToken,
  );

  if ((delRes.succeeded ?? true)) {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Succesfully deleted resource.',
      texto: '',
      cancel: '',
      confirm: '',
    );
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Error deleting resource.',
      texto: ConnekApiGroup.deleteResourceCall
          .error(
            (delRes.jsonBody ?? ''),
          )
          .toString(),
      cancel: '',
      confirm: '',
    );
  }
}

Future loadBusinessClients(BuildContext context) async {
  ApiCallResponse? bizClientsQuery;

  bizClientsQuery = await ConnekApiGroup.getBusinessClientsCall.call(
    businessId: FFAppState().account.businessId,
    jwtToken: currentJwtToken,
  );

  if ((bizClientsQuery.succeeded ?? true)) {
    if (ConnekApiGroup.getBusinessClientsCall.success(
      (bizClientsQuery.jsonBody ?? ''),
    )!) {
      FFAppState().businessClients = functions
          .parseBusinessClients(getJsonField(
            (bizClientsQuery.jsonBody ?? ''),
            r'''$.data''',
            true,
          )!)
          .toList()
          .cast<BusinessClientsDataStruct>();
    }
  }
}

Future loadResoucesForServiceId(
  BuildContext context, {
  required ServiceDataStruct? service,
}) async {
  ApiCallResponse? resourcesByServiceIdQuery;

  resourcesByServiceIdQuery =
      await ConnekApiGroup.getResourcesByServiceIdCall.call(
    serviceId: service?.id,
    jwtToken: currentJwtToken,
  );

  if ((resourcesByServiceIdQuery.succeeded ?? true)) {
    if (ConnekApiGroup.getResourcesByServiceIdCall.success(
      (resourcesByServiceIdQuery.jsonBody ?? ''),
    )!) {
      FFAppState().updateClientBookingSessionStruct(
        (e) => e
          ..resources = functions
              .parseResourceData(ConnekApiGroup.getResourcesByServiceIdCall
                  .data(
                    (resourcesByServiceIdQuery?.jsonBody ?? ''),
                  )!
                  .toList())
              .toList(),
      );
      FFAppState().update(() {});
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error getting resources',
        texto: ConnekApiGroup.getResourcesByServiceIdCall
            .error(
              (resourcesByServiceIdQuery.jsonBody ?? ''),
            )
            .toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error getting resources',
      texto: (resourcesByServiceIdQuery.bodyText ?? ''),
      cancel: '',
      confirm: '',
    );
  }
}

Future loadSlotsForBookingResourceAndDay(
  BuildContext context, {
  required int? resourceId,
  required int? serviceId,
  required String? day,
}) async {
  ApiCallResponse? getSlotsQuery;

  getSlotsQuery = await ConnekApiGroup.getOpenSlotsForResourceForDayCall.call(
    resourceId: resourceId,
    day: day,
    serviceId: serviceId,
    jwtToken: currentJwtToken,
  );

  if ((getSlotsQuery.succeeded ?? true)) {
    FFAppState().TEMPSTATE = ConnekApiGroup.getOpenSlotsForResourceForDayCall
        .data(
          (getSlotsQuery.jsonBody ?? ''),
        )!
        .toList()
        .cast<dynamic>();
    FFAppState().updateClientBookingSessionStruct(
      (e) => e
        ..slots = functions
            .parseBookingSlotData(
                ConnekApiGroup.getOpenSlotsForResourceForDayCall
                    .data(
                      (getSlotsQuery?.jsonBody ?? ''),
                    )!
                    .toList())
            .toList(),
    );
    FFAppState().update(() {});
  }
}

Future uploadClientFiles(
  BuildContext context, {
  required List<FFUploadedFile>? files,
}) async {
  ApiCallResponse? uploadQuery;

  uploadQuery = await ConnekApiGroup.uploadClientFilesCall.call(
    clientId: FFAppState().account.clientId,
    filesList: files,
    jwtToken: currentJwtToken,
  );

  if ((uploadQuery.succeeded ?? true)) {
    if (getJsonField(
      (uploadQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Server error',
        texto: getJsonField(
          (uploadQuery.jsonBody ?? ''),
          r'''$.data''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Server error',
        texto: getJsonField(
          (uploadQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    }

    return;
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error',
      texto: (uploadQuery.bodyText ?? ''),
      cancel: '',
      confirm: '',
    );
  }
}

Future deleteBooking(
  BuildContext context, {
  required int? bookingId,
}) async {
  ApiCallResponse? apiResultx9p;

  apiResultx9p = await ConnekApiGroup.deleteBookingCall.call(
    bookingId: bookingId,
    jwtToken: currentJwtToken,
  );

  if ((apiResultx9p.succeeded ?? true)) {
    if (getJsonField(
      (apiResultx9p.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Succesfully deleted booking.',
        texto: '',
        cancel: '',
        confirm: '',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'There was an error',
        texto: getJsonField(
          (apiResultx9p.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'There was an error',
      texto: (apiResultx9p.bodyText ?? ''),
      cancel: '',
      confirm: '',
    );
  }
}

Future updateBooking(
  BuildContext context, {
  required int? bookingId,
  String? startTimeUtc,
  int? requestId,
  int? serviceId,
  int? resourceId,
  String? endTimeUtc,
  int? businessId,
  int? addressId,
}) async {
  ApiCallResponse? updateBookingQuery;

  updateBookingQuery = await ConnekApiGroup.updateBookingCall.call(
    bookingId: bookingId,
    startTimeUtc: startTimeUtc,
    jwtToken: currentJwtToken,
    clientId: FFAppState().account.clientId,
    oboBusinessId: FFAppState().account.businessId,
    requestId: requestId,
    businessId: businessId,
    addressId: addressId,
    endTimeUtc: endTimeUtc,
  );

  if ((updateBookingQuery.succeeded ?? true)) {
    if (getJsonField(
      (updateBookingQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Booking succesfully updated.',
        texto: '',
        cancel: '',
        confirm: '',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error updating booking.',
        texto: getJsonField(
          (updateBookingQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: '',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error',
      texto: (updateBookingQuery.bodyText ?? ''),
      cancel: '',
      confirm: '',
    );
  }
}

Future<ServiceDataStruct> getService(
  BuildContext context, {
  required int? serviceId,
  required int? businessId,
  required String? businessName,
}) async {
  List<ServicesRow>? servquery;

  servquery = await ServicesTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'id',
      serviceId,
    ),
  );
  return functions
      .parseServicesROW(servquery.toList(), businessId!, businessName!)
      .firstOrNull!;
}

Future initClientBookingSession(
  BuildContext context, {
  ClientRequestStruct? request,
  ServiceDataStruct? service,
  BusinessDataStruct? business,
  required bool? dispose,
  DateTime? daySelected,
  ResourceDataStruct? resource,
}) async {
  if (dispose!) {
    FFAppState().updateClientBookingSessionStruct(
      (e) => e
        ..daySelected = null
        ..services = null
        ..request = null
        ..business = null
        ..resources = []
        ..slots = []
        ..slotSelected = null
        ..resourceSelected = null,
    );
  } else {
    FFAppState().updateClientBookingSessionStruct(
      (e) => e
        ..daySelected =
            daySelected ?? functions.datetimeNow()
        ..services = service
        ..request = request
        ..business = business
        ..resourceSelected = resource,
    );
    await action_blocks.loadResoucesForServiceId(
      context,
      service: service,
    );
  }
}

Future loadContactsClient(BuildContext context) async {
  ApiCallResponse? conversationsQuery;

  conversationsQuery = await ConnekApiGroup.getClientChatContactsCall.call(
    clientId: FFAppState().account.clientId,
    jwtToken: currentJwtToken,
  );

  if ((conversationsQuery.succeeded ?? true)) {
    if (getJsonField(
      (conversationsQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      FFAppState().TEMPSTATE = getJsonField(
        (conversationsQuery.jsonBody ?? ''),
        r'''$.data''',
        true,
      )!
          .toList()
          .cast<dynamic>();
      FFAppState().contacts = functions
          .parseConversations(getJsonField(
            (conversationsQuery.jsonBody ?? ''),
            r'''$.data''',
            true,
          )!)
          .toList()
          .cast<ContactDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: getJsonField(
          (conversationsQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
      );
    }
  } else {
    await action_blocks.errorSnackbar(
      context,
      message: 'Server error getting conversations',
    );
  }
}

Future createGreg(BuildContext context) async {
  ApiCallResponse? createGregQuery;

  createGregQuery = await ConnekApiGroup.createGregCall.call(
    businessId: FFAppState().account.businessId,
    active: true,
    conversationTone: 'friendly',
    blacklistList: functions.emptyJsonList()?.map((e) => e.toString()).toList(),
    notifications: true,
    jwtToken: currentJwtToken,
  );

  if ((createGregQuery.succeeded ?? true)) {
    if (ConnekApiGroup.createGregCall.success(
      (createGregQuery.jsonBody ?? ''),
    )!) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Greg succesfully created.',
        texto: 'Greg',
        cancel: '',
        confirm: 'Ok',
      );
      FFAppState().officeDashboardPage = OfficePages.myBots;
      FFAppState().update(() {});
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error creating resource.',
        texto: ConnekApiGroup.createGregCall.error(
          (createGregQuery.jsonBody ?? ''),
        ),
        cancel: '',
        confirm: 'Ok',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error',
      texto: (createGregQuery.bodyText ?? ''),
      cancel: '',
      confirm: 'Ok',
    );
  }
}

Future loadGreg(BuildContext context) async {
  ApiCallResponse? gregQuery;

  gregQuery = await ConnekApiGroup.getGregByBusinessIdCall.call(
    businessId: FFAppState().account.businessId,
    jwtToken: currentJwtToken,
  );

  if ((gregQuery.succeeded ?? true) &&
      ConnekApiGroup.getGregByBusinessIdCall.success(
        (gregQuery.jsonBody ?? ''),
      )!) {
    FFAppState().TEMPSTATEJSON = ConnekApiGroup.getGregByBusinessIdCall.data(
      (gregQuery.jsonBody ?? ''),
    );
    FFAppState().updateMyBotsStruct(
      (e) => e
        ..greg =
            functions.parseGregData(ConnekApiGroup.getGregByBusinessIdCall.data(
          (gregQuery?.jsonBody ?? ''),
        )),
    );
  } else {
    FFAppState().updateMyBotsStruct(
      (e) => e..greg = null,
    );
  }
}

Future loadTransactions(BuildContext context) async {
  ApiCallResponse? businessTransactionsQuery;
  ApiCallResponse? clientTransactionsQuery;

  if (FFAppState().account.isBusiness) {
    businessTransactionsQuery =
        await ConnekApiGroup.getBusinessTransactionsCall.call();

    if ((businessTransactionsQuery.succeeded ?? true) &&
        ConnekApiGroup.getBusinessTransactionsCall.success(
          (businessTransactionsQuery.jsonBody ?? ''),
        )!) {
      FFAppState().transactions = functions
          .parseTransactions(ConnekApiGroup.getBusinessTransactionsCall
              .data(
                (businessTransactionsQuery.jsonBody ?? ''),
              )!
              .toList())
          .toList()
          .cast<TransactionsDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Error fetching business transactions',
      );
    }
  } else {
    clientTransactionsQuery =
        await ConnekApiGroup.getClientTransactionsCall.call(
      clientId: FFAppState().account.clientId,
      jwtToken: currentJwtToken,
    );

    if ((clientTransactionsQuery.succeeded ?? true) &&
        getJsonField(
          (clientTransactionsQuery.jsonBody ?? ''),
          r'''$.success''',
        )) {
      FFAppState().transactions = functions
          .parseTransactions(getJsonField(
            (clientTransactionsQuery.jsonBody ?? ''),
            r'''$.data''',
            true,
          )!)
          .toList()
          .cast<TransactionsDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Error fetching client transactions',
      );
    }
  }
}

Future gregBlackList(
  BuildContext context, {
  required bool? add,
  required String? word,
}) async {
  ApiCallResponse? addQuery;
  ApiCallResponse? removeQuery;

  if (add == true) {
    addQuery = await ConnekApiGroup.addToGregBlacklistCall.call(
      word: word,
      businessId: FFAppState().account.businessId,
      jwtToken: currentJwtToken,
    );

    if ((addQuery.succeeded ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'added',
            style: TextStyle(),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (addQuery.bodyText ?? ''),
            style: const TextStyle(),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    }
  } else {
    removeQuery = await ConnekApiGroup.removeToGregBlacklistCall.call(
      word: word,
      businessId: FFAppState().account.businessId,
      jwtToken: currentJwtToken,
    );

    if ((removeQuery.succeeded ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'removed',
            style: TextStyle(),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (removeQuery.bodyText ?? ''),
            style: const TextStyle(),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    }
  }
}

Future updateGreg(BuildContext context) async {
  ApiCallResponse? updateGregQuery;

  updateGregQuery = await ConnekApiGroup.updateGregCall.call();

  if ((updateGregQuery.succeeded ?? true)) {
    if (getJsonField(
      (updateGregQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Greg succesfully created.',
        texto: 'Greg',
        cancel: '',
        confirm: 'Ok',
      );
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error creating resource.',
        texto: getJsonField(
          (updateGregQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: 'Ok',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Server error',
      texto: (updateGregQuery.bodyText ?? ''),
      cancel: '',
      confirm: 'Ok',
    );
  }
}

Future depositOrWithdrawal(
  BuildContext context, {
  int? amountCents,
  required String? category,
}) async {
  ApiCallResponse? depositQuery;

  depositQuery = await ConnekApiGroup.depositCall.call(
    clientId: FFAppState().account.clientId,
    amountCents: amountCents,
    category: category,
    businessId: FFAppState().account.businessId,
    paymentMethodId: FFAppState().selectedClientPaymentMethod.id,
    jwtToken: currentJwtToken,
  );

  if ((depositQuery.succeeded ?? true)) {
    if (getJsonField(
      (depositQuery.jsonBody ?? ''),
      r'''$.success''',
    )) {
      await action_blocks.loadBalances(context);
      if (category == 'deposit') {
        await action_blocks.multiPurposeDialog(
          context,
          title: 'Success',
          texto: '',
          cancel: '',
          confirm: 'OK',
        );
      } else {
        await action_blocks.multiPurposeDialog(
          context,
          title: 'Success',
          texto: 'Please wait 3 business days to process the withdraw.',
          cancel: '',
          confirm: 'OK',
        );
      }
    } else {
      await action_blocks.multiPurposeDialog(
        context,
        title: 'Error',
        texto: getJsonField(
          (depositQuery.jsonBody ?? ''),
          r'''$.error''',
        ).toString(),
        cancel: '',
        confirm: 'OK',
      );
    }
  } else {
    await action_blocks.multiPurposeDialog(
      context,
      title: 'Error',
      texto: (depositQuery.bodyText ?? ''),
      cancel: '',
      confirm: 'OK',
    );
  }
}

Future loadDeposits(BuildContext context) async {
  ApiCallResponse? businessDepositsQuery;
  ApiCallResponse? clientTransactionsQuery;

  if (FFAppState().account.isBusiness) {
    businessDepositsQuery = await ConnekApiGroup.getBusinessDepositsCall.call(
      clientId: FFAppState().account.clientId,
      businessId: FFAppState().account.businessId,
      jwtToken: currentJwtToken,
    );

    if ((businessDepositsQuery.succeeded ?? true) &&
        getJsonField(
          (businessDepositsQuery.jsonBody ?? ''),
          r'''$.success''',
        )) {
      FFAppState().deposits = functions
          .parseDeposits(getJsonField(
            (businessDepositsQuery.jsonBody ?? ''),
            r'''$.data''',
            true,
          )!)
          .toList()
          .cast<DepositsDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Error fetching business deposits',
      );
    }
  } else {
    clientTransactionsQuery = await ConnekApiGroup.getClientDepositsCall.call(
      clientId: FFAppState().account.clientId,
      jwtToken: currentJwtToken,
    );

    if ((clientTransactionsQuery.succeeded ?? true) &&
        getJsonField(
          (clientTransactionsQuery.jsonBody ?? ''),
          r'''$.success''',
        )) {
      FFAppState().deposits = functions
          .parseDeposits(getJsonField(
            (clientTransactionsQuery.jsonBody ?? ''),
            r'''$.data''',
            true,
          )!)
          .toList()
          .cast<DepositsDataStruct>();
      FFAppState().update(() {});
    } else {
      await action_blocks.errorSnackbar(
        context,
        message: 'Error fetching client deposits',
      );
    }
  }
}
