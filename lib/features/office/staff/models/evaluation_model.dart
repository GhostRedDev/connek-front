import 'team_model.dart';
import 'time_log_model.dart';

class UserInfo {
  final int id;
  final String name;

  UserInfo({required this.id, required this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class Evaluation {
  final int id;
  final int employeeId;
  final int evaluatorId;
  final int? relatedActivityId;
  final int? relatedTaskId;
  final int rating; // 1-5
  final String? comment;
  final DateTime createdAt;
  final UserInfo? evaluator;
  final TaskInfo? task;

  Evaluation({
    required this.id,
    required this.employeeId,
    required this.evaluatorId,
    this.relatedActivityId,
    this.relatedTaskId,
    required this.rating,
    this.comment,
    required this.createdAt,
    this.evaluator,
    this.task,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      evaluatorId: json['evaluator_id'] as int,
      relatedActivityId: json['related_activity_id'] as int?,
      relatedTaskId: json['related_task_id'] as int?,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      evaluator: json['users'] != null
          ? UserInfo.fromJson(json['users'] as Map<String, dynamic>)
          : null,
      task: json['tasks'] != null
          ? TaskInfo.fromJson(json['tasks'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'evaluator_id': evaluatorId,
      'related_activity_id': relatedActivityId,
      'related_task_id': relatedTaskId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get starsDisplay => '⭐' * rating;

  String get ratingLabel {
    switch (rating) {
      case 1:
        return 'Necesita mejorar';
      case 2:
        return 'Regular';
      case 3:
        return 'Bueno';
      case 4:
        return 'Muy bueno';
      case 5:
        return 'Excelente';
      default:
        return '';
    }
  }
}

class EmployeeRating {
  final double averageRating;
  final int totalEvaluations;
  final Map<int, int> ratingDistribution;
  final List<Evaluation> recentEvaluations;

  EmployeeRating({
    required this.averageRating,
    required this.totalEvaluations,
    required this.ratingDistribution,
    required this.recentEvaluations,
  });

  factory EmployeeRating.fromJson(Map<String, dynamic> json) {
    return EmployeeRating(
      averageRating: (json['average_rating'] as num).toDouble(),
      totalEvaluations: json['total_evaluations'] as int,
      ratingDistribution: Map<int, int>.from(
        json['rating_distribution'] as Map<dynamic, dynamic>,
      ),
      recentEvaluations: json['recent_evaluations'] != null
          ? (json['recent_evaluations'] as List)
                .map((e) => Evaluation.fromJson(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average_rating': averageRating,
      'total_evaluations': totalEvaluations,
      'rating_distribution': ratingDistribution,
      'recent_evaluations': recentEvaluations.map((e) => e.toJson()).toList(),
    };
  }

  String get formattedRating => averageRating.toStringAsFixed(1);

  String get starsDisplay {
    final fullStars = averageRating.floor();
    final hasHalfStar = (averageRating - fullStars) >= 0.5;
    String stars = '⭐' * fullStars;
    if (hasHalfStar) stars += '✨';
    return stars;
  }
}
