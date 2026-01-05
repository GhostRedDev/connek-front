import 'dart:convert';
import 'dart:math' as math;

import 'package:intl/intl.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';

List<String> stringToList(String employeeFeaturesString) {
  final List<dynamic> features = json.decode(employeeFeaturesString);
  return features.map((feature) => feature.toString()).toList();
}

List<DepositsDataStruct> parseDeposits(List<dynamic> jsonList) {
  final List<DepositsDataStruct> deposits = [];

  for (final d in jsonList) {
    deposits.add(DepositsDataStruct(
      id: d['id'] ?? 0,
      createdAt:
          DateTime.tryParse(d['created_at'] ?? '') ?? DateTime(1970, 1, 1),
      amountCents: d['amount_cents'] ?? 0,
      currency: d['currency'] ?? '',
      category: d['category'] ?? '',
      paymentMethodId: d['payment_method_id'] ?? 0,
      clientId: d['client_id'] ?? 0,
      businessId: d['business_id'] ?? 0,
      stripePaymentId: d['stripe_payment_id'] ?? '',
    ));
  }

  return deposits;
}

List<String> stringToDBFormaList(List<String> text) {
  // create a function that lower cases all letters and replace spaces with underscore.
  return text
      .map((t) => t.toString().toLowerCase().replaceAll(' ', '_'))
      .toList();
}

List<String> stringToDBFormaListReverse(List<String> text) {
  // create a function that lower cases all letters and replace spaces with underscore.
  return text
      .map((t) => t
          .toString()
          .replaceAll('_', ' ')
          .split(' ')
          .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
          .join(' '))
      .toList();
}

String stringToDBFormatReverse(String text) {
  // Convertimos el string individual: "no_refund" -> "No Refund"
  if (text.isEmpty) {
    return '';
  }

  return text
      .replaceAll('_', ' ') // Cambia guiones bajos por espacios
      .split(' ') // Divide en palabras
      .map((w) =>
          w.isEmpty ? w : w[0].toUpperCase() + w.substring(1)) // Capitaliza
      .join(' '); // Une de nuevo
}

List<BusinessClientsDataStruct> parseBusinessClients(List<dynamic> jsonList) {
  final List<BusinessClientsDataStruct> businessClients = [];

  for (final bc in jsonList) {
    businessClients.add(BusinessClientsDataStruct(
        id: bc['id'] as int?,
        createdAt: DateTime.parse(bc['created_at'] as String),
        businessId: bc['business_id'] as int?,
        clientId: bc['client_id'] as int?,
        forBusinessId: bc['for_business_id'] as int?,
        name: bc['name'] as String?,
        phone: bc['phone'] as int?));
  }

  return businessClients;
}

String properGrammarToCoding(String text) {
  // take any string hello_world and replace _ with spaces and capitalize the first letter

  // Trim spaces
  var cleaned = text.trim();

  // Replace spaces with underscores
  cleaned = cleaned.replaceAll(' ', '_');

  // Lowercase everything
  cleaned = cleaned.toLowerCase();

  return cleaned;
}

dynamic emptyJson() {
// return an empty json {}
  return {};
}

String? parseDayTimeToISOString(
  String day,
  String time,
) {
  try {
    // Split day into numbers
    final parts = day.split('-'); // ["2025", "10", "28"]
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final dayNum = int.parse(parts[2]);

    // Extract hour/minute + AM/PM
    final t = time.split(' '); // ["5:00", "PM"]
    final hm = t[0].split(':'); // ["5", "00"]
    int hour = int.parse(hm[0]);
    final minute = int.parse(hm[1]);
    final isPM = t[1].toUpperCase() == 'PM';

    // Convert to 24h
    if (hour == 12) hour = 0; // 12 AM → 00
    if (isPM) hour += 12; // Add 12h for PM

    // ✅ Create LOCAL datetime directly
    final localDateTime = DateTime(year, month, dayNum, hour, minute);

    // Convert to UTC ISO string
    return localDateTime.toUtc().toIso8601String();
  } catch (_) {
    return null;
  }
}

List<BookingSlotStruct> parseBookingSlotData(List<dynamic> bookingSlotData) {
  final inputFormatter =
      DateFormat("yyyy-MM-dd hh:mm a"); // "2025-10-28 09:00 AM"
  final outputFormatter =
      DateFormat("hh:mm a"); // Keep same style but after TZ conversion

  return bookingSlotData.map((res) {
// Parse the booking slots which are in UTC to the Locale
// class BookingSlots(BaseModel):
    // start_time: str #HH:MM AM/PM
    // end_time: str #HH:MM AM/PM
// day: str #YYYY-MM-DD
//
    final day = res['day'] as String;
    final start = res['start_time'] as String;
    final end = res['end_time'] as String;

    // Parse assuming UTC → convert to Local
    final startLocal = inputFormatter.parseUtc("$day $start").toLocal();
    final endLocal = inputFormatter.parseUtc("$day $end").toLocal();
    // Format back to "HH:MM AM/PM" in local time
    final startLocalStr = outputFormatter.format(startLocal);
    final endLocalStr = outputFormatter.format(endLocal);

    return BookingSlotStruct(
      startTime: startLocalStr,
      endTime: endLocalStr,
      day: day,
    );
  }).toList();
}

String urlStorageFileVideo(
  String bucket,
  String path,
) {
  return "https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/$bucket/"
      "$path";
}

String urlStorageFileAudio(
  String bucket,
  String path,
) {
  return "https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/$bucket/"
      "$path";
}

String urlClientStorageFileCopy(
  int clientId,
  String? fileName,
) {
  return "https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/"
      "$clientId/$fileName";
}

double? midContainerHeight(double screenHeight) {
  // Take the total screenHeight and deduct -160 pixels
  return screenHeight - 200;
}

String loadServiceImage(
  int businessId,
  String? serviceId,
  String? profileImage,
) {
  return "https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/"
      "$businessId/services/$serviceId/images/$profileImage";
}

String urlStorageFile(
  String bucket,
  String path,
) {
  return "https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/$bucket/"
      "$path";
}

