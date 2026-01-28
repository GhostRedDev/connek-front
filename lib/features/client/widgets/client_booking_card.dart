import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientBookingCard extends StatelessWidget {
  final String title; // "Consulta de Ventas"
  final String status; // "Próxima"
  final String id; // "BK001"
  final String format; // "Llamada"
  final String date; // "27 ene 2026"
  final String time; // "10:00"
  final String duration; // "30 min"
  final double price; // 80.00
  final String clientName;
  final String? clientImage;
  final String agentName;
  final String? agentImage;

  const ClientBookingCard({
    super.key,
    required this.title,
    required this.status,
    required this.id,
    required this.format,
    required this.date,
    required this.time,
    required this.duration,
    required this.price,
    required this.clientName,
    this.clientImage,
    required this.agentName,
    this.agentImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E2429) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[600];

    // Status Styling
    Color statusBg = const Color(0xFFFFF8E1); // Light Yellow default
    Color statusText = const Color(0xFFF9A825);
    if (status.toLowerCase().contains('cancel')) {
      statusBg = const Color(0xFFFFEBEE);
      statusText = const Color(0xFFC62828);
    } else if (status.toLowerCase().contains('complet')) {
      statusBg = const Color(0xFFE3F2FD);
      statusText = const Color(0xFF1565C0);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusText,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Subtitle (Format + ID)
          Padding(
            padding: const EdgeInsets.only(left: 28), // Align under title text
            child: Text(
              "$format • $id",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Date | Time | Price
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 16,
                color: subTextColor,
              ),
              const SizedBox(width: 4),
              Text(
                date,
                style: GoogleFonts.inter(fontSize: 13, color: subTextColor),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: subTextColor),
              const SizedBox(width: 4),
              Text(
                "$time • $duration",
                style: GoogleFonts.inter(fontSize: 13, color: subTextColor),
              ),
              const Spacer(),
              Text(
                "\$${price.toStringAsFixed(2)}",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Footer: Avatars
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Client
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: clientImage != null
                          ? NetworkImage(clientImage!)
                          : null,
                      backgroundColor: Colors.grey[300],
                      child: clientImage == null
                          ? const Icon(Icons.person, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clientName,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "Cliente",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Agent
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: agentImage != null
                          ? NetworkImage(agentImage!)
                          : null,
                      backgroundColor: Colors.grey[300],
                      child: agentImage == null
                          ? const Icon(Icons.headset_mic, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          agentName,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "Agente asignado",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
