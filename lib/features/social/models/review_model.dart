class ReviewModel {
  final int id;
  final int businessId;
  final int clientId;
  final int rating;
  final String content;
  final DateTime createdAt;
  final Map<String, dynamic>? client;
  final int likesCount;

  ReviewModel({
    required this.id,
    required this.businessId,
    required this.clientId,
    required this.rating,
    required this.content,
    required this.createdAt,
    this.client,
    this.likesCount = 0,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      businessId: json['business_id'],
      clientId: json['client_id'],
      rating: json['rating'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      client: json['client'],
      likesCount: json['likes_count'] ?? 0,
    );
  }
}
