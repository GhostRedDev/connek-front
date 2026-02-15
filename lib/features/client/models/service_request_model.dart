class ServiceRequest {
  final int id;
  final String title;
  final String role; // Service type
  final double amount;
  final String imageUrl;
  final String status;
  final DateTime createdAt;

  // Detailed fields
  final String clientName;
  final String clientIndustry;
  final double rating;
  final String message;
  final String serviceTitle;
  final String servicePriceRange;
  final List<TimelineItem> timeline;
  final List<Quote> proposals;

  ServiceRequest({
    required this.id,
    required this.title,
    required this.role,
    required this.amount,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.clientName,
    required this.clientIndustry,
    required this.rating,
    required this.message,
    required this.serviceTitle,
    required this.servicePriceRange,
    required this.timeline,
    required this.proposals,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse double
    double safeDouble(dynamic val) {
      if (val is int) return val.toDouble();
      if (val is double) return val;
      if (val is String) return double.tryParse(val) ?? 0.0;
      return 0.0;
    }

    return ServiceRequest(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['description'] ?? 'Service Request',
      role: json['service']?['name'] ?? 'Service',
      amount: safeDouble(json['amount'] ?? json['budget_max']),
      imageUrl:
          json['image_url'] ??
          'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?ixlib=rb-4.0.3',
      status: json['status'] ?? 'pending',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      clientName: json['client_name'] ?? 'Client Name',
      clientIndustry: json['client_industry'] ?? 'Industry',
      rating: safeDouble(json['rating'] ?? 5.0),
      message: json['message'] ?? '',
      serviceTitle: json['service_title'] ?? '',
      servicePriceRange: json['service_price_range'] ?? '',
      timeline:
          (json['timeline'] as List<dynamic>?)
              ?.map((e) => TimelineItem.fromJson(e))
              .toList() ??
          [],
      proposals: _parseProposals(json['leads']),
    );
  }

  static List<Quote> _parseProposals(dynamic leadsJson) {
    if (leadsJson == null || leadsJson is! List) return [];
    List<Quote> quotes = [];
    for (var lead in leadsJson) {
      if (lead is! Map) continue;

      final dynamic quotesJson = lead['quotes'] ?? lead['quote'];
      if (quotesJson == null) continue;

      if (quotesJson is List) {
        for (final q in quotesJson) {
          if (q is Map<String, dynamic>) {
            quotes.add(Quote.fromJson(q, Map<String, dynamic>.from(lead)));
          } else if (q is Map) {
            quotes.add(
              Quote.fromJson(
                Map<String, dynamic>.from(q),
                Map<String, dynamic>.from(lead),
              ),
            );
          }
        }
      } else if (quotesJson is Map) {
        quotes.add(
          Quote.fromJson(
            Map<String, dynamic>.from(quotesJson),
            Map<String, dynamic>.from(lead),
          ),
        );
      }
    }
    return quotes;
  }
}

class Quote {
  final int id;
  final int leadId;
  final int? businessId;
  final int? serviceId;
  final double amount;
  final String description;
  final String status;
  final String businessName;
  final DateTime? expiring;

  Quote({
    required this.id,
    required this.leadId,
    this.businessId,
    this.serviceId,
    required this.amount,
    required this.description,
    required this.status,
    required this.businessName,
    this.expiring,
  });

  factory Quote.fromJson(Map<String, dynamic> json, Map<String, dynamic> lead) {
    final business = lead['business'] ?? {};

    // Safely parse double from cents
    double safeAmount(dynamic val) {
      if (val == null) return 0.0;
      if (val is int) return val / 100.0;
      if (val is double) return val / 100.0;
      if (val is String) {
        return (double.tryParse(val) ?? 0.0) / 100.0;
      }
      return 0.0;
    }

    return Quote(
      id: json['id'] ?? 0,
      leadId: lead['id'] ?? 0,
      businessId: (lead['business_id'] as int?) ?? (business['id'] as int?),
      serviceId: (lead['service_id'] as int?) ?? (json['service_id'] as int?),
      amount: safeAmount(json['amount_cents']),
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      businessName: business['name'] ?? 'Unknown Business',
      expiring: DateTime.tryParse(json['expiring'] ?? ''),
    );
  }
}

class TimelineItem {
  final String title;
  final DateTime time;
  final bool isCompleted;

  TimelineItem({
    required this.title,
    required this.time,
    required this.isCompleted,
  });

  factory TimelineItem.fromJson(Map<String, dynamic> json) {
    return TimelineItem(
      title: json['title'] ?? '',
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
      isCompleted: json['is_completed'] ?? false,
    );
  }
}
