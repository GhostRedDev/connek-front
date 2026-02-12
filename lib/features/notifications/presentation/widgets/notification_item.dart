import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../data/models/notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationItem extends ConsumerWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.error:
        return Icons.error;
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.booking:
        return Icons.calendar_today_rounded;
      case NotificationType.payment:
        return Icons.payments_rounded;
      case NotificationType.message:
      case NotificationType.chat:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.lead:
        return Icons.person_add_rounded;
      case NotificationType.review:
        return Icons.star_rounded;
      case NotificationType.alert:
        return Icons.notifications_active_rounded;
      case NotificationType.system:
        return Icons.settings_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  Color _getColorForType(NotificationType type, ShadColorScheme colorScheme) {
    switch (type) {
      case NotificationType.success:
        return Colors.green.shade600;
      case NotificationType.error:
        return colorScheme.destructive;
      case NotificationType.warning:
        return Colors.amber.shade700;
      case NotificationType.booking:
        return Colors.purple.shade500;
      case NotificationType.payment:
        return Colors.teal.shade500;
      case NotificationType.message:
      case NotificationType.chat:
        return Colors.blue.shade500;
      case NotificationType.lead:
        return colorScheme.primary;
      case NotificationType.review:
        return Colors.orange.shade500;
      case NotificationType.alert:
        return Colors.red.shade500;
      case NotificationType.system:
        return colorScheme.foreground.withOpacity(0.6);
      default:
        return colorScheme.primary;
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    timeago.setLocaleMessages('es', timeago.EsMessages());
    return timeago.format(dateTime, locale: 'es');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final typeColor = _getColorForType(notification.type, colorScheme);
    final isUnread = !notification.isRead;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.destructive.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete_outline_rounded,
          color: colorScheme.destructive,
          size: 28,
        ),
      ),
      onDismissed: (_) {
        ref
            .read(notificationProvider.notifier)
            .deleteNotification(notification.id);
      },
      child: ShadCard(
        padding: const EdgeInsets.all(0),
        backgroundColor: isUnread
            ? colorScheme.primary.withOpacity(0.02)
            : null,
        border: ShadBorder.all(
          color: isUnread
              ? colorScheme.primary.withOpacity(0.1)
              : colorScheme.border.withOpacity(0.3),
          width: 1,
        ),
        radius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            ref.read(notificationProvider.notifier).markAsRead(notification.id);
            if (notification.actionUrl != null) {
              context.push(notification.actionUrl!);
            }
          },
          onLongPress: () {
            // Show context menu
            _showContextMenu(context, ref);
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Highlight Indicator for unread
                if (isUnread)
                  Container(
                    width: 4,
                    height: 40,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: typeColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForType(notification.type),
                    color: typeColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontWeight: isUnread
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                fontSize: 16,
                                color: colorScheme.foreground,
                              ),
                            ),
                          ),
                          Text(
                            _formatTimeAgo(notification.createdAt),
                            style: TextStyle(
                              color: colorScheme.foreground.withOpacity(0.4),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.body,
                        style: TextStyle(
                          color: isUnread
                              ? colorScheme.foreground.withOpacity(0.9)
                              : colorScheme.foreground.withOpacity(0.6),
                          fontSize: 14,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: colorScheme.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ShadButton.outline(
              width: double.infinity,
              onPressed: () {
                ref
                    .read(notificationProvider.notifier)
                    .markAsRead(notification.id);
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.done_all, size: 16),
                  SizedBox(width: 8),
                  Text('Marcar como leída'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ShadButton.destructive(
              width: double.infinity,
              onPressed: () {
                ref
                    .read(notificationProvider.notifier)
                    .deleteNotification(notification.id);
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete_outline, size: 16),
                  SizedBox(width: 8),
                  Text('Eliminar notificación'),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
