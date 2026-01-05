import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Connek api Group Code

class ConnekApiGroup {
  static String getBaseUrl({
    String? jwtToken = '',
  }) =>
      'https://connek-dev-aa5f5db19836.herokuapp.com';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [jwtToken]',
  };
  static NormalSearchCall normalSearchCall = NormalSearchCall();
  static CreateEmployeeCall createEmployeeCall = CreateEmployeeCall();
  static UpdateEmployeeCall updateEmployeeCall = UpdateEmployeeCall();
  static CreateBusinessCall createBusinessCall = CreateBusinessCall();
  static TesttttCall testtttCall = TesttttCall();
  static BusinessLeadsCall businessLeadsCall = BusinessLeadsCall();
  static SendMessageChatbotTestCall sendMessageChatbotTestCall =
      SendMessageChatbotTestCall();
  static SendMessageCall sendMessageCall = SendMessageCall();
  static GetConversationsCall getConversationsCall = GetConversationsCall();
  static GetFullBusinessDataCall getFullBusinessDataCall =
      GetFullBusinessDataCall();
  static GetBusinessVerificationCall getBusinessVerificationCall =
      GetBusinessVerificationCall();
  static DeletePaymentMethodCall deletePaymentMethodCall =
      DeletePaymentMethodCall();
  static CreateRequestCall createRequestCall = CreateRequestCall();
  static CreateRequestNewCall createRequestNewCall = CreateRequestNewCall();
  static UploadFileToStorageCall uploadFileToStorageCall =
      UploadFileToStorageCall();
  static ListFilesFromBucketCall listFilesFromBucketCall =
      ListFilesFromBucketCall();
  static DeleteFileFromStorageCall deleteFileFromStorageCall =
      DeleteFileFromStorageCall();
  static DeleteServiceFileCall deleteServiceFileCall = DeleteServiceFileCall();
  static ChargeSavedPaymentMethodCall chargeSavedPaymentMethodCall =
      ChargeSavedPaymentMethodCall();
  static GetBalancesCall getBalancesCall = GetBalancesCall();
  static UpdateClientProfilePictureCall updateClientProfilePictureCall =
      UpdateClientProfilePictureCall();
  static UpdateBusinessBannerCall updateBusinessBannerCall =
      UpdateBusinessBannerCall();
  static UpdateBusinessLogoCall updateBusinessLogoCall =
      UpdateBusinessLogoCall();
  static CreateServiceCall createServiceCall = CreateServiceCall();
  static DeleteBusinessCall deleteBusinessCall = DeleteBusinessCall();
  static DeleteStorageCall deleteStorageCall = DeleteStorageCall();
  static GetBookingCall getBookingCall = GetBookingCall();
  static DeleteBookingCall deleteBookingCall = DeleteBookingCall();
  static UpdateBookingCall updateBookingCall = UpdateBookingCall();
  static CreateBookingCall createBookingCall = CreateBookingCall();
  static GetClientBookingsCall getClientBookingsCall = GetClientBookingsCall();
  static GetBusinessBookingsCall getBusinessBookingsCall =
      GetBusinessBookingsCall();
  static UpdateServiceImageCall updateServiceImageCall =
      UpdateServiceImageCall();
  static GetClientRequestFullCall getClientRequestFullCall =
      GetClientRequestFullCall();
  static GetClientRequestAcceptedQuoteCall getClientRequestAcceptedQuoteCall =
      GetClientRequestAcceptedQuoteCall();
  static GetBusinessLeadAcceptedQuoteCall getBusinessLeadAcceptedQuoteCall =
      GetBusinessLeadAcceptedQuoteCall();
  static QuotesAcceptCall quotesAcceptCall = QuotesAcceptCall();
  static PostSendMessageCall postSendMessageCall = PostSendMessageCall();
  static CreateConversationIfNotExistsCall createConversationIfNotExistsCall =
      CreateConversationIfNotExistsCall();
  static GetClientTransactionsCall getClientTransactionsCall =
      GetClientTransactionsCall();
  static GetBusinessTransactionsCall getBusinessTransactionsCall =
      GetBusinessTransactionsCall();
  static UpdateServiceCall updateServiceCall = UpdateServiceCall();
  static UploadBusinessFilesCall uploadBusinessFilesCall =
      UploadBusinessFilesCall();
  static UploadClientFilesCall uploadClientFilesCall = UploadClientFilesCall();
  static GetResourcesByBusinessIDCall getResourcesByBusinessIDCall =
      GetResourcesByBusinessIDCall();
  static CreateResourceCall createResourceCall = CreateResourceCall();
  static UpdateResourceCall updateResourceCall = UpdateResourceCall();
  static DeleteResourceCall deleteResourceCall = DeleteResourceCall();
  static GetBusinessClientsCall getBusinessClientsCall =
      GetBusinessClientsCall();
  static GetResourcesByServiceIdCall getResourcesByServiceIdCall =
      GetResourcesByServiceIdCall();
  static GetOpenSlotsForResourceForDayCall getOpenSlotsForResourceForDayCall =
      GetOpenSlotsForResourceForDayCall();
  static GetClientAccountsCall getClientAccountsCall = GetClientAccountsCall();
  static GetBusinessChatContactsCall getBusinessChatContactsCall =
      GetBusinessChatContactsCall();
  static GetClientChatContactsCall getClientChatContactsCall =
      GetClientChatContactsCall();
  static GetGregByBusinessIdCall getGregByBusinessIdCall =
      GetGregByBusinessIdCall();
  static CreateGregCall createGregCall = CreateGregCall();
  static UpdateGregCall updateGregCall = UpdateGregCall();
  static AddToGregBlacklistCall addToGregBlacklistCall =
      AddToGregBlacklistCall();
  static RemoveToGregBlacklistCall removeToGregBlacklistCall =
      RemoveToGregBlacklistCall();
  static CreateStripeCustomerConnekCall createStripeCustomerConnekCall =
      CreateStripeCustomerConnekCall();
  static DepositCall depositCall = DepositCall();
  static SetupPaymentMethodConnekCall setupPaymentMethodConnekCall =
      SetupPaymentMethodConnekCall();
  static GetClientDepositsCall getClientDepositsCall = GetClientDepositsCall();
  static GetBusinessDepositsCall getBusinessDepositsCall =
      GetBusinessDepositsCall();
}

