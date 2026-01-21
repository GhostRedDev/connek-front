import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Added
import '../../shared/models/booking_model.dart';
import '../../shared/providers/booking_provider.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final bookingsAsync = ref.watch(bookingListProvider('business'));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Reservas',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Encuentra a todos tus clientes activos.',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar reservaciones',
                hintStyle: GoogleFonts.inter(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Todos'),
                const SizedBox(width: 8),
                _buildFilterChip('Próximas'), // Confirmed/Pending
                const SizedBox(width: 8),
                _buildFilterChip('Completada'),
                const SizedBox(width: 8),
                _buildFilterChip('Canceladas'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Booking List
          bookingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('Error: $err')),
            data: (bookings) {
              // Filter Logic
              final filtered = bookings.where((bk) {
                final statusLabel = bk.status.label;
                if (_selectedFilter == 'Todos') return true;
                if (_selectedFilter == 'Próximas') {
                  return bk.status == BookingStatus.confirmed ||
                      bk.status == BookingStatus.pending;
                }
                if (_selectedFilter == 'Completada')
                  return bk.status == BookingStatus.completed;
                if (_selectedFilter == 'Canceladas')
                  return bk.status == BookingStatus.cancelled;
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return const Center(child: Text('No bookings found.'));
              }

              return Column(
                children: filtered
                    .map((bk) => _buildBookingCard(bk, isDark, cardColor))
                    .toList(),
              );
            },
          ),

          // Extra space
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BookingModel bk, bool isDark, Color cardColor) {
    final statusColor = bk.status.color;
    final statusBgColor = bk.status.color.withOpacity(
      0.15,
    ); // Slightly stronger

    return GestureDetector(
      onTap: () {
        context.push('/business/bookings/${bk.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E) // Match search bar
              : Colors.white,
          borderRadius: BorderRadius.circular(24), // More rounded
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            if (!isDark)
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
            // Header Row
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined, // Outlined
                  color: isDark
                      ? Colors.white
                      : Colors.black, // Design has black icon
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bk.title,
                    style: GoogleFonts.outfit(
                      // Outfit font for title
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20), // Pill shape
                  ),
                  child: Text(
                    bk.status.label,
                    style: GoogleFonts.inter(
                      color: statusColor,
                      fontSize: 11, // Small enough
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.more_vert, color: Colors.grey, size: 20),
              ],
            ),
            const SizedBox(height: 8),

            // Subtitle Row (Type • ID) & Location
            Row(
              children: [
                Text(
                  '${bk.type} • ',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4285F4),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  bk.id,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4285F4), // Both blue
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (bk.location != null) ...[
                  const SizedBox(width: 12), // More space
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 2),
                  Text(
                    bk.location!,
                    style: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            // const Divider(height: 1), // Design seemingly doesn't have dividers inside
            // const SizedBox(height: 16),

            // Date & Time
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Text(
                  // Date Format: "27 ene 2026"
                  DateFormat('d MMM y', 'es').format(bk.date),
                  style: GoogleFonts.inter(
                    color: Colors.grey[600], // Grey text
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[600],
                ), // Clock
                const SizedBox(width: 6),
                Text(
                  bk.timeRange, // "10:00 • 30 min"
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Spacing before participants
            // Participants Row (Grey background container?)
            // Design shows avatars on the card background.
            Row(
              children: [
                // Client
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20, // Slightly bigger
                        backgroundImage: CachedNetworkImageProvider(
                          bk.client.image,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bk.client.name,
                            style: GoogleFonts.outfit(
                              // Outfit
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF111315),
                            ),
                          ),
                          Text(
                            bk.client.role, // "Cliente"
                            style: GoogleFonts.inter(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                        ],
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
                          bk.agent.image,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bk.agent.name,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF111315),
                            ),
                          ),
                          Text(
                            bk.agent.role, // "Agente asignado"
                            style: GoogleFonts.inter(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                        ],
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
}
