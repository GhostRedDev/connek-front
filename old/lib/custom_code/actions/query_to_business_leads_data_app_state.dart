// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future<List<BusinessLeadsStruct>> queryToBusinessLeadsDataAppState(
  List<dynamic>? leadsQuery,
) async {
  // Si viene null o vacío → retornamos lista vacía directamente
  if (leadsQuery == null || leadsQuery.isEmpty) {
    return <BusinessLeadsStruct>[];
  }

  List<BusinessLeadsStruct> businessLeadList = leadsQuery.map((item) {
    // Parse nested request y client con fallback a {}
    final request =
        (item is Map ? item['requests'] as Map<String, dynamic>? : null) ??
            const <String, dynamic>{};
    final client = (request['client'] as Map<String, dynamic>?) ??
        const <String, dynamic>{};

    return BusinessLeadsStruct(
      id: (item is Map ? item['id'] as int? : null) ?? 0,
      createdAt: item is Map && item['created_at'] != null
          ? DateTime.parse(item['created_at'])
          : null,
      requestId: (item is Map ? item['request_id'] as int? : null) ?? 0,
      seen: (item is Map ? item['seen'] as bool? : null) ?? false,
      clientContacted:
          (item is Map ? item['client_contacted'] as bool? : null) ?? false,
      bookingMade:
          (item is Map ? item['booking_made'] as bool? : null) ?? false,
      paymentMade:
          (item is Map ? item['payment_made'] as bool? : null) ?? false,
      proposalSent:
          (item is Map ? item['proposal_sent'] as bool? : null) ?? false,
      proposalAccepted:
          (item is Map ? item['proposal_accepted'] as bool? : null) ?? false,
      status: (item is Map ? item['status'] as String? : null) ?? '',
      serviceId: (item is Map ? item['service_id'] as int? : null),
      clientId: (client['id'] as int?) ?? 0,
      clientFirstName: (client['first_name'] as String?) ?? '',
      clientLastName: (client['last_name'] as String?) ?? '',
      clientImageUrl: (client['profile_url'] as String?) ?? '',
      requestDescription: (request['description'] as String?) ?? '',
      requestIsDirect: (request['is_direct'] as bool?) ?? false,
      requestBudgetMax: (request['budget_max_cents'] as int?) ?? 0,
      requestBudgetMin: (request['budget_min_cents'] as int?) ?? 0,
    );
  }).toList();

  return businessLeadList;
}