class NormalSearchCall {
  Future<ApiCallResponse> call({
    String? prompt = '',
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Normal Search',
      apiUrl: '$baseUrl/search',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'prompt': prompt,
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? clientid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].owner_client_id''',
      ));
  int? bussinesid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].name''',
      ));
  String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].addresses.city''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].description''',
      ));
  String? category(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].category''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].business_email''',
      ));
  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].url''',
      ));
  List<String>? servicename(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].services[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? price(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].services[:].price_low''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  String? owneruser(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].owner_user''',
      ));
  int? addressid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].address_id''',
      ));
  String? googlebusinessid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].google_business_id''',
      ));
  String? stripeid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].stripe_id''',
      ));
  bool? payments(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].payments''',
      ));
  bool? validated(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].validated''',
      ));
  List? services(dynamic response) => getJsonField(
        response,
        r'''$.data[:].services''',
        true,
      ) as List?;
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class CreateEmployeeCall {
  Future<ApiCallResponse> call({
    int? businessId,
    int? employeeId,
    String? formFields = '',
    String? additionalInstructions = '',
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Create Employee',
      apiUrl: '$baseUrl/api/chatbot',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'businessId': businessId,
        'employeeId': employeeId,
        'formFields': formFields,
        'additionalInstructions': additionalInstructions,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateEmployeeCall {
  Future<ApiCallResponse> call({
    int? chatbotId,
    String? formFields = '',
    String? additionalInstructions = '',
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Update Employee',
      apiUrl: '$baseUrl/api/chatbot',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'chatbotId': chatbotId,
        'formFields': formFields,
        'additionalInstructions': additionalInstructions,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateBusinessCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? line1 = '',
    String? line2 = '',
    String? postalCode = '',
    String? city = '',
    String? state = '',
    String? country = '',
    String? businessName = '',
    String? businessEmail = '',
    String? businessCategoryName = '',
    String? businessUrl = '',
    String? businessDescription = '',
    String? businessGooglePlaceId = '',
    String? businessType = '',
    dynamic servicesJson,
    String? transitNumber = '',
    String? accountNumber = '',
    String? businessPhone = '',
    String? institutionNumber = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final services = _serializeJson(servicesJson, true);

    return ApiManager.instance.makeApiCall(
      callName: 'Create Business',
      apiUrl: '$baseUrl/business/new',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'line_1': line1,
        'line_2': line2,
        'postal_code': postalCode,
        'city': city,
        'state': state,
        'country': country,
        'business_name': businessName,
        'business_email': businessEmail,
        'business_category_name': businessCategoryName,
        'business_url': businessUrl,
        'business_description': businessDescription,
        'business_google_place_id': businessGooglePlaceId,
        'business_type': businessType,
        'services': services,
        'account_number': accountNumber,
        'transit_number': transitNumber,
        'business_phone': businessPhone,
        'institution_number': institutionNumber,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  int? clientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.owner_client_id''',
      ));
}

class TesttttCall {
  Future<ApiCallResponse> call({
    List<String>? servicesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final services = _serializeList(servicesList);

    return ApiManager.instance.makeApiCall(
      callName: 'testttt',
      apiUrl: '$baseUrl/api/business/test',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'services': services,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class BusinessLeadsCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Business Leads',
      apiUrl: '$baseUrl/leads/business/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
      params: {
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic request(dynamic response) => getJsonField(
        response,
        r'''$.data.leads[:].requests''',
      );
  List? leads(dynamic response) => getJsonField(
        response,
        r'''$.data.leads''',
        true,
      ) as List?;
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? requestMinBudget(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].requests.budget_min''',
      ));
  int? requestMaxBudget(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].requests.budget_max''',
      ));
  String? requestDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].requests.description''',
      ));
  String? requestDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].requests.created_at''',
      ));
  String? leadDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].created_at''',
      ));
}

class SendMessageChatbotTestCall {
  Future<ApiCallResponse> call({
    String? contentType = 'text',
    String? content = '',
    int? chatbotTestId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Send Message Chatbot Test',
      apiUrl: '$baseUrl/api/chatbot/test',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'chatbot_test_id': chatbotTestId,
        'content': content,
        'content_type': contentType,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendMessageCall {
  Future<ApiCallResponse> call({
    int? conversationId,
    String? content = '',
    String? contentType = '',
    int? sender,
    int? receiver,
    String? authToken = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Send Message',
      apiUrl: '$baseUrl/api/message',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'conversation_id': conversationId,
        'content': content,
        'content_type': contentType,
        'sender': sender,
        'receiver': receiver,
        'auth_token': authToken,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetConversationsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Conversations',
      apiUrl: '$baseUrl/messages/contacts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? conversations(dynamic response) => getJsonField(
        response,
        r'''$.data.conversations''',
        true,
      ) as List?;
  dynamic contact(dynamic response) => getJsonField(
        response,
        r'''$.data.conversations[:].contact''',
      );
  bool? contactIsBusiness(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.conversations[:].contact_is_business''',
      ));
}

class GetFullBusinessDataCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Full Business Data',
      apiUrl: '$baseUrl/business/full/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  int? ownerClientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.owner_client_id''',
      ));
  String? businessName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  String? businessCategory(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.category''',
      ));
  String? businessDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.description''',
      ));
  String? businessUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.url''',
      ));
  String? businessEmail(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.business_email''',
      ));
  int? addressId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.address_id''',
      ));
  List? services(dynamic response) => getJsonField(
        response,
        r'''$.data.services''',
        true,
      ) as List?;
  String? line1(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.addresses.line_1''',
      ));
  String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.addresses.city''',
      ));
  String? postalCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.addresses.postal_code''',
      ));
  String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.addresses.state''',
      ));
  String? country(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.addresses.country''',
      ));
  String? serviceName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.services[:].name''',
      ));
  List<int>? servicePriceLow(dynamic response) => (getJsonField(
        response,
        r'''$.data.services[:].price_low_cents''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? servicePriceHigh(dynamic response) => (getJsonField(
        response,
        r'''$.data.services[:].price_high_cents''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  String? serviceDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.services[:].description''',
      ));
  String? serviceCategory(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.services[:].service_category''',
      ));
  dynamic address(dynamic response) => getJsonField(
        response,
        r'''$.data.addresses''',
      );
  bool? validated(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.validated''',
      ));
  bool? payments(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.payments''',
      ));
  int? phone(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.phone''',
      ));
  String? profileImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.profile_image''',
      ));
  String? stripeId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.stripe_id''',
      ));
  String? googleBusinessId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.google_business_id''',
      ));
  String? bannerImage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.banner_image''',
      ));
  dynamic openingHours(dynamic response) => getJsonField(
        response,
        r'''$.data.opening_hours''',
      );
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  dynamic images(dynamic response) => getJsonField(
        response,
        r'''$.data.images''',
      );
  dynamic whatsappHandle(dynamic response) => getJsonField(
        response,
        r'''$.data.whatsapp_handle''',
      );
  dynamic instagramHandle(dynamic response) => getJsonField(
        response,
        r'''$.data.instagram_handle''',
      );
  dynamic facebookHandle(dynamic response) => getJsonField(
        response,
        r'''$.data.facebook_handle''',
      );
  dynamic tiktokHandle(dynamic response) => getJsonField(
        response,
        r'''$.data.tiktok_handle''',
      );
}

