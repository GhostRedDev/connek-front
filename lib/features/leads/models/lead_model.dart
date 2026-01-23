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
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    // Check if it's the flattened version or nested version
    if (json.containsKey('requests')) {
      return Lead.fromBackend(json);
    }

    return Lead(
      id: json['id'] ?? 0,
      requestId: json['requestId'] ?? 0,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      seen: json['seen'] ?? false,
      clientContacted: json['clientContacted'] ?? false,
      bookingMade: json['bookingMade'] ?? false,
      paymentMade: json['paymentMade'] ?? false,
      proposalSent: json['proposalSent'] ?? false,
      proposalAccepted: json['proposalAccepted'] ?? false,
      status: json['status'] ?? 'pending',
      clientId: json['clientId'] ?? 0,
      serviceId: json['serviceId'] ?? 0,
      clientFirstName: json['clientFirstName'] ?? '',
      clientLastName: json['clientLastName'] ?? '',
      requestDescription: json['requestDescription'] ?? '',
      requestIsDirect: json['requestIsDirect'] ?? false,
      requestBudgetMax: json['requestBudgetMax'],
      requestBudgetMin: json['requestBudgetMin'],
      clientImageUrl: json['clientImageUrl'],
      clientPhone: json['clientPhone'],
    );
  }

  factory Lead.fromBackend(Map<String, dynamic> json) {
    final request = json['requests'] ?? {};
    final client = request['client'] ?? {};

    // Prioritize photo_id as it seems to hold the updated public URL
    String? imageUrl =
        client['photo_id'] ?? client['profile_url'] ?? client['profile_image'];

    return Lead(
      id: json['id'],
      requestId: json['request_id'],
      createdAt: DateTime.parse(json['created_at']),
      seen: json['seen'] ?? false,
      clientContacted: json['client_contacted'] ?? false,
      bookingMade: json['booking_made'] ?? false,
      paymentMade: json['payment_made'] ?? false,
      proposalSent: json['proposal_sent'] ?? false,
      proposalAccepted: json['proposal_accepted'] ?? false,
      status: json['status'] ?? 'pending',
      clientId: client['id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      clientFirstName: client['first_name'] ?? 'Unknown',
      clientLastName: client['last_name'] ?? '',
      requestDescription: request['description'] ?? '',
      requestIsDirect: request['is_direct'] ?? false,
      requestBudgetMax: request['budget_max_cents'],
      requestBudgetMin: request['budget_min_cents'],
      clientImageUrl: imageUrl,
      clientPhone: client['phone']?.toString(),
    );
  }
}
