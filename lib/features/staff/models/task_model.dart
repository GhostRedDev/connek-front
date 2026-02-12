import 'team_model.dart';

class TaskAssignment {
  final int id;
  final int taskId;
  final int employeeId;
  final DateTime assignedAt;
  final int? assignedBy;
  final EmployeeInfo? employee;

  TaskAssignment({
    required this.id,
    required this.taskId,
    required this.employeeId,
    required this.assignedAt,
    this.assignedBy,
    this.employee,
  });

  factory TaskAssignment.fromJson(Map<String, dynamic> json) {
    return TaskAssignment(
      id: json['id'] as int,
      taskId: json['task_id'] as int,
      employeeId: json['employee_id'] as int,
      assignedAt: DateTime.parse(json['assigned_at'] as String),
      assignedBy: json['assigned_by'] as int?,
      employee: json['employees'] != null
          ? EmployeeInfo.fromJson(json['employees'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'employee_id': employeeId,
      'assigned_at': assignedAt.toIso8601String(),
      'assigned_by': assignedBy,
    };
  }
}

class Task {
  final int id;
  final int businessId;
  final int? teamId;
  final String title;
  final String? description;
  final String status; // 'pending', 'in_progress', 'completed', 'cancelled'
  final String priority; // 'low', 'medium', 'high', 'urgent'
  final double? estimatedHours;
  final DateTime? dueDate;
  final int? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final List<TaskAssignment> assignments;

  Task({
    required this.id,
    required this.businessId,
    this.teamId,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    this.estimatedHours,
    this.dueDate,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.assignments = const [],
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      businessId: json['business_id'] as int,
      teamId: json['team_id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      priority: json['priority'] as String,
      estimatedHours: json['estimated_hours'] != null
          ? (json['estimated_hours'] as num).toDouble()
          : null,
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      createdBy: json['created_by'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      assignments: json['task_assignments'] != null
          ? (json['task_assignments'] as List)
                .map((a) => TaskAssignment.fromJson(a as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'team_id': teamId,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'estimated_hours': estimatedHours,
      'due_date': dueDate?.toIso8601String(),
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  // Helper getters
  bool get isPending => status == 'pending';
  bool get isInProgress => status == 'in_progress';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  bool get isOverdue =>
      dueDate != null && !isCompleted && DateTime.now().isAfter(dueDate!);

  String get priorityEmoji {
    switch (priority) {
      case 'urgent':
        return '🔴';
      case 'high':
        return '🟡';
      case 'medium':
        return '🟢';
      case 'low':
        return '⚪';
      default:
        return '';
    }
  }

  int get assignedEmployeeCount => assignments.length;

  Task copyWith({
    String? status,
    String? priority,
    String? title,
    String? description,
    DateTime? dueDate,
  }) {
    return Task(
      id: id,
      businessId: businessId,
      teamId: teamId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      estimatedHours: estimatedHours,
      dueDate: dueDate ?? this.dueDate,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      completedAt: status == 'completed' ? DateTime.now() : completedAt,
      assignments: assignments,
    );
  }
}
