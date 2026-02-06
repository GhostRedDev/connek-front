import 'team_model.dart';
import 'time_log_model.dart';

class Activity {
  final int id;
  final int employeeId;
  final int businessId;
  final String
  activityType; // 'status_update', 'task_completed', 'time_logged', 'task_assigned'
  final String content;
  final int? relatedTaskId;
  final int? relatedTeamId;
  final DateTime createdAt;
  final EmployeeInfo? employee;
  final TaskInfo? task;

  Activity({
    required this.id,
    required this.employeeId,
    required this.businessId,
    required this.activityType,
    required this.content,
    this.relatedTaskId,
    this.relatedTeamId,
    required this.createdAt,
    this.employee,
    this.task,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      businessId: json['business_id'] as int,
      activityType: json['activity_type'] as String,
      content: json['content'] as String,
      relatedTaskId: json['related_task_id'] as int?,
      relatedTeamId: json['related_team_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      employee: json['employees'] != null
          ? EmployeeInfo.fromJson(json['employees'] as Map<String, dynamic>)
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
      'business_id': businessId,
      'activity_type': activityType,
      'content': content,
      'related_task_id': relatedTaskId,
      'related_team_id': relatedTeamId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get activityTypeEmoji {
    switch (activityType) {
      case 'task_completed':
        return '✅';
      case 'time_logged':
        return '⏱️';
      case 'task_assigned':
        return '📋';
      case 'status_update':
        return '💬';
      default:
        return '📢';
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return 'Hace ${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Hace ${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Hace ${difference.inMinutes} min';
    } else {
      return 'Hace un momento';
    }
  }
}