List<ClientBookingsFullDataStruct> parseClientBookings(
    List<dynamic> bookingsJSON) {
  return bookingsJSON.map((item) {
    final business = item['business'] as Map<String, dynamic>?;
    final address = item['addresses'] as Map<String, dynamic>?;
    final request = item['requests'] as Map<String, dynamic>?;
    final service =
        request != null ? request['services'] as Map<String, dynamic>? : null;
    final resource = item['resources'] as Map<String, dynamic>?;
    final quote = item['quote'] as Map<String, dynamic>?;

    return ClientBookingsFullDataStruct(
      id: item['id'] as int?,
      createdAt: item['created_at'] != null
          ? DateTime.parse(item['created_at'])
          : null,
      clientId: item['client_id'] as int?,
      businessId: item['business_id'] as int?,
      addressId: item['address_id'] as int?,
      requestId: item['request_id'] as int?,
      status: item['status'] as String?,
      startTimeUtc: item['start_time_utc'] != null
          ? DateTime.parse(item['start_time_utc'])
          : null,
      endTimeUtc: item['end_time_utc'] != null
          ? DateTime.parse(item['end_time_utc'])
          : null,
      resourceId: item['resource_id'] as int?,

      /// BUSINESS
      business: business == null
          ? null
          : BusinessDataStruct(
              id: business['id'] as int?,
              ownerClientId: business['owner_client_id'] as int?,
              name: business['name'] as String?,
              category: business['category'] as String?,
              description: business['description'] as String?,
              businessEmail: business['business_email'] as String?,
              url: business['url'] as String?,
              businessPhone: business['phone'] as int?,
              addressId: business['address_id'] as int?,
              openingHours: parseOpeningHours(business['opening_hours']),
              profileImage: business['profile_image'] as String?,
              bannerImage: business['banner_image'] as String?,
              googleBusinessId: business['google_business_id'] as String?,
              stripeId: business['stripe_id'] as String?,
              instagramHandle: business['instagram_handle'] as String?,
              tiktokHandle: business['tiktok_handle'] as String?,
              facebookHandle: business['facebook_handle'] as String?,
              whatsappHandle: business['whatsapp_handle'] as String?,
              payments: business['payments'] as bool?,
              validated: business['validated'] as bool?,
            ),

      /// ADDRESS
      address: address == null
          ? null
          : AddressDataStruct(
              id: address['id'] as int?,
              createdAt: address['created_at'] as String?,
              line1: address['line_1'] as String?,
              line2: address['line_2'] as String?,
              city: address['city'] as String?,
              postalCode: address['postal_code'] as String?,
              state: address['state'] as String?,
              country: address['country'] as String?,
              location: address['location'] as bool?,
              billing: address['billing'] as bool?,
            ),

      /// REQUEST + SERVICE
      requests: request == null
          ? null
          : RequestWithServiceDataStruct(
              id: request['id'] as int?,
              createdAt: request['created_at'] != null
                  ? DateTime.parse(request['created_at'])
                  : null,
              clientId: request['client_id'] as int?,
              description: request['description'] as String?,
              isDirect: request['is_direct'] as bool?,
              budgetMaxCents: request['budget_max_cents'] as int?,
              budgetMinCents: request['budget_min_cents'] as int?,
              clientContacted: request['client_contacted'] as bool?,
              proposalSent: request['proposal_sent'] as bool?,
              proposalAccepted: request['proposal_accepted'] as bool?,
              status: request['status'] as String?,
              paymentMade: request['payment_made'] as bool?,
              bookingMade: request['booking_made'] as bool?,
              serviceId: request['service_id'] as int?,
              oboBusinessId: request['obo_business_id'] as int?,
              services: service == null
                  ? null
                  : ServiceDataStruct(
                      id: service['id'] as int?,
                      businessId: service['business_id'] as int?,
                      name: service['name'] as String?,
                      priceLowCents: service['price_low_cents'] as int?,
                      priceHighCents: service['price_high_cents'] as int?,
                      priceCents: service['price_cents'] as int?,
                      durationMinutes: service['duration_minutes'] as int?,
                      description: service['description'] as String?,
                      profileImage: service['profile_image'] as String?,
                    ),
            ),

      /// RESOURCE
      resources: resource == null
          ? null
          : ResourceDataStruct(
              resourceId: resource['id'] as int?,
              createdAt: resource['created_at'] != null
                  ? DateTime.parse(resource['created_at'])
                  : null,
              serviceTime: parseOpeningHours(resource['service_time']),
              businessId: resource['business_id'] as int?,
              name: resource['name'] as String?,
              active: resource['active'] as bool?,
              resourceType: resource['resource_type'] as String?,
              profileImage: resource['profile_image'] as String?,
            ),

      /// QUOTE
      quote: quote == null
          ? null
          : QuoteDataStruct(
              id: quote['id'] as int?,
              createdAt: quote['created_at'] as String?,
              leadId: quote['lead_id'] as int?,
              serviceId: quote['service_id'] as int?,
              description: quote['description'] as String?,
              status: quote['status'] as String?,
              amountCents: quote['amountCents'] as int?,
              paid: quote['paid'] as bool?,
              expiring: quote['expiring'] as String?,
            ),
    );
  }).toList();
}

List<dynamic>? emptyJsonList() {
  // Return me an output of type List <Json >. the value must be empty
  return [];
}

List<ServiceDataStruct> parseServicesROW(
  List<ServicesRow> servicesListROW,
  int businessId,
  String businessName,
) {
  // Initialize an empty list to hold the services
  return servicesListROW.map((service) {
    return ServiceDataStruct(
        id: service.id as int?,
        createdAt: service.createdAt,
        name: service.name as String?,
        description: service.description,
        priceLowCents: service.priceLowCents,
        priceHighCents: service.priceHighCents,
        priceCents: service.priceCents as int?,
        durationMinutes: service.durationMinutes as int?,
        images: service.images,
        profileImage: service.profileImage,
        serviceCategory: service.serviceCategory,
        resources: (((jsonDecode(service.resourcesList)) as List?)
                ?.map((e) => e is int ? e : int.tryParse(e.toString()))
                .whereType<int>()
                .toList() ??
            <int>[]),
        businessId: businessId,
        businessName: businessName);
  }).toList();
}

String? dateTimeFormatting(String datetime) {
  // Take a datetime string. Format it to "MMM dd"
  final parsedDate = DateTime.parse(datetime);
  final formatter = DateFormat('MMM dd');
  return formatter.format(parsedDate);
}

String? listToString(List<String> list) {
  // i ahve a list ["a", "b"] of strings, make it to a string '["a", "b"]'
  if (list.isEmpty) return '[]';
  return jsonEncode(list);
}

String newCustomFunction(
  String description,
  String minBudget,
  String? maxBudget,
  String service,
) {
  // Create an organized text. It is a person requesting a service. Output an introduction message for the request
  return 'Hello, I am looking for your $service services. My budget is between $minBudget and ${maxBudget ?? "unlimited"}. Here is a brief description of what I need: $description. Thank you.';
}

List<ServiceDataStruct> parseServicesListFINAL(
  List<dynamic> servicesListJSON,
  int businessId,
  String businessName,
) {
// Initialize an empty list to hold the services
  return servicesListJSON.map((service) {
    return ServiceDataStruct(
        id: service['id'] as int?,
        createdAt: service['created_at'] != null
            ? DateTime.tryParse(service['created_at'])
            : null,
        name: service['name'] as String?,
        description: service['description'] as String?,
        priceLowCents: service['price_low_cents'] as int?,
        priceHighCents: service['price_high_cents'] as int?,
        priceCents: service['price_cents'] as int?,
        images: service['images'] as String?,
        profileImage: service['profile_image'] as String?,
        serviceCategory: service['service_category'] as String?,
        durationMinutes: service['duration_minutes'] as int?,
        resources: (((service['resources_list'] is String
                    ? jsonDecode(service['resources_list'])
                    : service['resources_list']) as List?)
                ?.map((e) => e is int ? e : int.tryParse(e.toString()))
                .whereType<int>()
                .toList() ??
            <int>[]),
        businessId: businessId,
        businessName: businessName);
  }).toList();
}

ServiceDataStruct parseServicesSingleFINALCopy(
  dynamic service,
  int? businessId,
  String? businessName,
) {
  // Initialize an empty list to hold the services
  return ServiceDataStruct(
      id: service['id'] as int?,
      createdAt: DateTime.parse(service['created_at']),
      name: service['name'] as String?,
      description: service['description'] as String?,
      priceLowCents: service['price_low_cents'] as int?,
      priceHighCents: service['price_high_cents'] as int?,
      priceCents: service['price_cents'] as int?,
      images: service['images'] as String?,
      profileImage: service['profile_image'] as String?,
      serviceCategory: service['service_category'] as String?,
      durationMinutes: service['duration_minutes'] as int?,
      businessId: businessId,
      businessName: businessName);
}

List<String>? newCustomFunction2(dynamic data) {
  // return the data from data with the key categories
  if (data is Map<String, dynamic> && data.containsKey('categories')) {
    final categories = data['categories'];
    if (categories is List<dynamic>) {
      return categories.map((category) => category.toString()).toList();
    }
  }
  return null;
}

List<ServiceDataStruct>? serviceData(List<dynamic>? services) {
  if (services == null || services.isEmpty) {
    return null;
  }

  return services.map((service) {
    return ServiceDataStruct(
      id: service['id'] as int?,
      name: service['name'] as String?,
      priceHighCents: service['price_high'] as int?,
      priceLowCents: service['price_low'] as int?,
      description: service['description'] as String?,
      businessId: service['business_id'] as int?,
      images:
          service['images'] as String?, // Assumed to be string from your schema
      serviceCategory: service['service_category']
          as String?, // Assumed to be string from your schema
    );
  }).toList();
}

