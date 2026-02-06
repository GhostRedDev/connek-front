import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/shared/models/booking_model.dart';
import 'package:connek_frontend/shared/providers/booking_provider.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/system_ui/layout/buttons.dart';
import 'package:connek_frontend/system_ui/form/inputs.dart'; // Ensure exists or use Shadcn directly
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../sheets/business_sheet_create_booking.dart';

class BusinessBookingsWidget extends ConsumerStatefulWidget {
  const BusinessBookingsWidget({super.key});

  @override
  ConsumerState<BusinessBookingsWidget> createState() =>
      _BusinessBookingsWidgetState();
}

class _BusinessBookingsWidgetState
    extends ConsumerState<BusinessBookingsWidget> {
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingsAsync = ref.watch(bookingListProvider('business'));
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h2(t['business_bookings_title'] ?? 'Reservas'),
              AppButton.outline(
                text: t['business_bookings_register'] ?? 'Registrar',
                icon: Icons.add,
                onPressed: () => _showCreateBookingSheet(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText.p(
            t['business_bookings_subtitle'] ??
                'Encuentra a todos tus clientes activos.',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Search
          AppInput.text(
            controller: _searchController,
            placeholder:
                t['business_bookings_search_hint'] ?? 'Buscar reservaciones',
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search, size: 18, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(t['business_status_all'] ?? 'Todos'),
                const SizedBox(width: 8),
                _buildFilterChip(t['business_status_upcoming'] ?? 'Próximas'),
                const SizedBox(width: 8),
                _buildFilterChip(
                  t['business_status_completed'] ?? 'Completada',
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  t['business_status_cancelled'] ?? 'Canceladas',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Booking List
          bookingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('Error: $err')),
            data: (bookings) {
              final filtered = bookings.where((bk) {
                if (_selectedFilter == (t['business_status_all'] ?? 'Todos'))
                  return true;
                if (_selectedFilter ==
                    (t['business_status_upcoming'] ?? 'Próximas')) {
                  return bk.status == BookingStatus.confirmed ||
                      bk.status == BookingStatus.pending;
                }
                if (_selectedFilter ==
                    (t['business_status_completed'] ?? 'Completada')) {
                  return bk.status == BookingStatus.completed;
                }
                if (_selectedFilter ==
                    (t['business_status_cancelled'] ?? 'Canceladas')) {
                  return bk.status == BookingStatus.cancelled;
                }
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: AppText.p(
                      t['business_bookings_empty'] ??
                          'No se encontraron reservas.',
                    ),
                  ),
                );
              }

              return Column(
                children: filtered
                    .map((bk) => _BookingCard(booking: bk, t: t))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final theme = ShadTheme.of(context);
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.muted,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.primaryForeground
                : theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  void _showCreateBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BusinessSheetCreateBooking(),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingModel booking;
  final Map<String, dynamic> t;

  const _BookingCard({required this.booking, required this.t});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final statusColor = booking.status.color;
    final statusBgColor = statusColor.withOpacity(0.15);

    return GestureDetector(
      onTap: () => context.push('/business/bookings/${booking.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.colorScheme.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: theme.colorScheme.foreground,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(child: AppText.h4(booking.title)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getLocalizedStatus(booking.status, t),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ID & Location
            Row(
              children: [
                Text(
                  '${booking.type} • ',
                  style: const TextStyle(
                    color: Color(0xFF4285F4),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  booking.id,
                  style: const TextStyle(
                    color: Color(0xFF4285F4),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (booking.location != null) ...[
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    booking.location!,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // Date & Time
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  DateFormat('d MMM y', 'es').format(booking.date),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  booking.timeRange,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Participants
            Row(
              children: [
                // Client
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                          booking.client.image,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.client.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              booking.client.role,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Agent
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                          booking.agent.image,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.agent.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              booking.agent.role,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getLocalizedStatus(BookingStatus status, Map<String, dynamic> t) {
    switch (status) {
      case BookingStatus.pending:
        return t['booking_status_pending'] ?? 'Pendiente';
      case BookingStatus.confirmed:
        return t['booking_status_confirmed'] ?? 'Próxima';
      case BookingStatus.completed:
        return t['booking_status_completed'] ?? 'Completada';
      case BookingStatus.cancelled:
        return t['booking_status_cancelled'] ?? 'Cancelada';
    }
  }
}
