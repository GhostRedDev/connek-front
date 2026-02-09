import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../providers/notification_provider.dart';
import '../../data/models/notification_model.dart';
// import '../../core/widgets/layout.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // AppBar is handled by Layout if we are in shell, but if pushed full screen:
      appBar: AppBar(
        title: Text(
          'Notificaciones',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // FILTERS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('All', 'Todos', isDark),
                const SizedBox(width: 8),
                _buildFilterChip('Messages', 'Mensajes', isDark),
                const SizedBox(width: 8),
                _buildFilterChip('Business', 'Negocio', isDark),
                const SizedBox(width: 8),
                _buildFilterChip('Bookings', 'Reservas', isDark),
                const SizedBox(width: 8),
                _buildFilterChip('System', 'Sistema', isDark),
              ],
            ),
          ),
          const Divider(height: 1),

          // LIST
          Expanded(
            child: notificationsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text('Error: $err')),
              data: (notifications) {
                final filtered = _filterNotifications(notifications);

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tienes notificaciones',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final notification = filtered[index];
                    return _NotificationTile(
                      notification: notification,
                      isDark: isDark,
                      onTap: () {
                        // Mark as read
                        ref
                            .read(notificationProvider.notifier)
                            .markAsRead(notification.id);

                        // 1. Try Action URL
                        if (notification.actionUrl != null &&
                            notification.actionUrl!.isNotEmpty) {
                          // Check for lead specific URL that might not exist in router
                          if (notification.actionUrl!.contains(
                            '/business/leads/',
                          )) {
                            context.push('/business/leads');
                            return;
                          }

                          try {
                            context.push(notification.actionUrl!);
                            return;
                          } catch (e) {
                            print('Nav error: $e');
                          }
                        }

                        // 2. Manual Handling by Type
                        final data = notification.data ?? {};

                        switch (notification.type) {
                          case NotificationType.chat:
                          case NotificationType.message:
                            final chatId = data['chatId'] ?? data['chat_id'];
                            if (chatId != null) {
                              context.push('/chats/$chatId');
                            } else {
                              context.push('/chats');
                            }
                            break;

                          case NotificationType.lead:
                            context.push('/business/leads');
                            break;

                          case NotificationType.booking:
                            final bookingId =
                                data['bookingId'] ?? data['booking_id'];
                            if (bookingId != null) {
                              context.push(
                                '/client/dashboard/booking/$bookingId',
                              );
                            } else {
                              context.push('/client/dashboard/booking');
                            }
                            break;

                          case NotificationType.payment:
                          case NotificationType.success:
                            context.push('/client/dashboard/wallet');
                            break;

                          case NotificationType.review:
                            context.push('/business/profile');
                            break;

                          default:
                            break;
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label, bool isDark) {
    final isSelected = _selectedFilter == key;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = key;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4285F4)
              : (isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: isDark ? Colors.white10 : Colors.grey.shade300,
                ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.grey[700]),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  List<NotificationModel> _filterNotifications(
    List<NotificationModel> notifications,
  ) {
    if (_selectedFilter == 'All') return notifications;

    return notifications.where((n) {
      if (_selectedFilter == 'Messages') {
        return n.type == NotificationType.chat ||
            n.type == NotificationType.message;
      }
      if (_selectedFilter == 'Business') {
        return n.type == NotificationType.lead ||
            n.type == NotificationType.review;
      }
      if (_selectedFilter == 'Bookings') {
        return n.type == NotificationType.booking;
      }
      if (_selectedFilter == 'System') {
        return ![
          NotificationType.chat,
          NotificationType.message,
          NotificationType.lead,
          NotificationType.review,
          NotificationType.booking,
        ].contains(n.type);
      }
      return true;
    }).toList();
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final bool isDark;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead
            ? (isDark ? Colors.white.withOpacity(0.02) : Colors.grey[100])
            : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead
              ? Colors.transparent
              : const Color(0xFF4285F4).withOpacity(0.3),
        ),
        boxShadow: notification.isRead
            ? []
            : [
                BoxShadow(
                  color: const Color(0xFF4285F4).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: notification.type == NotificationType.lead
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification.type == NotificationType.lead
                        ? Icons.person_add_rounded
                        : Icons.chat_bubble_rounded,
                    color: notification.type == NotificationType.lead
                        ? Colors.blue
                        : Colors.orange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
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
                              style: GoogleFonts.outfit(
                                fontWeight: notification.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                fontSize: 16,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('h:mm a').format(notification.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.body,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
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
}