List<SmartSearchResponsesDataStruct>? questionsResponseListData(
  List<String> questions,
  List<String> responses,
) {
  // Use the lists questions and response and return the datatype
  if (questions.length != responses.length) {
    return null;
  }

  List<SmartSearchResponsesDataStruct> dataList = [];

  for (int i = 0; i < questions.length; i++) {
    SmartSearchResponsesDataStruct data = SmartSearchResponsesDataStruct(
      question: questions[i],
      response: responses[i],
    );
    dataList.add(data);
  }

  return dataList;
}

String mapJsonStringSSSubmit(
  List<String>? array1,
  List<String> array2,
) {
  // return a json string [{question: array1 item, response: array2 item}, ...]
  List<Map<String, String>> jsonList = [];
  for (int i = 0; i < math.min(array1?.length ?? 0, array2.length); i++) {
    jsonList.add({
      'question': array1?[i] ?? '',
      'response': array2[i],
    });
  }
  return jsonEncode(jsonList);
}

AddressDataStruct parseGPlacesAPIOnePlace(dynamic query) {
  // Initialize components
  String line1 = '';
  String line2 = '';
  String city = '';
  String postalCode = '';
  String state = '';
  String country = '';

  // Parse address components
  List<dynamic> addressComponents = query['addressComponents'] ?? [];
  for (var component in addressComponents) {
    List<String> types = List<String>.from(component['types'] ?? []);
    String longText = component['longText'] ?? '';

    if (types.contains('street_number')) {
      line1 += '$longText ';
    } else if (types.contains('route')) {
      line1 += longText;
    } else if (types.contains('subpremise')) {
      line2 = longText;
    } else if (types.contains('locality')) {
      city = longText;
    } else if (types.contains('administrative_area_level_1')) {
      state = longText;
    } else if (types.contains('country')) {
      country = longText;
    } else if (types.contains('postal_code')) {
      postalCode = longText;
    }
  }

  // Create AddressDataStruct with parsed data
  AddressDataStruct addressDataStruct = AddressDataStruct(
    line1: line1.trim(),
    line2: line2,
    city: city,
    postalCode: postalCode,
    state: state,
    country: country,
  );

  return addressDataStruct;
}

List<ServiceDataStruct> parseServices(
  List<dynamic> searchResults,
  int? filterYoursOutClientId,
) {
  // Initialize an empty list to hold the services
  List<ServiceDataStruct> allServices = [];

  // Iterate through each business in searchResults
  for (var business in searchResults) {
    // Skip if this business is owned by the filtered-out client
    final ownerClientId = business['owner_client_id'] as int?;
    if (filterYoursOutClientId != null &&
        ownerClientId == filterYoursOutClientId) {
      continue; // Skip this business entirely
    }

    // Extract business ID and business name
    final businessId = business['id'] as int?;
    final businessName = business['name'] as String?;

    // Check if the "services" field exists and is a list
    if (business['services'] != null) {
      final services = business['services'] as List<dynamic>;

      // Map each service to a ServiceDataStruct and add to the list
      allServices.addAll(
        services.map(
          (service) => ServiceDataStruct(
            id: service['id'] as int?,
            name: service['name'] as String?,
            priceLowCents: service['price_low_cents'] as int?,
            priceHighCents: service['price_high_cents'] as int?,
            description: service['description'] as String?,
            profileImage: service['profile_image'] as String?,
            serviceCategory: service['service_category'] as String?,
            resources: (((service['resources_list'] is String
                        ? jsonDecode(service['resources_list'])
                        : service['resources_list']) as List?)
                    ?.map((e) => e is int ? e : int.tryParse(e.toString()))
                    .whereType<int>()
                    .toList() ??
                <int>[]),
            businessId: businessId,
            businessName: businessName,
          ),
        ),
      );
    }
  }

  return allServices;
}

List<bool> requestSteps(
  bool requestReceived,
  bool proposalSent,
  bool bookingMade,
  bool paymentMade,
  bool serviceDelivered,
  bool proposalAccepted,
) {
  // Each stage is only valid if all previous stages are true.
  final stage1 = requestReceived;
  final stage2 = stage1 && proposalSent;
  final stage3 = stage2 && proposalAccepted;
  final stage4 = stage3 && bookingMade;
  final stage5 = stage4 && paymentMade;

  return [stage1, stage2, stage3, stage4, stage5];
}

List<ClientContactStruct>? contactsParseToClientStruct(
    List<dynamic> contactsData) {
  return contactsData
      .where((item) => item['contact_is_business'] != true)
      .map((item) {
    final contact = item['contact'];
    return ClientContactStruct(
        conversationId: item['id'],
        clientId: contact['id'] as int,
        firstName: contact['first_name'] ?? '',
        lastName: contact['last_name'] ?? '',
        photoId: contact['photo_id'] ?? '',
        isBusiness: false);
  }).toList();
}

List<int> requestsSteps(ClientRequestStruct request) {
  // if argumnet.bookingMade is true, return [0,1] otherwise return [0]
  List<int> output = [0];

  if (request.proposalSent) {
    output.add(1);
  }

  if (request.proposalAccepted) {
    output.add(2);
  }

  if (request.bookingMade) {
    output.add(3);
  }

  if (request.paymentMade) {
    output.add(4);
  }

  if (request.status == 'completed') {
    output.add(5);
  }

  return output;
}

int? conversationExists(
  List<dynamic>? contactsData,
  int? businessId,
) {
  if (contactsData == null || contactsData.isEmpty) {
    return null; // Return null if the input is empty or null
  }

  // Filter contacts where contact_is_business is true
  final filteredContacts = contactsData
      .where((item) => item['contact_is_business'] == true)
      .toList();

  // If no contacts with contact_is_business = true, return null
  if (filteredContacts.isEmpty) {
    return null;
  }

  // Check only the first business in the business list for each filtered contact
  for (var item in filteredContacts) {
    final businesses = item['contact']['business'] as List<dynamic>?;
    if (businesses != null && businesses.isNotEmpty) {
      final firstBusiness = businesses.first;
      if (firstBusiness['id'] == businessId) {
        return item['id'] as int; // Return the contact's 'id' if match found
      }
    }
  }

  return null; // No match found
}

bool filterEmployeesNotHired(
  EmployeesStruct employee,
  List<ChatbotDataStruct> chatbotData,
) {
  // Check if employee.id is inside any item of chatbotData property employee_id. If it is, return false, else return true
  for (var data in chatbotData) {
    if (data.employeeId == employee.id) {
      return false;
    }
  }
  return true;
}

List<String> parseGregInstructions(
  String? instructionsString,
  bool formFields,
  bool additionalInstr,
) {
  // The argument is a json string like this.  {  "instruction": "",  "businessInformation": {},  "task": "",  "formFields": [    "ask age"  ],  "afterFormTask": "",  "additionalInstructions": [    "be nice"  ]} Parse it and return me the formfields if formfields arg is true, return me additionalinstrucitons field if additionalinstr is true. Return the type List<String>
  if (instructionsString == null) {
    return [];
  }

  final Map<String, dynamic> instructions = json.decode(instructionsString);

  List<String> result = [];

  if (formFields && instructions.containsKey('formFields')) {
    result.addAll(List<String>.from(instructions['formFields']));
  }

  if (additionalInstr && instructions.containsKey('additionalInstructions')) {
    result.addAll(List<String>.from(instructions['additionalInstructions']));
  }

  return result;
}

List<AddressDataStruct> parseGPlacesAPI(List<dynamic> query) {
  // Loop thru query and fill out addressdatastruct
  List<AddressDataStruct> addressDataStructList = [];

  for (var item in query) {
    // Extract basic fields
    //String name = item['name'];
    //String address = item['formattedAddress'];
    //double latitude = item['geometry']['location']['lat'];
    //double longitude = item['geometry']['location']['lng'];

    // Initialize components
    String line1 = '';
    String line2 = '';
    String city = '';
    String postalCode = '';
    String state = '';
    String country = '';

    // Parse address components
    List<dynamic> addressComponents = item['addressComponents'] ?? [];
    for (var component in addressComponents) {
      List<String> types = List<String>.from(component['types'] ?? []);
      String longText = component['longText'] ?? '';

      if (types.contains('street_number')) {
        line1 += '$longText ';
      } else if (types.contains('route')) {
        line1 += longText;
      } else if (types.contains('subpremise')) {
        line2 = longText;
      } else if (types.contains('locality')) {
        city = longText;
      } else if (types.contains('administrative_area_level_1')) {
        state = longText;
      } else if (types.contains('country')) {
        country = longText;
      } else if (types.contains('postal_code')) {
        postalCode = longText;
      }
    }

    // Create AddressDataStruct with parsed data
    AddressDataStruct addressDataStruct = AddressDataStruct(
      line1: line1.trim(),
      line2: line2,
      city: city,
      postalCode: postalCode,
      state: state,
      country: country,
    );

    addressDataStructList.add(addressDataStruct);
  }

  return addressDataStructList;
}

