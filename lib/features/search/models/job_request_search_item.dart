class JobRequestSearchItem {
  final int id;
  final String description;
  final String status;
  final DateTime createdAt;
  final int? budgetMinCents;
  final int? budgetMaxCents;

  JobRequestSearchItem({
    required this.id,
    required this.description,
    required this.status,
    required this.createdAt,
    this.budgetMinCents,
    this.budgetMaxCents,
  });

  factory JobRequestSearchItem.fromJson(Map<String, dynamic> json) {
    int? intOrNull(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v);
      return null;
    }

    return JobRequestSearchItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: (json['description'] ?? '').toString(),
      status: (json['status'] ?? 'pending').toString(),
      createdAt:
          DateTime.tryParse((json['created_at'] ?? '').toString()) ??
          DateTime.now(),
      budgetMinCents: intOrNull(json['budget_min_cents']),
      budgetMaxCents: intOrNull(json['budget_max_cents']),
    );
  }
}