class GetBusinessVerificationCall {
  Future<ApiCallResponse> call({
    String? businessStripeId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{"business_stripe_id":"${escapeStringForJson(businessStripeId)}"}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Verification',
      apiUrl: '$baseUrl/api/stripe/account/verification',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.verification.status''',
      ));
  bool? missingId(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.verification.missing.id''',
      ));
  bool? missingPoa(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.verification.missing.proof_of_address''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class DeletePaymentMethodCall {
  Future<ApiCallResponse> call({
    String? paymentMethodId = '',
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete Payment Method',
      apiUrl: '$baseUrl/payments/methods',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'payment_method_id': paymentMethodId,
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateRequestCall {
  Future<ApiCallResponse> call({
    int? clientId,
    int? businessId,
    bool? isDirect = true,
    String? description = '',
    int? serviceId,
    int? budgetMinCents,
    int? budgetMaxCents,
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Create Request',
      apiUrl: '$baseUrl/requests/request-direct',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'business_id': businessId,
        'is_direct': isDirect,
        'description': description,
        'service_id': serviceId,
        'budget_min_cents': budgetMinCents,
        'budget_max_cents': budgetMaxCents,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? requestId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.description''',
      ));
}

class CreateRequestNewCall {
  Future<ApiCallResponse> call({
    int? clientId,
    int? businessId,
    bool? isDirect = true,
    String? description = '',
    int? serviceId,
    int? budgetMinCents,
    int? budgetMaxCents,
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Create Request New',
      apiUrl: '$baseUrl/requests/create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'business_id': businessId,
        'is_direct': isDirect,
        'description': description,
        'service_id': serviceId,
        'budget_min_cents': budgetMinCents,
        'budget_max_cents': budgetMaxCents,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? requestId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.description''',
      ));
}

class UploadFileToStorageCall {
  Future<ApiCallResponse> call({
    String? bucket = '',
    String? path = '',
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Upload File To Storage',
      apiUrl: '$baseUrl/api/storage/upload',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'bucket': bucket,
        'path': path,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ListFilesFromBucketCall {
  Future<ApiCallResponse> call({
    String? bucket = '',
    String? path = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'List Files From Bucket',
      apiUrl: '$baseUrl/api/storage/list',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'bucket': bucket,
        'path': path,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data.files[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? size(dynamic response) => (getJsonField(
        response,
        r'''$.data.files[:].metadata.size''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data.files[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? updatedAt(dynamic response) => (getJsonField(
        response,
        r'''$.data.files[:].updated_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class DeleteFileFromStorageCall {
  Future<ApiCallResponse> call({
    String? bucket = '',
    String? path = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete File From Storage',
      apiUrl: '$baseUrl/api/storage/delete',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'bucket': bucket,
        'path': path,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteServiceFileCall {
  Future<ApiCallResponse> call({
    int? serviceId,
    int? businessId,
    String? filename = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete Service File',
      apiUrl: '$baseUrl/api/business/service/file',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'service_id': serviceId,
        'business_id': businessId,
        'filename': filename,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? succes(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  String? removedImageName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.removed_image''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class ChargeSavedPaymentMethodCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? amountCents = '',
    String? paymentMethodStripeId = '',
    int? businessId,
    String? serviceId = '',
    String? description = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "client_id": $clientId,
  "amount_cents": "${escapeStringForJson(amountCents)}",
  "payment_method_stripe_id": "${escapeStringForJson(paymentMethodStripeId)}",
  "business_id": $businessId,
  "service_id": "${escapeStringForJson(serviceId)}",
  "description": "${escapeStringForJson(description)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Charge Saved Payment Method',
      apiUrl: '$baseUrl/payments/charge',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? transactionId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.transaction_id''',
      ));
}

class GetBalancesCall {
  Future<ApiCallResponse> call({
    int? clientId,
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Balances',
      apiUrl: '$baseUrl/payments/balance',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? clientBalance(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.client_balance''',
      ));
  int? businessBalance(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.business_balance''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class UpdateClientProfilePictureCall {
  Future<ApiCallResponse> call({
    int? clientId,
    FFUploadedFile? file,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Update Client Profile Picture',
      apiUrl: '$baseUrl/api/client/profile-picture',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateBusinessBannerCall {
  Future<ApiCallResponse> call({
    int? businessId,
    FFUploadedFile? file,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Update Business Banner',
      apiUrl: '$baseUrl/api/business/banner',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateBusinessLogoCall {
  Future<ApiCallResponse> call({
    int? businessId,
    FFUploadedFile? file,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Update Business Logo',
      apiUrl: '$baseUrl/api/business/logo-picture',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'file': file,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateServiceCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? name = '',
    String? description = '',
    int? priceLowCents,
    int? priceHighCents,
    String? serviceCategory = '',
    List<FFUploadedFile>? imagesList,
    int? priceCents,
    int? durationMinutes,
    FFUploadedFile? profileImage,
    String? resourcesList = '[]',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final images = imagesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Create Service',
      apiUrl: '$baseUrl/services/create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'name': name,
        'description': description,
        'price_low_cents': priceLowCents,
        'price_high_cents': priceHighCents,
        'service_category': serviceCategory,
        'images': images,
        'price_cents': priceCents,
        'duration_minutes': durationMinutes,
        'profile_image': profileImage,
        'resources_list': resourcesList,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteBusinessCall {
  Future<ApiCallResponse> call({
    int? businessId,
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete Business',
      apiUrl: '$baseUrl/api/business',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteStorageCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? filename = '',
    String? bucket = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete Storage',
      apiUrl: '$baseUrl/storage/file',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'filename': filename,
        'bucket': bucket,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetBookingCall {
  Future<ApiCallResponse> call({
    int? bookingId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Booking',
      apiUrl: '$baseUrl/bookings/$bookingId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteBookingCall {
  Future<ApiCallResponse> call({
    int? bookingId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete Booking',
      apiUrl: '$baseUrl/bookings/$bookingId',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateBookingCall {
  Future<ApiCallResponse> call({
    int? bookingId,
    int? clientId,
    int? businessId,
    int? addressId,
    int? requestId,
    String? startTimeUtc = '',
    String? endTimeUtc = '',
    int? oboBusinessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Update Booking',
      apiUrl: '$baseUrl/bookings/$bookingId',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'booking_id': bookingId,
        'client_id': clientId,
        'business_id': businessId,
        'address_id': addressId,
        'request_id': requestId,
        'start_time_utc': startTimeUtc,
        'end_time_utc': endTimeUtc,
        'obo_business_id': oboBusinessId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateBookingCall {
  Future<ApiCallResponse> call({
    int? clientId,
    int? businessId,
    int? addressId,
    int? requestId,
    String? startTimeUtc = '',
    String? endTimeUtc = '',
    int? serviceId,
    int? quoteId,
    int? leadId,
    int? resourceId,
    int? oboBusinessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Create Booking',
      apiUrl: '$baseUrl/bookings/create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'business_id': businessId,
        'address_id': addressId,
        'request_id': requestId,
        'service_id': serviceId,
        'quote_id': quoteId,
        'lead_id': leadId,
        'resource_id': resourceId,
        'obo_business_id': oboBusinessId,
        'start_time_utc': startTimeUtc,
        'end_time_utc': endTimeUtc,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class GetClientBookingsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Bookings',
      apiUrl: '$baseUrl/bookings/client/$clientId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? clientId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].client_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? businessId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].business_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? addressId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].address_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? requestId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].request_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? startTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].start_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? endTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].end_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? bookingDate(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booking_date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  dynamic business(dynamic response) => getJsonField(
        response,
        r'''$.data[:].business''',
      );
  dynamic addresses(dynamic response) => getJsonField(
        response,
        r'''$.data[:].addresses''',
      );
  dynamic requests(dynamic response) => getJsonField(
        response,
        r'''$.data[:].requests''',
      );
  dynamic quote(dynamic response) => getJsonField(
        response,
        r'''$.data[:].quote''',
      );
}

class GetBusinessBookingsCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Bookings',
      apiUrl: '$baseUrl/bookings/business/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? clientId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].client_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? businessId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].business_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? addressId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].address_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? requestId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].request_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? startTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].start_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? endTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].end_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? bookingDate(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].booking_date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateServiceImageCall {
  Future<ApiCallResponse> call({
    int? businessId,
    List<FFUploadedFile>? imagesList,
    int? serviceId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final images = imagesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Update Service Image',
      apiUrl: '$baseUrl/services/$serviceId/images',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'Images': images,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetClientRequestFullCall {
  Future<ApiCallResponse> call({
    int? requestId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Request Full',
      apiUrl: '$baseUrl/requests/client/full/$requestId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'request_id': requestId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? requestId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? requestCreatedAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? clientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.client_id''',
      ));
  List? leads(dynamic response) => getJsonField(
        response,
        r'''$.data.leads''',
        true,
      ) as List?;
  int? requestServiceId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.service_id''',
      ));
  bool? requestIsDirect(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.is_direct''',
      ));
  bool? requestClientContacted(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.client_contacted''',
      ));
  bool? requestProposalSent(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.proposal_sent''',
      ));
  bool? requestProposalAccepted(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.proposal_accepted''',
      ));
  String? requestStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.status''',
      ));
  bool? requestPaymentMade(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.payment_made''',
      ));
  bool? requestBookingMade(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.booking_made''',
      ));
  int? leadId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].id''',
      ));
  dynamic leadBusiness(dynamic response) => getJsonField(
        response,
        r'''$.data.leads[:].business''',
      );
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].business.id''',
      ));
  String? businessCreatedAt(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.created_at''',
      ));
  int? businessOwnerClientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].business.owner_client_id''',
      ));
  String? businessOwnerUserId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.owner_user''',
      ));
  String? businessName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.name''',
      ));
  String? businessCategory(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.category''',
      ));
  String? businessDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.description''',
      ));
  String? businessEmail(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.business_email''',
      ));
  String? businessUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.url''',
      ));
  int? businessPhone(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].business.phone''',
      ));
  int? businesAddressId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].business.address_id''',
      ));
  dynamic businessOpeningHours(dynamic response) => getJsonField(
        response,
        r'''$.data.leads[:].business.opening_hours''',
      );
  String? businessProfileImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.profile_image''',
      ));
  String? businessBannerImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.banner_image''',
      ));
  String? businessGoogleId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.google_business_id''',
      ));
  String? businessStripeId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].business.stripe_id''',
      ));
  bool? businessPayments(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.leads[:].business.payments''',
      ));
  bool? businessValidated(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.leads[:].business.validated''',
      ));
  List? quotes(dynamic response) => getJsonField(
        response,
        r'''$.data.leads[:].quote''',
        true,
      ) as List?;
  int? quoteId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].id''',
      ));
  String? quoteCreatedAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].created_at''',
      ));
  int? quoteLeadId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].lead_id''',
      ));
  int? quoteServiceId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].service_id''',
      ));
  String? quoteDescription(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].description''',
      ));
  String? quoteStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].status''',
      ));
  int? quoteAmountCents(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].amountCents''',
      ));
  bool? quotePaid(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.leads[:].quote[:].paid''',
      ));
}

class GetClientRequestAcceptedQuoteCall {
  Future<ApiCallResponse> call({
    int? requestId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Request Accepted Quote',
      apiUrl: '$baseUrl/quotes/accepted-quote-for-request-id/$requestId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'request_id': requestId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? quoteId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? clientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.client_id''',
      ));
  int? serviceId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.service_id''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.status''',
      ));
  bool? requestBookingMade(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.booking_made''',
      ));
  int? leadId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.lead_id''',
      ));
  String? businessCreatedAt(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.created_at''',
      ));
  int? businessOwnerClientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads.business.owner_client_id''',
      ));
  String? businessOwnerUserId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.owner_user''',
      ));
  String? businessName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.name''',
      ));
  String? businessCategory(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.category''',
      ));
  String? businessDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.description''',
      ));
  String? businessEmail(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.business_email''',
      ));
  int? businessPhone(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads.business.phone''',
      ));
  int? businesAddressId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.leads.business.address_id''',
      ));
  dynamic businessOpeningHours(dynamic response) => getJsonField(
        response,
        r'''$.data.leads.business.opening_hours''',
      );
  String? businessProfileImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.profile_image''',
      ));
  String? businessBannerImage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.banner_image''',
      ));
  String? businessGoogleId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.google_business_id''',
      ));
  String? businessStripeId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.leads.business.stripe_id''',
      ));
  bool? businessPayments(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.leads.business.payments''',
      ));
  bool? businessValidated(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.leads.business.validated''',
      ));
  int? amountCents(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.amountCents''',
      ));
  String? expiring(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.expiring''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.description''',
      ));
  bool? paid(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.paid''',
      ));
}

class GetBusinessLeadAcceptedQuoteCall {
  Future<ApiCallResponse> call({
    int? leadId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Lead Accepted Quote',
      apiUrl: '$baseUrl/quotes/accepted-quote-for-lead-id/$leadId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'lead_id': leadId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? quoteId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.created_at''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? leadId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.lead_id''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.description''',
      ));
  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.status''',
      ));
  int? amountCents(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.amountCents''',
      ));
  bool? paid(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.paid''',
      ));
  String? expiring(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.expiring''',
      ));
  dynamic serviceId(dynamic response) => getJsonField(
        response,
        r'''$.data.service_id''',
      );
}

