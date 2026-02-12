import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/notification_service.dart';
import '../../../business/presentation/providers/business_provider.dart';
import '../../data/models/notification_model.dart';
import '../../../../core/providers/auth_provider.dart';

// Main notification provider
final notificationProvider =
    AsyncNotifierProvider<NotificationNotifier, List<NotificationModel>>(
      NotificationNotifier.new,
    );

// Unread count provider
final unreadNotificationCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationProvider).value ?? [];
  return notifications.where((n) => !n.isRead).length;
});

// Filter by type provider
final notificationsByTypeProvider =
    Provider.family<List<NotificationModel>, NotificationType?>((ref, type) {
      final notifications = ref.watch(notificationProvider).value ?? [];
      if (type == null) return notifications;
      return notifications.where((n) => n.type == type).toList();
    });

class NotificationNotifier extends AsyncNotifier<List<NotificationModel>> {
  final _supabase = Supabase.instance.client;
  final _notificationService = NotificationService();
  RealtimeChannel? _subscription;
  int? _clientId;

  @override
  Future<List<NotificationModel>> build() async {
    // Watch Auth
    final authState = ref.watch(authStateProvider);
    if (authState.value?.session == null) {
      _subscription?.unsubscribe();
      return [];
    }

    final userId = authState.value!.session!.user.id;

    // Initialize Local Notifications
    await _notificationService.initialize();

    // Setup Realtime Listener (Moved inside try block after clientId is fetched)

    // Fetch notifications from Supabase
    try {
      // First get the client ID for this user ID
      final clientResponse = await _supabase
          .from('clients') // Correct table name
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();

      if (clientResponse == null) {
        debugPrint('No client record found for user $userId');
        return [];
      }

      _clientId = clientResponse['id'];

      // Setup Realtime Listener with clientId
      _setupRealtimeListener(userId, _clientId);

      final response = await _supabase
          .from('notifications')
          .select()
          .eq('client_id', _clientId!)
          .order('created_at', ascending: false)
          .limit(50);

      final notifications = (response as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      // Also include business leads as notifications
      final businessData = ref.watch(businessProvider).value;
      if (businessData != null) {
        for (final lead in businessData.recentLeads) {
          if (!lead.seen) {
            notifications.insert(
              0,
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
                actionUrl: '/business/leads/${lead.id}',
              ),
            );
          }
        }
      }

      // Sort by priority then date
      notifications.sort((a, b) {
        // High priority first
        int priorityComp = a.priority.index.compareTo(b.priority.index);
        if (priorityComp != 0) return priorityComp;
        // Recent first
        return b.createdAt.compareTo(a.createdAt);
      });

      return notifications;
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
      return [];
    }
  }

  void _setupRealtimeListener(String userId, [int? clientId]) async {
    // Unsubscribe if exists
    _subscription?.unsubscribe();

    // If clientId is not provided, try to fetch it
    int? finalClientId = clientId;
    if (finalClientId == null) {
      final clientResponse = await _supabase
          .from('clients')
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();
      if (clientResponse != null) {
        finalClientId = clientResponse['id'];
      }
    }

    if (finalClientId == null) {
      debugPrint('Could not setup realtime listener: client_id not found');
      return;
    }

    _subscription = _supabase
        .channel('public:notifications:client_id=eq.$finalClientId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'notifications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'client_id',
            value: finalClientId,
          ),
          callback: (payload) {
            print('🔔 REALTIME NOTIFICATION RECEIVED: $payload');

            // 1. Show Local System Notification
            _notificationService.handleRealtimeEvent(payload);

            // 2. Add to local state list immediately
            final newRecord = payload.newRecord;
            final newNotification = NotificationModel.fromJson(newRecord);

            final oldState = state.value ?? [];
            state = AsyncValue.data([newNotification, ...oldState]);
          },
        )
        .subscribe();

    print('✅ Subscribed to notification channel for client $finalClientId');
  }

  /// Mark a single notification as read
  Future<void> markAsRead(String id) async {
    final currentList = state.value;
    if (currentList == null) return;

    // Update local state immediately
    final updatedList = currentList.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    state = AsyncValue.data(updatedList);

    // Update in database
    try {
      if (!id.startsWith('lead_')) {
        // Only update if it's a real DB notification
        await _supabase
            .from('notifications')
            .update({'is_read': true})
            .eq('id', id);
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    final currentList = state.value;
    if (currentList == null) return;

    // Update local state
    final updatedList = currentList
        .map((n) => n.copyWith(isRead: true))
        .toList();

    state = AsyncValue.data(updatedList);

    // Update in database
    try {
      if (_clientId != null) {
        await _supabase
            .from('notifications')
            .update({'is_read': true})
            .eq('client_id', _clientId!);
      }
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
    }
  }

  /// Delete a single notification
  Future<void> deleteNotification(String id) async {
    final currentList = state.value;
    if (currentList == null) return;

    // Update local state
    final updatedList = currentList.where((n) => n.id != id).toList();
    state = AsyncValue.data(updatedList);

    // Delete from database
    try {
      if (!id.startsWith('lead_')) {
        await _supabase.from('notifications').delete().eq('id', id);
      }
    } catch (e) {
      debugPrint('Error deleting notification: $e');
    }
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    state = const AsyncValue.data([]);

    // Delete from database
    try {
      if (_clientId != null) {
        await _supabase
            .from('notifications')
            .delete()
            .eq('client_id', _clientId!);
      }
    } catch (e) {
      debugPrint('Error clearing notifications: $e');
    }
  }

  /// Get unread count
  int get unreadCount {
    return state.value?.where((n) => !n.isRead).length ?? 0;
  }

  /// Filter notifications by type
  List<NotificationModel> filterByType(NotificationType type) {
    return state.value?.where((n) => n.type == type).toList() ?? [];
  }

  /// Refresh notifications
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

void debugPrint(String message) {
  print('[NotificationProvider] $message');
}