List<String> extractSupabaseColAsList(
  List<BusinessCategoryRow> rows,
  String colName,
) {
  // Loop throught the rows and make a list of strings of the column "code"
  List<String> col = [];
  // for (var row in rows) {
  // col.add(row[colName]);
  //}
  return col;
}

List<dynamic> addedServiceInCreateBusiness(AddedServiceStruct? services) {
  // Take a data structure and make a JSON list. The only element in the list is the JSON version of the data structure. The data structure is not a list.
  if (services == null) {
    return [];
  }

  // Create a Map<String, dynamic> to represent the data structure
  Map<String, dynamic> data = {
    'name': services.name,
    'description': services.description,
    'priceLowCents': services.priceLowCents,
    'priceHighCents': services.priceHighCents,
    'priceCents': services.priceCents,
    'category': services.category,
    'profileImage': services.profileImage,
  };

  // Return a list containing the JSON object
  return [data];
}

bool? isEmptyList(List<String> lista) {
  // Check if a list is empty. if yes, return true
  return lista.isEmpty;
}

bool? isAllEmployeesHired(List<EmployeesStruct> lista) {
  // check if a list is empty.If yes, return true
  if (lista.isEmpty) {
    return true;
  }
  return false;
}

DateTime? createDatetimeFromString(
  String? year,
  String? month,
  String? day,
) {
  // return datetime from year, day and month
  if (year != null && month != null && day != null) {
    try {
      int yearInt = int.parse(year);
      int monthInt = int.parse(month);
      int dayInt = int.parse(day);
      return DateTime(yearInt, monthInt, dayInt);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  } else {
    return null;
  }
}

int? phoneStringToInteger(String? phoneString) {
  // Transform this (999) 999-9999 to this 9999999999.
  if (phoneString == null) {
    return null;
  }

  String numericString = phoneString.replaceAll(RegExp(r'[^\d]'), '');
  return int.tryParse(numericString);
}

List<BusinessLeadsStruct> emptyLeadsList() {
  // Return an empty list of the type businessLeads
  return <BusinessLeadsStruct>[];
}

String? datetimeFormatFull(String? dateString) {
  // I have a date string (idk what format it is so keep that inn mind) that I want to convert to this format "Dec 10,2024 - 7:00 PM"
  if (dateString == null) {
    return null;
  }

  try {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMM d, yyyy - h:mm a').format(date);
    return formattedDate;
  } catch (e) {
    print('Error formatting date: $e');
    return null;
  }
}

String? minMaxBudgetString(
  int? minBudgetCents,
  int? maxBudgetCents,
) {
  // If both are null, return "No prices available"
  if (minBudgetCents == null && maxBudgetCents == null) {
    return "No prices available";
  }

  // Convert cents to dollars
  String? minBudget =
      minBudgetCents != null ? (minBudgetCents / 100).toStringAsFixed(2) : null;
  String? maxBudget =
      maxBudgetCents != null ? (maxBudgetCents / 100).toStringAsFixed(2) : null;

  // Write a function that takes a min and a max, write them like this $min - $max. Check if either of them is available, then return "No prices available". If only one of them is not null, only return the only one that is a number.
  if (minBudget == null && maxBudget == null) {
    return "No prices available";
  } else if (minBudget != null && maxBudget == null) {
    return "\$$minBudget";
  } else if (minBudget == null && maxBudget != null) {
    return "\$$maxBudget";
  } else {
    return "\$$minBudget - \$$maxBudget";
  }
}

List<int> leadsSteps(BusinessLeadsStruct lead) {
  // if argumnet.bookingMade is true, return [0,1] otherwise return [0]
  List<int> output = [0];

  //if (lead.clientContacted) {
  //  output.add(1);
  //}

  if (lead.proposalSent) {
    output.add(1);
  }

  if (lead.proposalAccepted) {
    output.add(2);
  }

  if (lead.bookingMade) {
    output.add(3);
  }

  return output;
}

List<AddressDataStruct> wrapAddressInList(AddressDataStruct? addressData) {
  return addressData != null ? [addressData] : [];
}

List<BusinessDataStruct> parseBusinessResults(
  List<dynamic> results,
  int? filterYoursOutClientId,
) {
  return results
      .map((business) {
        final ownerClientId = business['owner_client_id'] as int;
        if (filterYoursOutClientId != null &&
            ownerClientId == filterYoursOutClientId) {
          return null; // Will be removed later
        }

        // Extract single address object (not a list)
        final address = business['addresses'] as Map<String, dynamic>?;

        return BusinessDataStruct(
          id: business['id'] as int?,
          ownerClientId: business['owner_client_id'] as int?,
          name: business['name'] as String?,
          category: business['category'] as String?,
          description: business['description'] as String?,
          businessEmail: business['business_email'] as String?,
          url: business['url'] as String?,
          addressId: business['address_id'] as int?,
          profileImage: business['profile_image'] as String?,
          bannerImage: business['banner_image'] as String?,
          googleBusinessId: business['google_business_id'] as String?,
          stripeId: business['stripe_id'] as String?,
          payments: business['payments'] as bool?,
          validated: business['validated'] as bool?,
          businessPhone: business['phone'] as int?,
          instagramHandle: business['instagram_handle'] as String?,
          tiktokHandle: business['tiktok_handle'] as String?,
          facebookHandle: business['facebook_handle'] as String?,
          whatsappHandle: business['whatsapp_handle'] as String?,
          images: business['images'] as String?,
          stripeCustomerId: business['customer_id'] as String?,

          // Parse services list (handles nullable case)
          services: (business['services'] as List<dynamic>?)
                  ?.map((service) => ServiceDataStruct(
                      id: service['id'] as int?,
                      name: service['name'] as String?,
                      priceLowCents: service['price_low'] as int?,
                      priceHighCents: service['price_high'] as int?,
                      description: service['description'] as String?,
                      profileImage: service['profile_image'] as String?,
                      serviceCategory: service['service_category'] as String?,
                      businessId: service['business_id'] as int?,
                      businessName: business['name'] as String?,
                      images: service['images'] as String?))
                  .toList() ??
              [],

          // Wrap the single address object inside a list
          addresses: address != null
              ? [
                  AddressDataStruct(
                    id: address['id'] as int?,
                    line1: address['line_1'] as String?,
                    line2: address['line_2'] as String?,
                    city: address['city'] as String?,
                    postalCode: address['postal_code'] as String?,
                    state: address['state'] as String?,
                    country: address['country'] as String?,
                    location: address['location'] as bool?,
                    billing: address['billing'] as bool?,
                  )
                ]
              : [], // If address is null, return an empty list
        );
      }) //.toList();
      .whereType<BusinessDataStruct>()
      .toList();
}

String loadServiceProfileImage(
  int businessId,
  String? serviceId,
  String? fileName,
) {
  return "https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/"
      "$businessId/services/$serviceId/$fileName";
}

List<bool> leadSteps(
  bool requestReceived,
  bool clientContacted,
  bool proposalSent,
  bool bookingMade,
  bool paymentMade,
  bool serviceDelivered,
) {
  // Each stage is only valid if all previous stages are true.
  final stage1 = requestReceived;
  //final stage2 = stage1 && clientContacted;
  final stage2 = stage1 && proposalSent;
  final stage3 = stage2 && bookingMade;
  final stage4 = stage3 && paymentMade;
  final stage5 = stage4 && serviceDelivered;

  return [stage1, stage2, stage3, stage4, stage5];
}

String getImageNameFromURL(String url) {
  // the url ends with xx/xx/xx/images/FILENAME. Return me only the filename
  final List<String> parts = url.split('/');
  return parts.last;
}

DateTime expiringTime(
  int year,
  int month,
  int day,
) {
  // Take year, month, day and return a "timestampz" with the hour set to 11:59pm est time
  // To complete the `expiringTime` function that takes a year, month, and day and returns a timestamp with the hour set to 11:59 PM EST, you can use the following code:

  // Create a DateTime object for the specified date at 11:59 PM
  DateTime dateTime = DateTime(year, month, day, 23, 59);
  // Convert to EST (Eastern Standard Time)
  // EST is UTC-5, but during Daylight Saving Time (EDT), it is UTC-4.
  // Here we assume that we want to convert to EST without considering DST.
  // If you need to consider DST, you might want to use a package like 'timezone'.
  return dateTime.toUtc().subtract(const Duration(hours: 5));
}

ClientDataProfileStruct parseClientProfile(ClientRow clientQuery) {
  return ClientDataProfileStruct(
    clientId: clientQuery.id,
    firstName: clientQuery.firstName,
    lastName: clientQuery.lastName,
    email: clientQuery.email,
    phone: clientQuery.phone,
    hasBusiness: clientQuery.hasBusiness,
    stripeId: clientQuery.stripeId,
    dob: clientQuery.dob,
    aboutMe: clientQuery.aboutMe,
    profileUrl: clientQuery.profileUrl,
    images: clientQuery.images,
    bannerUrl: clientQuery.bannerUrl,
  );
}

String? parseDateElement(
  DateTime date,
  DateElements? parseWhat,
) {
  switch (parseWhat) {
    case DateElements.year:
      return date.year.toString();
    case DateElements.month:
      return date.month.toString().padLeft(2, '0');
    case DateElements.day:
      return date.day.toString().padLeft(2, '0');
    default:
      return '';
  }
}

double centsStringToDollars(String cents) {
  int totalCents = int.tryParse(cents) ?? 0;
  double dollars = totalCents / 100;
  return double.parse(dollars.toStringAsFixed(2));
}

int dollarsStringToCents(String dollars) {
  // Remove any whitespace and dollar sign
  String sanitizedDollars = dollars.trim().replaceAll('\$', '');

  // Parse the string to a double
  double dollarAmount = double.parse(sanitizedDollars);

  // Convert to cents and round to the nearest integer
  return (dollarAmount * 100).round();
}

DateTime? bookingCreateTimestamp(
  String startTime,
  DateTime day,
) {
  final timeFormat = DateFormat.jm(); // parses "09:00 am"
  final parsedTime = timeFormat.parse(startTime);

  return DateTime(
    day.year,
    day.month,
    day.day,
    parsedTime.hour,
    parsedTime.minute,
  );
}

List<ClientPaymentsStruct> parseClientPayments(
    List<TransactionsRow> transactionsQuery) {
  return transactionsQuery.map((payment) {
    return ClientPaymentsStruct(
      //clientId: payment.clientId,
      amountCents: payment.amountCents,
      createdAt: payment.createdAt,
    );
  }).toList();
}

List<ClientPaymentMethodsStruct> parseClientPaymentMethods(
    List<PaymentMethodsRow> methodsQuery) {
  return methodsQuery.map((paymentMethod) {
    return ClientPaymentMethodsStruct(
        id: paymentMethod.id,
        paymentMethodId: paymentMethod.paymentMethodId,
        clientId: paymentMethod.clientId,
        businessId: paymentMethod.businessId ?? 0,
        brand: paymentMethod.brand,
        expMonth: paymentMethod.expMonth,
        expYear: paymentMethod.expYear,
        last4: paymentMethod.last4,
        defaultMethod: paymentMethod.defaultMethod);
  }).toList();
}

CheckoutTotalsStruct calculateCheckoutTotals(int amountCents) {
  double subtotal = amountCents / 100; // Convert to dollars
  double tps = subtotal * 0.05;
  double tvq = subtotal * 0.0875;
  double connekFee = 3.00;
  double total = subtotal + tps + tvq + connekFee;

  return CheckoutTotalsStruct(
    subtotal: subtotal,
    tps: tps,
    tvq: tvq,
    connekFee: connekFee,
    total: total,
  );
}

String parseFilenameFromURL(String fileUrl) {
  // parse a url to get the filename. that is /filename.jpg. return the full fiel name with the extension

  Uri uri = Uri.parse(fileUrl);
  return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
}

ServiceDataStruct parseServicesSingleFINAL(
  dynamic service,
  int? businessId,
  String? businessName,
) {
  // Initialize an empty list to hold the services
  return ServiceDataStruct(
      id: service['id'] as int?,
      createdAt: DateTime.parse(service['created_at']),
      name: service['name'] as String?,
      description: service['description'] as String?,
      priceLowCents: service['price_low_cents'] as int?,
      priceHighCents: service['price_high_cents'] as int?,
      priceCents: service['price_cents'] as int?,
      images: service['images'] as String?,
      profileImage: service['profile_image'] as String?,
      serviceCategory: service['service_category'] as String?,
      durationMinutes: service['duration_minutes'] as int?,
      businessId: businessId,
      businessName: businessName);
}

GregDataStruct parseGregData(dynamic greg) {
  return GregDataStruct(
    gregId: greg['id'] ?? 0,
    businessId: greg['business_id'] ?? 0,
    active: greg['active'] ?? false,
    conversationTone: greg['conversation_tone'] ?? '',
    // blacklist: list of strings blacklist:
    blacklist: (greg['blacklist'] is List)
        ? List<String>.from(greg['blacklist'])
        : <String>[],
    notifications: greg['notifications'] ?? false,
    cancellations: greg['cancellations'],
    cancellationMotive: greg['cancellation_motive'],
    escalationTimeMinutes: greg['escalation_time_minutes'],
    allowRescheduling: greg['allow_rescheduling'] ?? false,
    acceptedPaymentMethods: (greg['accepted_payment_methods'] is List)
        ? List<String>.from(greg['accepted_payment_methods'])
        : <String>[],
    refundPolicy: greg['refund_policy'],
    refundPolicyDetails: greg['refund_policy_details'],
    paymentPolicy: greg['payment_policy'],
    procedures: (greg['procedures'] is List)
        ? List<String>.from(greg['procedures'])
        : <String>[],
    proceduresDetails: greg['procedures_details'] ?? "",
    postBookingProcedures: greg['post_booking_procedures'] ?? "",
    saveInformation: greg['save_information'],
    askForConsent: greg['ask_for_consent'] ?? false,
    privacyPolicy: greg['privacy_policy'],
    informationNotToShare: greg['information_not_to_share'],
    excludedPhones: (greg['excluded_phones'] is List)
        ? (greg['excluded_phones'] as List)
            .map((e) => ContactStructStruct(
                  name: e['name'] ?? '',
                  phone: e['phone']?.toString() ?? '',
                ))
            .toList()
        : <ContactStructStruct>[],
    customPolicies: (greg['custom_policies'] is List)
        ? (greg['custom_policies'] as List)
            .map((e) => GregPoliciesStruct(
                  name: e['name'] ?? '',
                  description: e['description'] ?? '',
                ))
            .toList()
        : <GregPoliciesStruct>[],
    library: (greg['library'] is List)
        ? (greg['library'] as List)
            .map((e) => LibraryFileStruct(
                  name: e['name'] ?? '',
                  filename: e['filename'] ?? '',
                ))
            .toList()
        : <LibraryFileStruct>[],
  );
}

String printPhoneNumber(int phoneNumber) {
  if (phoneNumber == 0) {
    return '0';
  }

  String phoneString = phoneNumber.toString().padLeft(10, '0');

  if (phoneString.length != 10) {
    return 'Invalid';
  }

  return '(${phoneString.substring(0, 3)}) ${phoneString.substring(3, 6)}-${phoneString.substring(6)}';
}

List<ClientRequestStruct> parseClientRequests(List<RequestsRow> requests) {
  return requests.map((request) {
    return ClientRequestStruct(
        id: request.id,
        createdAt: request.createdAt,
        clientId: request.clientId,
        description: request.description,
        isDirect: request.isDirect,
        budgetMinCents: request.budgetMinCents,
        budgetMaxCents: request.budgetMaxCents,
        clientContacted: request.clientContacted,
        proposalSent: request.proposalSent,
        proposalAccepted: request.proposalAccepted,
        status: request.status,
        paymentMade: request.paymentMade,
        bookingMade: request.bookingMade,
        serviceId: request.serviceId,
        oboBusinessId: request.oboBusinessId);
  }).toList();
}

String filenameImageOrVideo(String filename) {
  // Convert filename to lowercase to ensure case-insensitive matching
  final lowerFilename = filename.toLowerCase();

  // List of common video file extensions
  const videoExtensions = [
    '.mp4',
    '.avi',
    '.mov',
    '.mkv',
    '.3gp',
    '.wmv',
    '.flv'
  ];

  // Check if filename ends with any of the video extensions
  for (final ext in videoExtensions) {
    if (lowerFilename.endsWith(ext)) {
      return "video";
    }
  }

  // If no video extension is found, assume it's an image
  return "image";
}

List<ContactDataStruct> parseConversations(List<dynamic> data) {
  return data.map<ContactDataStruct>((item) {
    final you = item['you'] ?? {};
    final contact = item['contact'] ?? {};
    final lastMessage = item['last_message'] ?? {};

    return ContactDataStruct(
      id: item['id'] ?? 0,
      you: YouContactStruct(
        clientId: you['client_id'] ?? 0,
        businessId: you['business_id'] ?? 0,
        isBusiness: you['is_business'] ?? false,
      ),
      contact: ContactStruct(
        clientId: contact['client_id'] ?? 0,
        businessId: contact['business_id'] ?? 0,
        isBusiness: contact['is_business'] ?? false,
        name: contact['name'] ?? '',
        photoId: contact['photo_id'] ?? '',
      ),
      lastMessage: MessageDataStruct(
        content: lastMessage['content'] ?? '',
        contentType: lastMessage['content_type'] ?? '',
        sender: lastMessage['sender'] ?? 0,
        receiver: lastMessage['receiver'] ?? 0,
        senderClient: lastMessage['sender_client'] ?? false,
        senderBot: lastMessage['sender_bot'] ?? false,
        createdAt: DateTime.tryParse(lastMessage['created_at'] ?? '') ??
            DateTime(1970, 1, 1),
      ),
    );
  }).toList();
}

String printHello() {
  return 'hello';
}

String? dateTimeToString(DateTime bookindDaySelected) {
  return "${bookindDaySelected.year.toString().padLeft(4, '0')}"
      "-${bookindDaySelected.month.toString().padLeft(2, '0')}"
      "-${bookindDaySelected.day.toString().padLeft(2, '0')}";
}

ClientRequestFullDataStruct? parseClientRequestFull(
    dynamic clientRequestFullJSON) {
  if (clientRequestFullJSON == null) return null;

  return ClientRequestFullDataStruct(
    id: clientRequestFullJSON['id'],
    createdAt: clientRequestFullJSON['created_at'],
    clientId: clientRequestFullJSON['client_id'],
    description: clientRequestFullJSON['description'],
    isDirect: clientRequestFullJSON['is_direct'] ?? false,
    budgetMaxCents: clientRequestFullJSON['budget_max_cents'],
    budgetMinCents: clientRequestFullJSON['budget_min_cents'],
    clientContacted: clientRequestFullJSON['client_contacted'] ?? false,
    proposalSent: clientRequestFullJSON['proposal_sent'] ?? false,
    proposalAccepted: clientRequestFullJSON['proposal_accepted'] ?? false,
    status: clientRequestFullJSON['status'],
    paymentMade: clientRequestFullJSON['payment_made'] ?? false,
    bookingMade: clientRequestFullJSON['booking_made'] ?? false,
    serviceId: clientRequestFullJSON['service_id'],
    oboBusinessId: clientRequestFullJSON['obo_business_id'],
    leads: (clientRequestFullJSON['leads'] as List<dynamic>?)
            ?.map((leadJson) => ClientRequestLeadDataStruct(
                  id: leadJson['id'],
                  business: BusinessDataStruct(
                    id: leadJson['business']['id'],
                    ownerClientId: leadJson['business']['owner_client_id'],
                    name: leadJson['business']['name'],
                    category: leadJson['business']['category'],
                    description: leadJson['business']['description'],
                    businessEmail: leadJson['business']['business_email'],
                    url: leadJson['business']['url'],
                    businessPhone: leadJson['business']['phone'],
                    addressId: leadJson['business']['address_id'],
                    openingHours: parseOpeningHours(
                        leadJson['business']['opening_hours']),
                    profileImage: leadJson['business']['profile_image'],
                    bannerImage: leadJson['business']['banner_image'],
                    googleBusinessId: leadJson['business']
                        ['google_business_id'],
                    stripeId: leadJson['business']['stripe_id'],
                    instagramHandle: leadJson['business']['instagram_handle'],
                    tiktokHandle: leadJson['business']['tiktok_handle'],
                    facebookHandle: leadJson['business']['facebook_handle'],
                    whatsappHandle: leadJson['business']['whatsapp_handle'],
                    payments: leadJson['business']['payments'] ?? false,
                    validated: leadJson['business']['validated'] ?? false,
                  ),
                  quote: (leadJson['quote'] as List<dynamic>?)
                          ?.map((quoteJson) => QuoteDataStruct(
                                id: quoteJson['id'],
                                createdAt: quoteJson['created_at'],
                                leadId: quoteJson['lead_id'],
                                serviceId: quoteJson['service_id'],
                                description: quoteJson['description'],
                                status: quoteJson['status'],
                                amountCents: quoteJson['amountCents'],
                                paid: quoteJson['paid'] ?? false,
                                expiring: quoteJson['expiring'],
                              ))
                          .toList() ??
                      [],
                ))
            .toList() ??
        [],
  );
}

BusinessOpeningHoursStruct? parseOpeningHours(dynamic businessHoursDataJSON) {
  if (businessHoursDataJSON == null) return null;
  if (businessHoursDataJSON is! Map) return null;

  final map = businessHoursDataJSON;

  String s(String key) => map[key]?.toString() ?? '';

  return BusinessOpeningHoursStruct(
    monday: s('monday'),
    tuesday: s('tuesday'),
    wednesday: s('wednesday'),
    thursday: s('thursday'),
    friday: s('friday'),
    saturday: s('saturday'),
    sunday: s('sunday'),
  );
}

QuoteFullDataStruct? parseQuotesFull(dynamic quoteJSON) {
  if (quoteJSON == null || quoteJSON is! Map) return null;
  final map = quoteJSON;

  // Nested maps (null-safe)
  final leads = map['leads'] as Map? ?? const {};
  final business = leads['business'] as Map? ?? const {};
  final opening = business['opening_hours'] as Map? ?? const {};
  final service = map['services'] as Map?; // may be null

  // Default Opening Hours when missing
  final defaultOpening = BusinessOpeningHoursStruct(
    monday: '',
    tuesday: '',
    wednesday: '',
    thursday: '',
    friday: '',
    saturday: '',
    sunday: '',
  );

  return QuoteFullDataStruct(
    // quoteFullData (note: createdAt/expiring are String in your schema)
    quoteId: map['id'] ?? 0,
    createdAt: map['created_at']?.toString() ?? '',
    leadId: map['lead_id'] ?? 0,
    serviceId: map['service_id'] ?? 0,
    description: map['description']?.toString() ?? '',
    status: map['status']?.toString() ?? '',
    amountCents: map['amountCents'] ?? 0,
    paid: map['paid'] ?? false,
    expiring: map['expiring']?.toString() ?? '',

    // clientRequestLeadDataNoQuote
    lead: ClientRequestLeadDataNoQuoteStruct(
      leadId: leads['id'] ?? 0,
      business: BusinessDataStruct(
        id: business['id'] ?? 0,
        ownerClientId: business['owner_client_id'] ?? 0,
        name: business['name']?.toString() ?? '',
        category: business['category']?.toString() ?? '',
        description: business['description']?.toString() ?? '',
        businessEmail: business['business_email']?.toString() ?? '',
        url: business['url']?.toString() ?? '',
        businessPhone: business['phone'] ?? 0, // your schema shows Integer
        addressId: business['address_id'] ?? 0,
        openingHours: parseOpeningHours(opening) ?? defaultOpening,
        profileImage: business['profile_image']?.toString() ?? '',
        bannerImage: business['banner_image']?.toString() ?? '',
        googleBusinessId: business['google_business_id']?.toString() ?? '',
        stripeId: business['stripe_id']?.toString() ?? '',
        instagramHandle: business['instagram_handle']?.toString() ?? '',
        tiktokHandle: business['tiktok_handle']?.toString() ?? '',
        facebookHandle: business['facebook_handle']?.toString() ?? '',
        whatsappHandle: business['whatsapp_handle']?.toString() ?? '',
        payments: business['payments'] ?? false,
        validated: business['validated'] ?? false,
        // If you added more fields (services, addresses, images) in your struct, give them defaults here:
        // services: const [],
        // addresses: const [],
        // images: business['images']?.toString() ?? '',
      ),
    ),

    // serviceData (default empty struct if services is null)
    service: service != null
        ? parseServicesSingleFINAL(
            service,
            (business['id'] is int) ? business['id'] as int : 0,
            business['name']?.toString() ?? '',
          )
        : ServiceDataStruct(
            id: 0,
            createdAt: DateTime.fromMillisecondsSinceEpoch(0),
            name: '',
            description: '',
            priceLowCents: 0,
            priceHighCents: 0,
            priceCents: 0,
            durationMinutes: 0,
            images: '',
            profileImage: '',
            serviceCategory: '',
            businessId: (business['id'] is int) ? business['id'] as int : 0,
            businessName: business['name']?.toString() ?? '',
          ),
  );
}

List<TransactionsDataStruct> parseTransactions(
    List<dynamic> transactionsJSONList) {
  final List<TransactionsDataStruct> transactions = [];

  for (final tx in transactionsJSONList) {
    transactions.add(TransactionsDataStruct(
        id: tx['id'] as int?,
        createdAt: DateTime.tryParse(tx['created_at']?.toString() ?? '') ??
            DateTime(1970, 1, 1),
        sender: tx['sender'] as int?,
        receiver: tx['receiver'] as int?,
        senderBusiness: tx['sender_business'] as int?,
        receiverBusiness: tx['receiver_business'] as int?,
        amountCents: tx['amount_cents'] as int?,
        currency: tx['currency'] as String?,
        category: tx['category'] as String?,
        stripePaymentId: tx['stripe_payment_id'] as String?,
        paymentMethodId: tx['payment_method'] as int?,
        description: tx['description'] as String?,
        title: tx['title'] as String?));
  }

  return transactions;
}

String phoneDigitToString(int phoneDigits) {
  final clean = phoneDigits.toString();
  if (clean.length != 10) return clean;

  final area = clean.substring(0, 3);
  final mid = clean.substring(3, 6);
  final last = clean.substring(6, 10);

  return '($area)-$mid-$last';
}

int? phoneStringToDigit(String phoneString) {
  final digits = phoneString.replaceAll(RegExp(r'[^0-9]'), '');

  if (digits.isEmpty) return null;

  return int.tryParse(digits);
}

String? isoToYyyyMmDd(String? iso) {
  if (iso == null || iso.isEmpty) return null;

  try {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return null;

    return '${dt.year.toString().padLeft(4, '0')}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')}';
  } catch (e) {
    print('Error parsing ISO date: $e');
    return null;
  }
}

