import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(String)? onStatusChanged;

  const TaskCard({super.key, required this.task, this.onStatusChanged});

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // TODO: Navigate to task details
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Priority & Title
                Row(
                  children: [
                    Text(
                      task.priorityEmoji,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                if (task.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    task.description!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                const SizedBox(height: 12),

                // Assigned employees
                if (task.assignments.isNotEmpty) ...[
                  Wrap(
                    spacing: 4,
                    children: task.assignments.take(3).map((assignment) {
                      return CircleAvatar(
                        radius: 12,
                        backgroundColor: const Color(0xFF4F87C9),
                        child: Text(
                          assignment.employee?.name
                                  .substring(0, 1)
                                  .toUpperCase() ??
                              '?',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                ],

                // Due date & estimated hours
                Row(
                  children: [
                    if (task.dueDate != null) ...[
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: task.isOverdue ? Colors.red : Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(task.dueDate!),
                        style: TextStyle(
                          fontSize: 12,
                          color: task.isOverdue ? Colors.red : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (task.estimatedHours != null) ...[
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${task.estimatedHours}h',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),

                // Status actions
                if (onStatusChanged != null) ...[
                  const SizedBox(height: 12),
                  _buildStatusActions(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusActions(BuildContext context) {
    if (task.isPending) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => onStatusChanged?.call('in_progress'),
          icon: const Icon(Icons.play_arrow, size: 16),
          label: const Text('Iniciar'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      );
    } else if (task.isInProgress) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => onStatusChanged?.call('completed'),
          icon: const Icon(Icons.check, size: 16),
          label: const Text('Completar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);

    if (taskDate == today) {
      return 'Hoy';
    } else if (taskDate == today.add(const Duration(days: 1))) {
      return 'Mañana';
    } else if (taskDate.isBefore(today)) {
      final diff = today.difference(taskDate).inDays;
      return 'Hace $diff día${diff > 1 ? 's' : ''}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
