class Lead {
  final int id;
  final int requestId;
  final DateTime createdAt;
  final bool seen;
  final bool clientContacted;
  final bool bookingMade;
  final bool paymentMade;
  final bool proposalSent;
  final bool proposalAccepted;
  final String status;
  final int clientId;
  final int serviceId;
  final String clientFirstName;
  final String clientLastName;
  final String requestDescription;
  final bool requestIsDirect;
  final int? requestBudgetMax;
  final int? requestBudgetMin;
  final String? clientImageUrl;
  final String? clientPhone;
  final DateTime? proposedBookingDate;

  Lead({
    required this.id,
    required this.requestId,
    required this.createdAt,
    required this.seen,
    required this.clientContacted,
    required this.bookingMade,
    required this.paymentMade,
    required this.proposalSent,
    required this.proposalAccepted,
    required this.status,
    required this.clientId,
    required this.serviceId,
    required this.clientFirstName,
    required this.clientLastName,
    required this.requestDescription,
    required this.requestIsDirect,
    this.requestBudgetMax,
    this.requestBudgetMin,
    this.clientImageUrl,
    this.clientPhone,
    this.proposedBookingDate,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    // Check if it's the flattened version or nested version
    if (json.containsKey('requests')) {
      return Lead.fromBackend(json);
    }

    // Safely parse int wrapper
    int safeInt(dynamic val) {
      if (val is int) return val;
      if (val is double) return val.toInt();
      if (val is String) return int.tryParse(val) ?? 0;
      return 0;
    }

    return Lead(
      id: safeInt(json['id']),
      requestId: safeInt(json['requestId']),
      createdAt:
          DateTime.tryParse(
            json['createdAt'] ?? DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
      seen: json['seen'] ?? false,
      clientContacted: json['clientContacted'] ?? false,
      bookingMade: json['bookingMade'] ?? false,
      paymentMade: json['paymentMade'] ?? false,
      proposalSent: json['proposalSent'] ?? false,
      proposalAccepted: json['proposalAccepted'] ?? false,
      status: json['status'] ?? 'pending',
      clientId: safeInt(json['clientId']),
      serviceId: safeInt(json['serviceId']),
      clientFirstName: json['clientFirstName'] ?? '',
      clientLastName: json['clientLastName'] ?? '',
      requestDescription: json['requestDescription'] ?? '',
      requestIsDirect: json['requestIsDirect'] ?? false,
      requestBudgetMax: safeInt(json['requestBudgetMax']),
      requestBudgetMin: safeInt(json['requestBudgetMin']),
      clientImageUrl: json['clientImageUrl'],
      clientPhone: json['clientPhone'],
      proposedBookingDate: json['proposedBookingDate'] != null
          ? DateTime.tryParse(json['proposedBookingDate'])
          : null,
    );
  }

  factory Lead.fromBackend(Map<String, dynamic> json) {
    final request = json['requests'] ?? {};
    final client = request['client'] ?? {};

    // Prioritize photo_id as it seems to hold the updated public URL
    String? imageUrl =
        client['photo_id'] ?? client['profile_url'] ?? client['profile_image'];

    // Safely parse int wrapper
    int safeInt(dynamic val) {
      if (val is int) return val;
      if (val is double) return val.toInt();
      if (val is String) return int.tryParse(val) ?? 0;
      return 0;
    }

    return Lead(
      id: safeInt(json['id']),
      requestId: safeInt(json['request_id']),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      seen: json['seen'] ?? false,
      clientContacted: json['client_contacted'] ?? false,
      bookingMade: json['booking_made'] ?? false,
      paymentMade: json['payment_made'] ?? false,
      proposalSent: json['proposal_sent'] ?? false,
      proposalAccepted: json['proposal_accepted'] ?? false,
      status: json['status'] ?? 'pending',
      clientId: safeInt(client['id']),
      serviceId: safeInt(json['service_id']),
      clientFirstName: client['first_name'] ?? 'Unknown',
      clientLastName: client['last_name'] ?? '',
      requestDescription: request['description'] ?? '',
      requestIsDirect: request['is_direct'] ?? false,
      requestBudgetMax: safeInt(request['budget_max_cents']),
      requestBudgetMin: safeInt(request['budget_min_cents']),
      clientImageUrl: imageUrl,
      clientPhone: client['phone']?.toString(),
      proposedBookingDate: json['proposed_booking_date'] != null
          ? DateTime.tryParse(json['proposed_booking_date'])
          : null,
    );
  }
}
