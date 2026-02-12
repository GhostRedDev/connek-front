import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Employee + Time
          Row(
            children: [
              // Employee Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF4F87C9),
                backgroundImage: activity.employee?.profileImage != null
                    ? NetworkImage(activity.employee!.profileImage!)
                    : null,
                child: activity.employee?.profileImage == null
                    ? Text(
                        activity.employee?.name.substring(0, 1).toUpperCase() ??
                            '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Employee Name & Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.employee?.name ?? 'Empleado',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      activity.timeAgo,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Activity Type Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getActivityColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  activity.activityTypeEmoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Content
          Text(activity.content, style: const TextStyle(fontSize: 15)),

          // Related Task
          if (activity.task != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.task_alt, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      activity.task!.title,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getActivityColor() {
    switch (activity.activityType) {
      case 'task_completed':
        return Colors.green;
      case 'time_logged':
        return Colors.blue;
      case 'task_assigned':
        return Colors.orange;
      case 'status_update':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