List<BusinessBookingsFullDataStruct> parseBusinessBookings(
    List<dynamic> bookingsJSON) {
  return bookingsJSON.map((item) {
    final request = item['requests'] as Map<String, dynamic>?;
    final client = item['client'] as Map<String, dynamic>?;
    final quote = item['quote'] as Map<String, dynamic>?;

    return BusinessBookingsFullDataStruct(
      id: item['id'] as int?,
      createdAt: item['created_at'] != null
          ? DateTime.parse(item['created_at'])
          : null,
      clientId: item['client_id'] as int?,
      businessId: item['business_id'] as int?,
      addressId: item['address_id'] as int?,
      requestId: item['request_id'] as int?,
      //quoteId: item['quote_id'] as int?,
      status: item['status'] as String?,
      startTimeUtc: item['start_time_utc'] != null
          ? DateTime.parse(item['start_time_utc'])
          : null,
      endTimeUtc: item['end_time_utc'] != null
          ? DateTime.parse(item['end_time_utc'])
          : null,
      oboBusinessId: item['obo_business_id'] as int?,

      // request
      requests: request == null
          ? null
          : ClientRequestStruct(
              id: request['id'] as int?,
              createdAt: request['created_at'] != null
                  ? DateTime.parse(request['created_at'])
                  : null,
              clientId: request['client_id'] as int?,
              description: request['description'] as String?,
              isDirect: request['is_direct'] as bool?,
              budgetMaxCents: request['budget_max_cents'] as int?,
              budgetMinCents: request['budget_min_cents'] as int?,
              clientContacted: request['client_contacted'] as bool?,
              proposalSent: request['proposal_sent'] as bool?,
              proposalAccepted: request['proposal_accepted'] as bool?,
              status: request['status'] as String?,
              paymentMade: request['payment_made'] as bool?,
              bookingMade: request['booking_made'] as bool?,
              serviceId: request['service_id'] as int?,
            ),

      // client
      client: client == null
          ? null
          : ClientDataProfileStruct(
              clientId: client['id'] as int?,
              //userId: client['user_id'] as String?,
              //createdAt: client['created_at'] != null
              //   ? DateTime.parse(client['created_at'])
              //  : null,
              firstName: client['first_name'] as String?,
              lastName: client['last_name'] as String?,
              dob: client['dob'] != null ? DateTime.parse(client['dob']) : null,
              email: client['email'] as String?,
              phone: client['phone'] as int?,
              hasBusiness: client['has_business'] as bool?,
              //photoId: client['photo_id'] as String?,
              stripeId: client['stripe_id'] as String?,
              aboutMe: client['about_me'] as String?,
              //workingAt: client['working_at'] as String?,
              profileUrl: client['profile_url'] as String?,
              bannerUrl: client['banner_url'] as String?,
              //verifiedIdentity: client['verified_identity'] as bool?,
            ),

      // quote
      quote: quote == null
          ? null
          : QuoteDataStruct(
              id: quote['id'] as int?,
              createdAt: quote['created_at'] as String?,
              leadId: quote['lead_id'] as int?,
              serviceId: quote['service_id'] as int?,
              description: quote['description'] as String?,
              status: quote['status'] as String?,
              amountCents: quote['amountCents'] as int?,
              paid: quote['paid'] as bool?,
              expiring: quote['expiring'] as String?,
            ),
    );
  }).toList();
}

