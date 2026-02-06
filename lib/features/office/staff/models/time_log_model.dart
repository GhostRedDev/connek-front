import 'team_model.dart';

class TaskInfo {
  final int id;
  final String title;
  final String? description;
  final String? status;

  TaskInfo({
    required this.id,
    required this.title,
    this.description,
    this.status,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) {
    return TaskInfo(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}

class TimeLog {
  final int id;
  final int taskId;
  final int employeeId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final String? notes;
  final String status; // 'running', 'paused', 'stopped'
  final DateTime createdAt;
  final EmployeeInfo? employee;
  final TaskInfo? task;

  TimeLog({
    required this.id,
    required this.taskId,
    required this.employeeId,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    this.notes,
    required this.status,
    required this.createdAt,
    this.employee,
    this.task,
  });

  factory TimeLog.fromJson(Map<String, dynamic> json) {
    return TimeLog(
      id: json['id'] as int,
      taskId: json['task_id'] as int,
      employeeId: json['employee_id'] as int,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'] as String)
          : null,
      durationMinutes: json['duration_minutes'] as int?,
      notes: json['notes'] as String?,
      status: json['status'] as String,
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
      'task_id': taskId,
      'employee_id': employeeId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'duration_minutes': durationMinutes,
      'notes': notes,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Helper getters
  bool get isRunning => status == 'running';
  bool get isPaused => status == 'paused';
  bool get isStopped => status == 'stopped';

  Duration get duration {
    if (durationMinutes != null) {
      return Duration(minutes: durationMinutes!);
    }
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    // If still running, calculate from start to now
    return DateTime.now().difference(startTime);
  }

  String get formattedDuration {
    final d = duration;
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}min';
    }
    return '${minutes}min';
  }

  double get hoursWorked {
    return duration.inMinutes / 60.0;
  }
}
