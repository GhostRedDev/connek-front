enum NotificationType {
  info,
  success,
  warning,
  error,
  message,
  booking,
  payment,
  review,
  lead, // Keep for compatibility
  chat, // Keep for compatibility
  alert, // Keep for compatibility
  system, // Keep for compatibility
}

enum NotificationPriority { high, medium, low }

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final DateTime createdAt;
  final bool isRead;
  final String? actionUrl;
  final Map<String, dynamic>? data;
  final String? userId;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.priority = NotificationPriority.medium,
    required this.createdAt,
    this.isRead = false,
    this.actionUrl,
    this.data,
    this.userId,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationType? type,
    NotificationPriority? priority,
    DateTime? createdAt,
    bool? isRead,
    String? actionUrl,
    Map<String, dynamic>? data,
    String? userId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      actionUrl: actionUrl ?? this.actionUrl,
      data: data ?? this.data,
      userId: userId ?? this.userId,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(), // Safely convert int ID to String
      title: (json['title'] ?? 'Notification').toString(),
      body: (json['body'] ?? json['message'] ?? '').toString(),
      type: _parseNotificationType((json['type'] ?? 'info').toString()),
      priority: _parsePriority((json['priority'])?.toString()),
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      isRead: json['is_read'] ?? false, // Safe bool access
      actionUrl: json['action_url']?.toString(),
      data: json['data'] as Map<String, dynamic>?,
      userId: json['user_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type.name,
      'priority': priority.name,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'action_url': actionUrl,
      'data': data,
      'user_id': userId,
    };
  }

  static NotificationType _parseNotificationType(String type) {
    switch (type.toLowerCase()) {
      case 'success':
        return NotificationType.success;
      case 'warning':
        return NotificationType.warning;
      case 'error':
        return NotificationType.error;
      case 'message':
        return NotificationType.message;
      case 'booking':
        return NotificationType.booking;
      case 'payment':
        return NotificationType.payment;
      case 'review':
        return NotificationType.review;
      case 'lead':
        return NotificationType.lead;
      case 'chat':
        return NotificationType.chat;
      case 'alert':
        return NotificationType.alert;
      case 'system':
        return NotificationType.system;
      default:
        return NotificationType.info;
    }
  }

  static NotificationPriority _parsePriority(String? priority) {
    if (priority == null) return NotificationPriority.medium;
    switch (priority.toLowerCase()) {
      case 'high':
        return NotificationPriority.high;
      case 'low':
        return NotificationPriority.low;
      default:
        return NotificationPriority.medium;
    }
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, type: $type, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