String maxTextLengthString(
  String text,
  int charactersMax,
) {
  // take the text argument and apply a xharactersMax, after which onl add .... Return me the string
  if (text.length <= charactersMax) {
    return text;
  } else {
    return '${text.substring(0, charactersMax)}...';
  }
}

String? addDateStrings(
  String dateString,
  int minutesToAdd,
) {
  // Take one date string like  12:00 pm and add 30 minutes to it. return me the datestrign in same format as 12:00 pm
// Parse the input date string
  DateFormat format = DateFormat.jm(); // Format for 12:00 pm
  DateTime dateTime = format.parse(dateString);

  // Add 30 minutes to the parsed DateTime
  dateTime = dateTime.add(Duration(minutes: minutesToAdd));

  // Return the new date string in the same format
  return format.format(dateTime);
}

List<ResourceDataStruct> parseResourceData(List<dynamic> resourceData) {
  bool? toBool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase();
      if (s == 'true' || s == '1') return true;
      if (s == 'false' || s == '0') return false;
    }
    return null;
  }

  return resourceData.map((res) {
    return ResourceDataStruct(
        resourceId: res['id'] as int?,
        createdAt: res['created_at'] != null
            ? DateTime.tryParse(res['created_at'])
            : null,
        name: res['name'] as String?,
        active: toBool(res['active']),
        businessId: res['business_id'],
        resourceType: res['resource_type'],
        profileImage: res['profile_image'],
        serviceTime: parseOpeningHours(res['service_time']));
  }).toList();
}