class QuotesAcceptCall {
  Future<ApiCallResponse> call({
    int? quoteId,
    int? leadId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'QuotesAccept',
      apiUrl: '$baseUrl/quotes/accept',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'quote_id': quoteId,
        'lead_id': leadId,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PostSendMessageCall {
  Future<ApiCallResponse> call({
    int? conversationId,
    int? sender,
    int? receiver,
    String? content = 'text',
    String? contentType = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Post Send Message',
      apiUrl: '$baseUrl/messages/send',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'conversation_id': conversationId,
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'content_type': contentType,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  bool? botResponse(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.bot_response''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class CreateConversationIfNotExistsCall {
  Future<ApiCallResponse> call({
    int? client1,
    int? client2,
    bool? client1Business,
    bool? client2Business,
    bool? botActive = true,
    int? activeRequest = 0,
    int? activeLead = 0,
    String? activeThread = '',
    int? business1,
    int? business2,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Create Conversation If Not Exists',
      apiUrl: '$baseUrl/messages/conversation',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client1': client1,
        'client2': client2,
        'client1_business': client1Business,
        'client2_business': client2Business,
        'active_request': activeRequest,
        'active_lead': activeLead,
        'active_thread': activeThread,
        'bot_active': botActive,
        'business1': business1,
        'business2': business2,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  int? convoId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
}

class GetClientTransactionsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Transactions',
      apiUrl: '$baseUrl/payments/transactions/client/$clientId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'clientId': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<int>? transactionId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? sender(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].sender''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? receiver(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].receiver''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<bool>? senderBusiness(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].sender_business''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<bool>? receiverBusiness(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].receiver_business''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<int>? amountCents(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].amount_cents''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? currency(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].currency''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? category(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? stripePaymentId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].stripe_payment_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? paymentMethodId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].payment_method''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetBusinessTransactionsCall {
  Future<ApiCallResponse> call({
    int? businessId,
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Transactions',
      apiUrl: '$baseUrl/payments/transactions/business/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<int>? transactionId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? createdAt(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].created_at''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? sender(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].sender''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? receiver(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].receiver''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<bool>? senderBusiness(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].sender_business''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<bool>? receiverBusiness(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].receiver_business''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<int>? amountCents(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].amount_cents''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? currency(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].currency''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? category(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? stripePaymentId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].stripe_payment_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? paymentMethodId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].payment_method''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

class UpdateServiceCall {
  Future<ApiCallResponse> call({
    int? serviceId,
    String? name = '',
    int? priceLowCents,
    int? priceHighCents,
    int? priceCents,
    int? durationMinutes,
    String? description = '',
    List<FFUploadedFile>? imagesList,
    String? imagesToRemove = '',
    String? serviceCategory = '',
    FFUploadedFile? profileImage,
    String? resourcesList = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final images = imagesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Update Service',
      apiUrl: '$baseUrl/services/$serviceId',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'service_id': serviceId,
        'name': name,
        'price_low_cents': priceLowCents,
        'price_high_cents': priceHighCents,
        'price_cents': priceCents,
        'duration_minutes': durationMinutes,
        'description': description,
        'images': images,
        'images_to_remove': imagesToRemove,
        'service_category': serviceCategory,
        'profile_image': profileImage,
        'resources_list': resourcesList,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? detailERROR(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.detail''',
      ));
}

class UploadBusinessFilesCall {
  Future<ApiCallResponse> call({
    int? businessId,
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Upload business files',
      apiUrl: '$baseUrl/business/$businessId/upload',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UploadClientFilesCall {
  Future<ApiCallResponse> call({
    int? clientId,
    List<FFUploadedFile>? filesList,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final files = filesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Upload client files',
      apiUrl: '$baseUrl/clients/$clientId/upload',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetResourcesByBusinessIDCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get resources by business ID',
      apiUrl: '$baseUrl/resources/business/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'businessId': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].name''',
      ));
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].business_id''',
      ));
  bool? active(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data[:].active''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].created_at''',
      ));
  int? resourceId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
}

class CreateResourceCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? name = '',
    bool? active = true,
    dynamic serviceTimeJson,
    String? resourceType = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final serviceTime = _serializeJson(serviceTimeJson);

    return ApiManager.instance.makeApiCall(
      callName: 'Create Resource',
      apiUrl: '$baseUrl/resources/create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'name': name,
        'active': active,
        'service_time': serviceTime,
        'resource_type': resourceType,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.business_id''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  bool? active(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.active''',
      ));
}

class UpdateResourceCall {
  Future<ApiCallResponse> call({
    int? resourceId,
    String? name = '',
    bool? active,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Update Resource',
      apiUrl: '$baseUrl/resources/$resourceId',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'resource_id': resourceId,
        'name': name,
        'active': active,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  bool? active(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.active''',
      ));
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.business_id''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class DeleteResourceCall {
  Future<ApiCallResponse> call({
    int? resourceId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Delete Resource',
      apiUrl: '$baseUrl/resources/$resourceId',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'resource_id': resourceId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.business_id''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  bool? active(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.active''',
      ));
  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
}

class GetBusinessClientsCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Clients',
      apiUrl: '$baseUrl/business-clients/business/$businessId/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetResourcesByServiceIdCall {
  Future<ApiCallResponse> call({
    int? serviceId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get resources By Service Id',
      apiUrl: '$baseUrl/resources/service/$serviceId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'service_id': serviceId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
  List<int>? resourceId(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<bool>? active(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].active''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetOpenSlotsForResourceForDayCall {
  Future<ApiCallResponse> call({
    int? resourceId,
    String? day = '',
    int? serviceId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Open Slots For Resource For Day',
      apiUrl: '$baseUrl/bookings/resources/$resourceId/available-slots',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'resource_id': resourceId,
        'day': day,
        'service_id': serviceId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  List<String>? startTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].start_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? endTime(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].end_time''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? day(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].day''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetClientAccountsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Accounts',
      apiUrl: '$baseUrl/clients/accounts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  int? clientId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.client_id''',
      ));
  bool? isBusiness(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.data.is_business''',
      ));
  List? businesses(dynamic response) => getJsonField(
        response,
        r'''$.data.businesses''',
        true,
      ) as List?;
  int? businessId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.business_id''',
      ));
  int? businessesId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data.businesses[:].id''',
      ));
  String? businessesName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.businesses[:].name''',
      ));
  dynamic profileImage(dynamic response) => getJsonField(
        response,
        r'''$.data.businesses[:].profile_image''',
      );
}

class GetBusinessChatContactsCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Chat Contacts',
      apiUrl: '$baseUrl/messages/business/$businessId/contacts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
}

class GetClientChatContactsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Chat Contacts',
      apiUrl: '$baseUrl/messages/contacts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
}

class GetGregByBusinessIdCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Greg By Business Id',
      apiUrl: '$baseUrl/employees/greg/business/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class CreateGregCall {
  Future<ApiCallResponse> call({
    int? businessId,
    bool? active,
    String? conversationTone = 'friendly',
    List<String>? blacklistList,
    bool? notifications = true,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final blacklist = _serializeList(blacklistList);

    return ApiManager.instance.makeApiCall(
      callName: 'Create Greg',
      apiUrl: '$baseUrl/employees/greg',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'active': active,
        'conversation_tone': conversationTone,
        'blacklist': blacklist,
        'notifications': notifications,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

class UpdateGregCall {
  Future<ApiCallResponse> call({
    int? businessId,
    bool? active,
    String? conversationTone = 'friendly',
    List<String>? blacklistList,
    bool? notifications = true,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final blacklist = _serializeList(blacklistList);

    return ApiManager.instance.makeApiCall(
      callName: 'Update Greg',
      apiUrl: '$baseUrl/employees/greg/business/$businessId',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'active': active,
        'conversation_tone': conversationTone,
        'blacklist': blacklist,
        'notifications': notifications,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

class AddToGregBlacklistCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? word = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Add To Greg Blacklist',
      apiUrl: '$baseUrl/employees/greg/business/$businessId/blacklist/add',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'word': word,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic error(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
}

class RemoveToGregBlacklistCall {
  Future<ApiCallResponse> call({
    int? businessId,
    String? word = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Remove To Greg Blacklist',
      apiUrl:
          '$baseUrl/employees/greg/business/$businessId/blacklist/remove',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'business_id': businessId,
        'word': word,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}

class CreateStripeCustomerConnekCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "email": "${escapeStringForJson(email)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Stripe Customer Connek',
      apiUrl: '$baseUrl/clients/stripe-customer',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DepositCall {
  Future<ApiCallResponse> call({
    int? clientId,
    int? amountCents,
    String? category = '',
    int? businessId,
    int? paymentMethodId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "client_id": $clientId,
  "amount_cents": $amountCents,
  "category": "${escapeStringForJson(category)}",
  "business_id": $businessId,
  "payment_method_id": $paymentMethodId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Deposit',
      apiUrl: '$baseUrl/payments/deposit',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SetupPaymentMethodConnekCall {
  Future<ApiCallResponse> call({
    String? customerId = '',
    int? clientId,
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "client_id": $clientId,
  "customer_id": "${escapeStringForJson(customerId)}",
  "business_id": $businessId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Setup Payment Method Connek',
      apiUrl: '$baseUrl/payments/payment-setup',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetClientDepositsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Client Deposits',
      apiUrl: '$baseUrl/payments/deposits/client/$clientId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetBusinessDepositsCall {
  Future<ApiCallResponse> call({
    int? clientId,
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = ConnekApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Business Deposits',
      apiUrl: '$baseUrl/payments/deposits/business/$businessId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      params: {
        'client_id': clientId,
        'business_id': businessId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Connek api Group Code

/// Start Stripe Group Code

class StripeGroup {
  static String getBaseUrl({
    String? jwtToken = '',
  }) =>
      'https://api.connek.ca/api/stripe';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer [jwtToken]',
  };
  static EmployeeSubscribeCall employeeSubscribeCall = EmployeeSubscribeCall();
  static CreateStripeCustomerCall createStripeCustomerCall =
      CreateStripeCustomerCall();
  static SetupPaymentMethodCall setupPaymentMethodCall =
      SetupPaymentMethodCall();
  static SetPaymentMethodDefaultCall setPaymentMethodDefaultCall =
      SetPaymentMethodDefaultCall();
}

class EmployeeSubscribeCall {
  Future<ApiCallResponse> call({
    int? employeeId,
    int? businessId,
    String? jwtToken = '',
  }) async {
    final baseUrl = StripeGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "business_id": $businessId,
  "employee_id": $employeeId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Employee Subscribe',
      apiUrl: '$baseUrl/checkout',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? redirectUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.redirect_url''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class CreateStripeCustomerCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = StripeGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "email": "${escapeStringForJson(email)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Stripe Customer',
      apiUrl: '$baseUrl/customer',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  String? customerId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.customer.id''',
      ));
}

class SetupPaymentMethodCall {
  Future<ApiCallResponse> call({
    String? customerId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = StripeGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "customer_id": "$customerId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Setup Payment Method',
      apiUrl: '$baseUrl/payment/setup',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  String? setupUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.url''',
      ));
}

class SetPaymentMethodDefaultCall {
  Future<ApiCallResponse> call({
    String? paymentMethodId = '',
    int? clientId,
    String? jwtToken = '',
  }) async {
    final baseUrl = StripeGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "payment_method_id": "${escapeStringForJson(paymentMethodId)}",
  "client_id": $clientId
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Set Payment Method Default',
      apiUrl: '$baseUrl/payment/setup/default',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Stripe Group Code

class InfobipWhatsappCall {
  static Future<ApiCallResponse> call({
    String? to = '',
    String? message = '',
  }) async {
    final ffApiRequestBody = '''
{
  "messages": [
    {
      "from": "447860099299",
      "to": "$to",
      "messageId": "test-message-515",
      "content": {
        "text": "$message"
      },
      "callbackData": "Callback data"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'infobip Whatsapp',
      apiUrl: 'https://8gd99e.api.infobip.com/whatsapp/1/message/template',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'App 040673998d19b4f018fcb76ccbe2be9a-fc6cd336-be8d-4442-969a-36d24b690cf9',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GooglePlacesAPICall {
  static Future<ApiCallResponse> call({
    String? textQuery = '',
    String? fieldMask =
        'places.id,places.displayName,places.primaryTypeDisplayName,places.formattedAddress,places.addressComponents,places.websiteUri',
    double? latitude = 45.7937,
    double? longitude = -75.3965,
    double? radius = 500,
  }) async {
    final ffApiRequestBody = '''
{
  "textQuery": "${escapeStringForJson(textQuery)}",
  "locationBias": {
    "circle": {
      "center": {
        "latitude": $latitude,
        "longitude": $longitude
      },
      "radius": $radius
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Google Places API',
      apiUrl: 'https://places.googleapis.com/v1/places:searchText',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyAMl1mVo6Qlp_q0LQsiYtj-nlUWu-8JRao',
        'X-Goog-FieldMask': '$fieldMask',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? googleId(dynamic response) => (getJsonField(
        response,
        r'''$.places[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.places[:].displayName.text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? category(dynamic response) => getJsonField(
        response,
        r'''$.places[:].primaryTypeDisplayName''',
        true,
      ) as List?;
  static List? addressComponents(dynamic response) => getJsonField(
        response,
        r'''$.places[:].addressComponents''',
        true,
      ) as List?;
  static List<String>? formattedAddress(dynamic response) => (getJsonField(
        response,
        r'''$.places[:].formattedAddress''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? places(dynamic response) => getJsonField(
        response,
        r'''$.places''',
        true,
      ) as List?;
  static List<String>? website(dynamic response) => (getJsonField(
        response,
        r'''$.places[:].websiteUri''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? businessName(dynamic response) => getJsonField(
        response,
        r'''$.places[:].displayName''',
        true,
      ) as List?;
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
