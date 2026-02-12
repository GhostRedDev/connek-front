import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';

class LeadTimeline extends StatelessWidget {
  final Lead lead;

  const LeadTimeline({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    // Define steps based on Lead status
    final steps = <Map<String, dynamic>>[
      {
        'title': 'Nuevo lead',
        'time': lead.createdAt,
        'isActive': true,
        'isCompleted': true,
      },
      {
        'title': lead.seen ? 'Visto' : 'Por revisar',
        'time': lead.seen
            ? lead.createdAt.add(const Duration(minutes: 5))
            : null, // Mock time or real if available
        'isActive': lead.seen,
        'isCompleted': lead.seen,
      },
      {
        'title': lead.clientContacted ? 'Contactado' : 'Por contactar',
        'time': null,
        'isActive': lead.clientContacted,
        'isCompleted': lead.clientContacted,
      },
      {
        'title': lead.proposalSent ? 'Propuesta Enviada' : 'Enviar Propuesta',
        'time': null,
        'isActive': lead.proposalSent,
        'isCompleted': lead.proposalSent,
      },
      {
        'title': lead.bookingMade ? 'Agendado' : 'Por Agendar',
        'time': null,
        'isActive': lead.bookingMade,
        'isCompleted': lead.bookingMade,
      },
      {
        'title': lead.paymentMade ? 'Pagado' : 'Pendiente de Pago',
        'time': null,
        'isActive': lead.paymentMade,
        'isCompleted': lead.paymentMade,
      },
      if (lead.status == 'completed')
        {
          'title': 'Completado',
          'time': null,
          'isActive': true,
          'isCompleted': true,
        },
      if (lead.status == 'cancelled')
        {
          'title': 'Cancelado',
          'time': null,
          'isActive': true,
          'isCompleted': true,
          'isError': true,
        },
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, size: 16, color: Colors.blue[900]),
              const SizedBox(width: 8),
              AppText.h4(
                "Línea de tiempo",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;
            return _buildTimelineStep(
              context,
              step['title'] as String,
              step['time'] as DateTime?,
              step['isActive'] as bool,
              isLast,
              isError: step['isError'] == true,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    BuildContext context,
    String title,
    DateTime? time,
    bool isActive,
    bool isLast, {
    bool isError = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isError ? Colors.red : Colors.blue;
    final activeBg = isError
        ? Colors.red.withOpacity(0.1)
        : (isDark ? Colors.blue.withOpacity(0.1) : Colors.blue[50]);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                isActive ? Icons.check_circle : Icons.circle_outlined,
                color: isActive ? activeColor : Colors.grey[300],
                size: 20,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isActive ? activeColor : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? activeBg : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isActive ? activeColor : Colors.grey,
                    ),
                  ),
                  if (time != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