String combineResourcesEditServicePage(
  List<int> addRes,
  List<int> removeRes,
  List<int> initialList,
) {
  // Preserve initial order, remove then add; no duplicates. Return JSON string.
  final removeSet = removeRes.toSet();
  final result = <int>[];
  final seen = <int>{};

// 1) Start from initial, dropping anything marked for removal
  for (final id in initialList) {
    if (!removeSet.contains(id) && seen.add(id)) {
      result.add(id);
    }
  }
  // 2) Add requested IDs (append order), skipping ones already present
  for (final id in addRes) {
    if (seen.add(id)) {
      result.add(id);
    }
  }

  return jsonEncode(result);
}

List<ClientDataProfileStruct> parseClientData(List<dynamic> clientData) {
  return clientData.map((cli) {
    return ClientDataProfileStruct(
        clientId: cli['client_id'] as int,
        //createdAt: cli['created_at'] != null
        //    ? DateTime.tryParse(cli['created_at'])
        //    : null,
        firstName: cli['first_name'] as String?,
        lastName: cli['last_name'] as String?,
        email: cli['email'] as String?,
        phone: cli['phone'] as int?,
        hasBusiness: cli['has_business'] as bool? ?? false,
        stripeId: cli['stripe_id'] as String?,
        profileUrl: cli['photo_id'] as String?,
        dob: cli['dob'] != null ? DateTime.tryParse(cli['dob']) : null,
        aboutMe: cli['about_me'] as String?,
        images: cli['images'] as String?,
        //workingAt: cli['working_at'] as String?,
        bannerUrl: cli['banner_url'] as String?);
    //fcmToken: cli['fcm_token'] as String?,
    //verifiedIdentity: cli['verified_identity'] as bool? ?? false);
  }).toList();
}

