import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../../features/notifications/data/models/notification_model.dart';
import '../../features/notifications/presentation/providers/notification_provider.dart';
import '../../features/notifications/presentation/widgets/notification_item.dart';

class BookingDetailsPage extends ConsumerWidget {
  final String bookingId;
  final bool isClientView;

  const BookingDetailsPage({
    super.key,
    required this.bookingId,
    required this.isClientView,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingDetailsProvider(bookingId));
    final notificationsAsync = ref.watch(notificationProvider);
    final bookingNotifications = (notificationsAsync.value ?? []).where((n) {
      if (n.type != NotificationType.booking) return false;
      final dataId = n.data?['booking_id']?.toString();
      if (dataId == null) return false;
      // Check if bookingId (e.g., BK123) contains the numeric ID (e.g., 123)
      return bookingId.contains(dataId);
    }).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF111315)
          : const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          'Detalles de Reserva',
          style: GoogleFonts.inter(fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: bookingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (booking) {
          if (booking == null) {
            return const Center(child: Text('Reserva no encontrada'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header Card
                _buildHeaderCard(context, booking, isDark),
                const SizedBox(height: 20),

                // Contact & Location Card
                _buildContactAndLocationCard(context, booking, isDark),
                const SizedBox(height: 20),
                const SizedBox(height: 20),

                // Participants Card
                _buildParticipantsCard(context, booking, isDark),
                const SizedBox(height: 20),

                // Custom Form Answers
                if (booking.customFormAnswers != null &&
                    booking.customFormAnswers!.isNotEmpty) ...[
                  _buildCustomAnswersCard(context, booking, isDark),
                  const SizedBox(height: 20),
                ],

                // Payment Info
                _buildPaymentInfo(context, booking, isDark),
                const SizedBox(height: 30),

                // Notifications / Timeline
                if (bookingNotifications.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Actividad',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...bookingNotifications.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NotificationItem(notification: n),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Actions
                if (booking.status != BookingStatus.cancelled &&
                    booking.status != BookingStatus.completed)
                  _buildActions(context, ref, booking),

                if (booking.status == BookingStatus.completed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _showRebookDialog(context, ref, booking),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4285F4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Reservar Nuevamente'),
                      ),
                    ),
                  ),

                if (booking.status == BookingStatus.cancelled ||
                    booking.status == BookingStatus.completed)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _deleteBooking(context, ref, booking),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Eliminar Historial'),
                    ),
                  ),

                if (booking.status == BookingStatus.cancelled)
                  // ... existing info container ...
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.red),
                        const SizedBox(height: 8),
                        Text(
                          'Reserva Cancelada',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'El reembolso ha sido procesado a tu método de pago original.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.red[800],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, BookingModel bk, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: bk.serviceImage,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.spa, size: 40, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            bk.title,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(bk.id, style: GoogleFonts.inter(color: Colors.grey)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildStatusPill(bk.status)],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoItem(
                Icons.calendar_month,
                DateFormat('MMM d, y').format(bk.date),
              ),
              Container(
                width: 1,
                height: 30,
                color: Colors.grey.withOpacity(0.3),
              ),
              _buildInfoItem(Icons.access_time, bk.timeRange),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildInfoItem(
            Icons.attach_money,
            '\$${bk.price.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF4285F4)),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildStatusPill(BookingStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: GoogleFonts.inter(
          color: status.color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildParticipantsCard(
    BuildContext context,
    BookingModel bk,
    bool isDark,
  ) {
    final target = isClientView ? bk.agent : bk.client;
    final label = isClientView ? 'Proveedor del Servicio' : 'Cliente';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(target.image),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  target.name,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  target.role,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF4285F4),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              if (isClientView) {
                context.push('/client/business/${target.id}');
              }
              // If business view, could go to client profile
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(BuildContext context, BookingModel bk, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Pagado', style: GoogleFonts.inter(fontSize: 14)),
          Text(
            '\$${bk.price.toStringAsFixed(2)}',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, BookingModel bk) {
    if (!isClientView) {
      return _buildBusinessActions(context, ref, bk);
    }

    return Column(
      children: [
        if (bk.status == BookingStatus.confirmed ||
            bk.status == BookingStatus.in_progress) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () =>
                  context.push('/client/dashboard/booking/tracking/${bk.id}'),
              icon: const Icon(Icons.map, size: 20),
              label: const Text('Seguimiento en Vivo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF34A853,
                ), // Green for active action
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: const Color(0xFF34A853).withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showRescheduleDialog(context, ref, bk),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4285F4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Reprogramar Cita'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => _cancelBooking(context, ref, bk),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Cancelar Reserva'),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessActions(
    BuildContext context,
    WidgetRef ref,
    BookingModel bk,
  ) {
    return Column(
      children: [
        if (bk.status == BookingStatus.confirmed ||
            bk.status == BookingStatus.in_progress) ...[
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.push('/business/tracking/${bk.id}'),
              icon: const Icon(Icons.monitor_heart_outlined, size: 20),
              label: const Text('Monitorear Servicio'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4285F4),
                side: const BorderSide(color: Color(0xFF4285F4)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (bk.status == BookingStatus.pending) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _confirmBooking(context, ref, bk),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Aceptar Reserva'),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (bk.status == BookingStatus.confirmed) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _startService(context, ref, bk),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34A853),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Iniciar Servicio'),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (bk.status == BookingStatus.in_progress) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _completeBooking(context, ref, bk),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Completar Cita'),
            ),
          ),
          const SizedBox(height: 12),
        ],
        // Cancel Option
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => _cancelBooking(context, ref, bk),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Cancelar / Rechazar'),
          ),
        ),
      ],
    );
  }

  void _showRescheduleDialog(
    BuildContext context,
    WidgetRef ref,
    BookingModel bk,
  ) async {
    final now = DateTime.now();
    final initialDate = bk.date.isBefore(now) ? now : bk.date;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (pickedDate != null && context.mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(bk.date),
      );

      if (pickedTime != null && context.mounted) {
        final role = isClientView ? 'client' : 'business';
        await ref
            .read(bookingUpdateProvider)
            .reschedule(
              bk.id,
              DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              ),
              "${pickedTime.format(context)} • 30 min",
              role,
            );
      }
    }
  }

  void _showRebookDialog(
    BuildContext context,
    WidgetRef ref,
    BookingModel bk,
  ) async {
    // Similar to reschedule but calls rebook endpoint
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (pickedDate != null && context.mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 10, minute: 0),
      );

      if (pickedTime != null && context.mounted) {
        final role = isClientView ? 'client' : 'business';
        // Rebook calls provider
        final success = await ref
            .read(bookingUpdateProvider)
            .rebook(
              bk.id,
              // Date
              pickedDate,
              // Start Time
              "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}",
              // End Time (Assuming +1 hour or similar, simplified)
              "${(pickedTime.hour + 1) % 24}:${pickedTime.minute.toString().padLeft(2, '0')}",
              role,
            );
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reserva creada exitosamente')),
          );
        }
      }
    }
  }

  void _deleteBooking(BuildContext context, WidgetRef ref, BookingModel bk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar Reserva?'),
        content: const Text(
          'Esta acción eliminará la reserva de tu historial permanentemente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final role = isClientView ? 'client' : 'business';
              final success = await ref
                  .read(bookingUpdateProvider)
                  .deleteBooking(bk.id, role);
              if (success && context.mounted) {
                Navigator.pop(context); // Exit details page
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(BuildContext context, WidgetRef ref, BookingModel bk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Cancelar Reserva?'),
        content: const Text(
          'Se iniciará el reembolso inmediato a tu cuenta. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Volver'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final role = isClientView ? 'client' : 'business';
              await ref.read(bookingUpdateProvider).cancelBooking(bk.id, role);
            },
            child: const Text(
              'Confirmar Cancelación',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmBooking(BuildContext context, WidgetRef ref, BookingModel bk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Aceptar Reserva?'),
        content: const Text(
          'El cliente recibirá una notificación de confirmación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref
                  .read(bookingUpdateProvider)
                  .confirmBooking(bk.id, 'business'); // Pass business role
            },
            child: const Text('Aceptar', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _startService(BuildContext context, WidgetRef ref, BookingModel bk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Iniciar Servicio?'),
        content: const Text(
          'Esto indicará que el cliente está siendo atendido.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref
                  .read(bookingUpdateProvider)
                  .startService(bk.id, 'business');
            },
            child: const Text('Iniciar', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _completeBooking(BuildContext context, WidgetRef ref, BookingModel bk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Completar Cita?'),
        content: const Text('Esta acción marcará la cita como finalizada.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref
                  .read(bookingUpdateProvider)
                  .completeBooking(bk.id, 'business');
            },
            child: const Text(
              'Completar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactAndLocationCard(
    BuildContext context,
    BookingModel bk,
    bool isDark,
  ) {
    // If client view, contact agent (business). If business view, contact client.
    final target = isClientView ? bk.agent : bk.client;
    // Location is relevant for Client to go to Business or Business to go to Client
    // Usually Business Location unless house call.
    final location = bk.location;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contacto y Ubicación',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildContactButton(
                context,
                icon: Icons.chat_bubble_outline,
                label: 'Chat',
                onTap: () {
                  // Navigate to chat
                  // TODO: Implement Chat Navigation
                  // context.push('/chats/${target.id}');
                  // Current router structure /chats is list, /chats/:id is not standard yet?
                  // Assuming /chats/new or similar. For now just show toast or placeholder
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chat próximamente')),
                  );
                },
                color: const Color(0xFF4285F4),
              ),
              _buildContactButton(
                context,
                icon: Icons.phone_outlined,
                label: 'Llamar',
                onTap: () {
                  if (target.phone != null) {
                    launchUrl(Uri.parse('tel:${target.phone}'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Número no disponible')),
                    );
                  }
                },
                color: Colors.green,
              ),
              _buildContactButton(
                context,
                icon: Icons
                    .message_outlined, // WhatsApp icon usually custom, use message for now
                label: 'WhatsApp',
                onTap: () {
                  if (target.phone != null) {
                    // Normalize phone
                    final phone = target.phone!.replaceAll(
                      RegExp(r'[^0-9]'),
                      '',
                    );
                    launchUrl(Uri.parse('https://wa.me/$phone'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Número no disponible')),
                    );
                  }
                },
                color: const Color(0xFF25D366),
              ),
            ],
          ),
          if (location != null && location.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.red),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(location, style: GoogleFonts.inter(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Open maps
                  final query = Uri.encodeComponent(location);
                  launchUrl(
                    Uri.parse(
                      'https://www.google.com/maps/search/?api=1&query=$query',
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cómo llegar'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomAnswersCard(
    BuildContext context,
    BookingModel bk,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalles del Servicio',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          if (bk.customFormAnswers != null)
            ...bk.customFormAnswers!.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pregunta (ID: ${entry.key})',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.value.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
