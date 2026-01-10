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
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    // Customize parsing based on actual API response structure
    // Assuming structure similar to:
    // { "id": 1, "description": "Limpieza profunda", "service": { "name": "Limpieza" }, "budget_max": 15000, "photos": [...] }

    // For now, I'll map standard fields and handle potential backend variations safely

    return ServiceRequest(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['description'] ?? 'Service Request',
      role: json['service']?['name'] ?? 'Service',
      amount: (json['amount'] ?? json['budget_max'] ?? 0).toDouble(),
      imageUrl:
          json['image_url'] ??
          'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?ixlib=rb-4.0.3',
      status: json['status'] ?? 'pending',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      clientName: json['client_name'] ?? 'Client Name',
      clientIndustry: json['client_industry'] ?? 'Industry',
      rating: (json['rating'] ?? 5.0).toDouble(),
      message: json['message'] ?? '',
      serviceTitle: json['service_title'] ?? '',
      servicePriceRange: json['service_price_range'] ?? '',
      timeline:
          (json['timeline'] as List<dynamic>?)
              ?.map((e) => TimelineItem.fromJson(e))
              .toList() ??
          [],
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