List<BusinessDataMiniStruct> parseBusinessDataMini(
    List<dynamic> businessMiniJSON) {
  return businessMiniJSON.map((biz) {
    return BusinessDataMiniStruct(
      id: biz['id'],
      name: biz['name'],
      profileImage: biz['profile_image'],
    );
  }).toList();
}

DateTime? parseDayTimeToISO(
  String day,
  String time,
) {
  try {
    // Combine date + time into one string
    final combined = '$day $time';

    // Parse into DateTime (local by default)
    final local =
        DateTime.parse(DateTime.parse('$day 00:00:00').toIso8601String());

    // Parse using standard DateFormat for 12-hour format
    final regex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)', caseSensitive: false);
    final match = regex.firstMatch(time);
    if (match == null) return null;

    int hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final isPM = match.group(3)!.toUpperCase() == 'PM';
    if (hour == 12) hour = 0;
    if (isPM) hour += 12;

    final dt =
        DateTime.parse(day).add(Duration(hours: hour, minutes: minute));

    // Convert to UTC ISO string
    return dt.toUtc();
  } catch (_) {
    return null;
  }
}

String? parseDateTimeISOToLocaleDateTime(String datetimeInUTC) {
  // do that parseDateTimeISOToLocaleDateTime
  try {
    // Parse the ISO 8601 formatted date string
    DateTime utcDateTime = DateTime.parse(datetimeInUTC);
    // Convert to local time
    return utcDateTime.toLocal().toIso8601String();
  } catch (e) {
    // Return null if parsing fails
    return "";
  }
}

String codingToProperGrammar(String text) {
  // Replace underscores with spaces
  final replaced = text.replaceAll('_', ' ');

  // Capitalize first letter safely
  if (replaced.isEmpty) return replaced;

  return replaced[0].toUpperCase() + replaced.substring(1);
}

String? datetimeToHHMM(DateTime? datetime) {
  // parse date time to HH:MM
  if (datetime == null) return null; // Return null if datetime is null
  return DateFormat('HH:mm').format(datetime); // Format datetime to HH:MM
}

String stringToDBFormat(String text) {
  // create a function that lower cases all letters and replace spaces with underscore.
  return text.toLowerCase().replaceAll(' ', '_');
}

int countMyBots(MyBotsStruct? myBots) {
  int count = 0;

  if (myBots != null && myBots.greg.active == true) {
    count += 1;
  }

  return count;
}

String mapSaveInformation(
  String option,
  bool toDB,
) {
  final text = option.trim().toLowerCase();

  // Normalize to backend keywords:
  String keyword;
  switch (text) {
    case "ninguno - no guardar datos de clientes":
      keyword = "nothing";
      break;
    case "básico - solo información esencial":
    case "basico - solo información esencial":
      keyword = "basic";
      break;
    case "completo - historial completo de interacciones":
      keyword = "complete";
      break;
    // Already backend form?
    case "nothing":
    case "basic":
    case "complete":
      keyword = text;
      break;
    default:
      keyword = "nothing";
  }

  // Direction:
  if (toDB) {
    return keyword; // return backend form
  }

  // Backend → UI full label
  switch (keyword) {
    case "nothing":
      return "Ninguno - No guardar datos de clientes";
    case "basic":
      return "Básico - Solo información esencial";
    case "complete":
      return "Completo - Historial completo de interacciones";
    default:
      return "Ninguno - No guardar datos de clientes";
  }
}

DateTime datetimeNow() {
  // return todays now datetime
  return DateTime.now(); // Returns the current date and time
}

String labelToSaveInfoDB(String? label) {
  if (label == null || label.isEmpty) {
    return 'nothing'; // Por seguridad, si no hay nada seleccionado
  }

  // Detectamos palabras clave para saber cuál código enviar a la BD
  // Usamos label! (con !) para asegurar que no es nulo
  if (label.contains('Ninguno')) {
    return 'nothing';
  }
  if (label.contains('Básico') || label.contains('Basico')) {
    return 'basic';
  }
  if (label.contains('Completo')) {
    return 'full';
  }

  return 'nothing'; // Fallback por defecto
}

String formatDateFINAL(
  DateTime dateObj,
  String format,
) {
  return DateFormat(format).format(dateObj);
}

List<dynamic>? createContactJson(
  String name,
  String phone,
  List<dynamic>? currentList,
) {
  // 1. Creamos el nuevo contacto como un Mapa dinámico
  Map<String, dynamic> newContact = {
    "name": name,
    "phone": phone,
  };

  // 2. Si la lista vieja no existe (es NULL), retornamos una nueva lista con el contacto
  if (currentList == null) {
    return [newContact];
  }

  // 3. Si ya existe, hacemos una copia segura de la lista
  List<dynamic> updatedList = List<dynamic>.from(currentList);

  // 4. Agregamos el nuevo contacto
  updatedList.add(newContact);

  // 5. Devolvemos la lista actualizada
  return updatedList;
}

String displayAddress(AddressDataStruct? address) {
  if (address == null) return '';

  final parts = <String>[];

  if (address.line1.trim().isNotEmpty) {
    parts.add(address.line1.trim());
  }

  if (address.line2.trim().isNotEmpty) {
    parts.add(address.line2.trim());
  }

  final cityStatePostal = <String>[];

  if (address.city.trim().isNotEmpty) {
    cityStatePostal.add(address.city.trim());
  }

  if (address.state.trim().isNotEmpty) {
    cityStatePostal.add(address.state.trim());
  }

  if (address.postalCode.trim().isNotEmpty) {
    cityStatePostal.add(address.postalCode.trim());
  }

  if (cityStatePostal.isNotEmpty) {
    parts.add(cityStatePostal.join(', '));
  }

  if (address.country.trim().isNotEmpty) {
    parts.add(address.country.trim());
  }

  return parts.join('\n');
}
