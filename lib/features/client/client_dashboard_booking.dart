import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../shared/models/booking_model.dart';
import '../shared/providers/booking_provider.dart';
import '../../core/providers/locale_provider.dart';
import 'widgets/client_booking_card.dart';

class ClientDashboardBooking extends ConsumerWidget {
  const ClientDashboardBooking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Consume Shared Provider as 'client'
    final bookingsAsync = ref.watch(bookingListProvider('client'));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Style constants
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final cardColor = isDark ? const Color(0xFF1E2429) : Colors.white;

    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bookings',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View and manage your bookings',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar reservaciones',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF131619)
                        : Colors.grey[100], // Darker input bg
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white12 : Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  style: GoogleFonts.inter(fontSize: 14, color: textColor),
                ),

                const SizedBox(height: 16),

                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Todos', true, isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('Proximas', false, isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('Completadas', false, isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('Canceladas', false, isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: bookingsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text('Error: $err')),
              data: (bookings) {
                if (bookings.isEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Calendar Icon
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 80,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            const SizedBox(height: 24),

                            Text(
                              "You don't have any bookings yet",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Bookings will appear here once you book a service",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Search Services Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to Search or Home
                                  context.go('/');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "Search services",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: bookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return _buildBookingCard(context, booking);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark ? const Color(0xFF333333) : Colors.black87)
            : (isDark ? const Color(0xFF1E2429) : Colors.grey[200]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : (isDark ? Colors.white10 : Colors.transparent),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, BookingModel booking) {
    // Format helpers
    final dateFormat = DateFormat('d MMM yyyy', 'es');

    return GestureDetector(
      onTap: () {
        context.push('/client/dashboard/booking/${booking.id}');
      },
      child: ClientBookingCard(
        title: booking.serviceName,
        status: booking.status.label, // "Pending" -> "Próxima" ideally
        id: "BK${booking.id.replaceAll(RegExp(r'[^0-9]'), '').padLeft(3, '0')}",
        format: "Llamada", // This info (Format) ideally comes from ServiceType
        date: dateFormat.format(booking.date),
        time: booking.timeRange.contains("-")
            ? booking.timeRange.split("-").first.trim()
            : (booking.timeRange == 'Por definir'
                  ? '10:00'
                  : booking.timeRange), // Fallback
        duration: "30 min", // Hardcoded for now as it's not in model
        price: booking.price,
        clientName: booking.client.name,
        clientImage: booking.client.image.isNotEmpty
            ? booking.client.image
            : null,
        agentName: booking.agent.name,
        agentImage: booking.agent.image.isNotEmpty ? booking.agent.image : null,
      ),
    );
  }
}
