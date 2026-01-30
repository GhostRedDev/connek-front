import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Added
import '../../../core/providers/locale_provider.dart';
import '../../shared/models/booking_model.dart';
import '../../shared/providers/booking_provider.dart';
import '../providers/business_provider.dart'; // Added for Client/Service list

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
              Text(
                t['business_bookings_title'] ?? 'Reservas',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateBookingSheet(context),
                icon: const Icon(Icons.add, size: 18),
                label: Text(t['business_bookings_register'] ?? 'Registrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? Colors.white
                      : const Color(0xFF111315),
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            t['business_bookings_subtitle'] ??
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
                hintText:
                    t['business_bookings_search_hint'] ??
                    'Buscar reservaciones',
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
                _buildFilterChip(t['business_status_all'] ?? 'Todos'),
                const SizedBox(width: 8),
                _buildFilterChip(
                  t['business_status_upcoming'] ?? 'Próximas',
                ), // Confirmed/Pending
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
              // Filter Logic
              final filtered = bookings.where((bk) {
                if (_selectedFilter == (t['business_status_all'] ?? 'Todos'))
                  return true;
                if (_selectedFilter ==
                    (t['business_status_upcoming'] ?? 'Próximas')) {
                  return bk.status == BookingStatus.confirmed ||
                      bk.status == BookingStatus.pending;
                }
                if (_selectedFilter ==
                    (t['business_status_completed'] ?? 'Completada'))
                  return bk.status == BookingStatus.completed;
                if (_selectedFilter ==
                    (t['business_status_cancelled'] ?? 'Canceladas'))
                  return bk.status == BookingStatus.cancelled;
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    t['business_bookings_empty'] ?? 'No bookings found.',
                  ),
                );
              }

              return Column(
                children: filtered
                    .map((bk) => _buildBookingCard(bk, isDark, cardColor, t))
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

  Widget _buildBookingCard(
    BookingModel bk,
    bool isDark,
    Color cardColor,
    Map<String, dynamic> t,
  ) {
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
                    _getLocalizedStatus(bk.status, t),
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
                      Expanded(
                        child: Column(
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              bk.client.role, // "Cliente"
                              style: GoogleFonts.inter(
                                color: Colors.grey[600],
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
                          bk.agent.image,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
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
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              bk.agent.role, // "Agente asignado"
                              style: GoogleFonts.inter(
                                color: Colors.grey[600],
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

  void _showCreateBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CreateBookingSheet(),
    );
  }
}

class _CreateBookingSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CreateBookingSheet> createState() =>
      _CreateBookingSheetState();
}

class _CreateBookingSheetState extends ConsumerState<_CreateBookingSheet> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedClientId;
  int? _selectedServiceId;

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final businessData = ref.watch(businessProvider).value;
    final clients = businessData?.clients ?? [];
    final services = businessData?.services ?? [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t['business_bookings_new_title'] ?? 'Nueva Reserva',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Dropdown
                  Text(
                    t['business_bookings_client_label'] ?? 'Cliente',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    items: clients.map((c) {
                      return DropdownMenuItem<int>(
                        value: c['client']['id'],
                        child: Text(
                          '${c['client']['first_name']} ${c['client']['last_name']}',
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedClientId = val),
                    hint: Text(
                      t['business_bookings_client_hint'] ??
                          'Seleccionar Cliente',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Service Dropdown
                  Text(
                    t['business_bookings_service_label'] ?? 'Servicio',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    items: services.map((s) {
                      return DropdownMenuItem<int>(
                        value: s['id'],
                        child: Text(s['name']),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedServiceId = val),
                    hint: Text(
                      t['business_bookings_service_hint'] ??
                          'Seleccionar Servicio',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date & Time
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['business_bookings_date_label'] ?? 'Fecha',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (date != null)
                                  setState(() => _selectedDate = date);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      _selectedDate == null
                                          ? (t['business_bookings_select'] ??
                                                'Seleccionar')
                                          : DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(_selectedDate!),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['business_bookings_time_label'] ?? 'Hora',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null)
                                  setState(() => _selectedTime = time);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      _selectedTime == null
                                          ? (t['business_bookings_select'] ??
                                                'Seleccionar')
                                          : _selectedTime!.format(context),
                                    ),
                                  ],
                                ),
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
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  (_selectedClientId != null &&
                      _selectedServiceId != null &&
                      _selectedDate != null &&
                      _selectedTime != null)
                  ? () async {
                      final date = DateTime(
                        _selectedDate!.year,
                        _selectedDate!.month,
                        _selectedDate!.day,
                        _selectedTime!.hour,
                        _selectedTime!.minute,
                      );

                      final success = await ref
                          .read(bookingUpdateProvider)
                          .createManualBooking(
                            clientId: _selectedClientId!,
                            serviceId: _selectedServiceId!,
                            date: date,
                          );

                      if (success && context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Reserva creada con éxito'),
                          ),
                        );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF111315),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Confirmar Reserva'),
            ),
          ),
        ],
      ),
    );
  }
}
