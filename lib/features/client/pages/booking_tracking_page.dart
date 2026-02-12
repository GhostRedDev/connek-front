import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../shared/models/booking_model.dart';
import '../../../core/providers/locale_provider.dart';

class BookingTrackingPage extends ConsumerStatefulWidget {
  final String bookingId;
  final BookingModel? booking; // specific or fetched

  const BookingTrackingPage({super.key, required this.bookingId, this.booking});

  @override
  ConsumerState<BookingTrackingPage> createState() =>
      _BookingTrackingPageState();
}

class _BookingTrackingPageState extends ConsumerState<BookingTrackingPage> {
  // Simulating real-time updates for demonstration
  late BookingModel _currentBooking;

  @override
  void initState() {
    super.initState();
    // If booking is passed, use it. Otherwise, we'd fetch it.
    // Here we'll mock some data if null or just use passed.
    _currentBooking =
        widget.booking ??
        BookingModel(
          id: widget.bookingId,
          title: 'Limpieza de Hogar',
          type: 'Servicio',
          status: BookingStatus.in_progress,
          date: DateTime.now(),
          timeRange: '10:00 - 12:00',
          location: 'Av. Reforma 123, CDMX',
          price: 150.0,
          client: const BookingParticipant(
            id: 'c1',
            name: 'Juan Perez',
            role: 'Cliente',
            image: 'https://i.pravatar.cc/150?u=c1',
          ),
          agent: const BookingParticipant(
            id: 'a1',
            name: 'Maria Lopez',
            role: 'Profesional',
            image: 'https://i.pravatar.cc/150?u=a1',
          ),
          team: [
            const BookingParticipant(
              id: 'a2',
              name: 'Carlos Ruiz',
              role: 'Asistente',
              image: 'https://i.pravatar.cc/150?u=a2',
            ),
          ],
          serviceName: 'Limpieza Profunda',
          serviceImage:
              'https://images.unsplash.com/photo-1581578731117-104f2a9d454c?auto=format&fit=crop&q=80',
          progress: 0.65,
          qualityScore: 0,
          logs: [
            BookingLog(
              timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
              message: 'El equipo ha llegado al domicilio.',
              stage: 'Arrived',
            ),
            BookingLog(
              timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
              message: 'Iniciando inspección inicial.',
              stage: 'Started',
            ),
            BookingLog(
              timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
              message: 'Limpieza de sala y comedor completada.',
              stage: 'In Progress',
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t['booking_tracking_title'] ?? 'Monitoreo de Servicio',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Map Placeholder / Live Status Header
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://static.vecteezy.com/system/resources/previews/000/153/588/original/vector-city-map.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_shipping,
                        color: Color(0xFF4285F4),
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'En Progreso',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 4),
                            ],
                          ),
                        ),
                        Text(
                          'Estimated completion: 12:00 PM',
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Progress Stepper
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildProgressStepper(_currentBooking.progress),
            ),
            const SizedBox(height: 24),

            // 3. Current Task / Status Logic
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Actividad Reciente',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  if (_currentBooking.logs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('No hay actividad registrada.'),
                    )
                  else
                    ..._currentBooking.logs.map((log) => _buildLogItem(log)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4. Team Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Personal Asignado',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 90,
              padding: const EdgeInsets.only(left: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTeamMember(_currentBooking.agent),
                  ..._currentBooking.team.map((m) => _buildTeamMember(m)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 5. Quality / Feedback Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF4285F4).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: const Color(0xFF4285F4),
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Garantía de Calidad',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xFF4285F4),
                          ),
                        ),
                        Text(
                          'Monitoreamos cada paso para asegurar el mejor servicio.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF4285F4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStepper(double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progreso',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
          ),
        ),
      ],
    );
  }

  Widget _buildLogItem(BookingLog log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              Container(width: 2, height: 30, color: Colors.grey.shade200),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.message,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(log.timestamp),
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(BookingParticipant person) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: CachedNetworkImageProvider(person.image),
          ),
          const SizedBox(height: 4),
          Text(
            person.name.split(' ')[0],
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
