import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';
import '../../business/providers/business_provider.dart';
import '../models/notification_model.dart';

import '../../../core/providers/auth_provider.dart';

final notificationProvider =
    AsyncNotifierProvider<NotificationNotifier, List<NotificationModel>>(
      NotificationNotifier.new,
    );

class NotificationNotifier extends AsyncNotifier<List<NotificationModel>> {
  @override
  Future<List<NotificationModel>> build() async {
    // Watch Auth
    final authState = ref.watch(authStateProvider);
    if (authState.value?.session == null) return [];

    // 1. Listen to Business Data (Leads)
    // We use ref.watch so this provider updates whenever business data updates
    final businessData = ref.watch(businessProvider).value;

    List<NotificationModel> notifications = [];
    // const uuid = Uuid();

    // 2. Compile Leads Notifications (High Priority if not seen)
    if (businessData != null) {
      for (final lead in businessData.recentLeads) {
        if (!lead.seen) {
          notifications.add(
            NotificationModel(
              id: 'lead_${lead.id}',
              type: NotificationType.lead,
              priority: NotificationPriority.high,
              title:
                  'Nuevo Lead: ${lead.clientFirstName} ${lead.clientLastName}',
              body: lead.requestDescription,
              createdAt: lead.createdAt,
              isRead: false,
              data: {'leadId': lead.id},
            ),
          );
        }
      }
    }

    // 3. Compile Chat Notifications (Mock for now, Medium Priority)
    // In a real app, we'd watch a chatProvider
    notifications.add(
      NotificationModel(
        id: 'msg_1',
        type: NotificationType.chat,
        priority: NotificationPriority.medium,
        title: 'Eduardo Vega',
        body: 'Hola, me interesa el presupuesto...',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
        data: {'chatId': '1'},
      ),
    );

    notifications.add(
      NotificationModel(
        id: 'msg_2',
        type: NotificationType.chat,
        priority: NotificationPriority.medium,
        title: 'Juan Perez',
        body: '¿Cuándo pueden comenzar?',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true, // Read message
        data: {'chatId': '3'},
      ),
    );

    // 4. Sort by Priority then Date
    notifications.sort((a, b) {
      // Priority: High (0) < Low (2), so a.index - b.index works?
      // Enum index: High=0, Medium=1, Low=2
      int priorityComp = a.priority.index.compareTo(b.priority.index);
      if (priorityComp != 0) return priorityComp;

      // If same priority, newest first
      return b.createdAt.compareTo(a.createdAt);
    });

    return notifications;
  }

  Future<void> markAsRead(String id) async {
    final currentList = state.value;
    if (currentList == null) return;

    final updatedList = currentList.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    state = AsyncValue.data(updatedList);

    // TODO: Call API to mark as read in backend
  }

  int get unreadCount {
    return state.value?.where((n) => !n.isRead).length ?? 0;
  }
}
