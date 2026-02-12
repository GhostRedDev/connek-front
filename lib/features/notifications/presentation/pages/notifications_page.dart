import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../data/models/notification_model.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_item.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  NotificationType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final notificationsAsync = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificaciones',
              style: TextStyle(
                color: colorScheme.foreground,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Mantente al día con tu actividad',
              style: TextStyle(
                color: colorScheme.foreground.withOpacity(0.6),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          _buildActionsMenu(context, ref, colorScheme),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Filter Chips
          _buildFilterChips(colorScheme),
          const SizedBox(height: 16),

          // Notifications List
          Expanded(
            child: notificationsAsync.when(
              data: (notifications) {
                // Apply Filter
                final filtered = _selectedFilter == null
                    ? notifications
                    : notifications
                          .where((n) => n.type == _selectedFilter)
                          .toList();

                if (filtered.isEmpty) {
                  return _buildEmptyState(colorScheme);
                }

                // Group by Date
                final grouped = _groupNotificationsByDate(filtered);

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(notificationProvider.notifier).refresh(),
                  color: colorScheme.primary,
                  backgroundColor: colorScheme.background,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: grouped.length,
                    itemBuilder: (context, index) {
                      final group = grouped[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateHeader(group.title, colorScheme),
                          ...group.notifications.map(
                            (n) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: NotificationItem(notification: n),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
              error: (error, stack) => _buildErrorState(colorScheme, error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsMenu(
    BuildContext context,
    WidgetRef ref,
    ShadColorScheme colorScheme,
  ) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz_rounded, color: colorScheme.foreground),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.background,
      elevation: 4,
      onSelected: (value) {
        if (value == 'mark_all') {
          ref.read(notificationProvider.notifier).markAllAsRead();
        } else if (value == 'clear_all') {
          _showClearAllDialog();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'mark_all',
          child: Row(
            children: [
              Icon(
                Icons.done_all_rounded,
                size: 18,
                color: colorScheme.foreground,
              ),
              const SizedBox(width: 8),
              Text(
                'Marcar todo como leído',
                style: TextStyle(color: colorScheme.foreground),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'clear_all',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 18,
                color: colorScheme.destructive,
              ),
              const SizedBox(width: 8),
              Text(
                'Eliminar todo',
                style: TextStyle(color: colorScheme.destructive),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(ShadColorScheme colorScheme) {
    final filters = [
      (null, 'Todas'),
      (NotificationType.lead, 'Leads'),
      (NotificationType.booking, 'Reservas'),
      (NotificationType.payment, 'Pagos'),
      (NotificationType.message, 'Mensajes'),
      (NotificationType.review, 'Reseñas'),
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (type, label) = filters[index];
          final isSelected = _selectedFilter == type;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedFilter = type;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.secondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.border.withOpacity(0.5),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : colorScheme.foreground,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateHeader(String title, ShadColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorScheme.foreground.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              color: colorScheme.border.withOpacity(0.5),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ShadColorScheme colorScheme) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_off_outlined,
                size: 48,
                color: colorScheme.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Sin notificaciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedFilter == null
                  ? 'Te avisaremos cuando haya actividad importante.'
                  : 'No tienes notificaciones de este tipo.',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.foreground.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(ShadColorScheme colorScheme, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: colorScheme.destructive,
          ),
          const SizedBox(height: 16),
          Text(
            'Error al cargar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.foreground,
            ),
          ),
          ShadButton.ghost(
            onPressed: () => ref.read(notificationProvider.notifier).refresh(),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('¿Limpiar bandeja?'),
        content: Text(
          'Esto eliminará todas tus notificaciones de forma permanente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: colorScheme.foreground),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(notificationProvider.notifier).clearAll();
              Navigator.pop(context);
            },
            child: Text(
              'Eliminar todo',
              style: TextStyle(color: colorScheme.destructive),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper: Group by Date ---
  List<NotificationGroup> _groupNotificationsByDate(
    List<NotificationModel> notifications,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final thisWeek = today.subtract(const Duration(days: 7));

    final List<NotificationGroup> groups = [];
    final Map<String, List<NotificationModel>> tempGroups = {
      'Hoy': [],
      'Ayer': [],
      'Esta semana': [],
      'Anteriormente': [],
    };

    for (var n in notifications) {
      final date = n.createdAt;
      final checkDate = DateTime(date.year, date.month, date.day);

      if (checkDate.isAtSameMomentAs(today)) {
        tempGroups['Hoy']!.add(n);
      } else if (checkDate.isAtSameMomentAs(yesterday)) {
        tempGroups['Ayer']!.add(n);
      } else if (checkDate.isAfter(thisWeek)) {
        tempGroups['Esta semana']!.add(n);
      } else {
        tempGroups['Anteriormente']!.add(n);
      }
    }

    // Add non-empty groups to result
    if (tempGroups['Hoy']!.isNotEmpty) {
      groups.add(NotificationGroup('Hoy', tempGroups['Hoy']!));
    }
    if (tempGroups['Ayer']!.isNotEmpty) {
      groups.add(NotificationGroup('Ayer', tempGroups['Ayer']!));
    }
    if (tempGroups['Esta semana']!.isNotEmpty) {
      groups.add(NotificationGroup('Esta semana', tempGroups['Esta semana']!));
    }
    if (tempGroups['Anteriormente']!.isNotEmpty) {
      groups.add(
        NotificationGroup('Anteriormente', tempGroups['Anteriormente']!),
      );
    }

    return groups;
  }
}

class NotificationGroup {
  final String title;
  final List<NotificationModel> notifications;

  NotificationGroup(this.title, this.notifications);
}
