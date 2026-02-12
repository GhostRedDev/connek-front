import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientRequestCard extends StatelessWidget {
  final String title; // "James Brown"
  final String status; // "Pending", "Completed", etc.
  final String description; // "Quiero cotizar..."
  final String date; // "27 ene 2026"
  final String time; // "10:00 AM"
  final String businessName; // "AR Labs & Vision"
  final String? avatarUrl; // User/Business Avatar

  const ClientRequestCard({
    super.key,
    required this.title,
    required this.status,
    required this.description,
    required this.date,
    required this.time,
    required this.businessName,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? const Color(0xFF1E2429)
        : Colors.grey[50]; // Lighter background for card
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[600];

    // Status Colors
    Color statusBg;
    Color statusText;
    IconData? statusIcon;
    String statusLabel = status;

    switch (status.toLowerCase()) {
      case 'pending':
      case 'pendiente':
        statusBg = const Color(0xFFFFF8E1); // Light Yellow
        statusText = const Color(0xFFF9A825); // Dark Yellow
        statusIcon = Icons.access_time_rounded;
        statusLabel = 'Pendiente';
        break;
      case 'completed':
      case 'completado':
      case 'completada':
        statusBg = const Color(0xFFE3F2FD); // Light Blue
        statusText = const Color(0xFF1565C0); // Dark Blue
        statusIcon = Icons.check_circle_outline;
        statusLabel = 'Completada';
        break;
      case 'cancelled':
      case 'cancelada':
      case 'cancelado':
        statusBg = const Color(0xFFFFEBEE); // Light Red
        statusText = const Color(0xFFC62828); // Dark Red
        statusIcon = Icons.cancel_outlined;
        statusLabel = 'Cancelada';
        break;
      default:
        statusBg = Colors.grey[200]!;
        statusText = Colors.grey[800]!;
        statusIcon = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20), // More rounded
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.transparent : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Name + Status + Menu
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? const Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                        size: 20,
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Name
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 14, color: statusText),
                    const SizedBox(width: 4),
                    Text(
                      statusLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Menu
              Icon(Icons.more_vert, size: 20, color: subTextColor),
            ],
          ),

          const SizedBox(height: 16),

          // Description Bubble
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.transparent : Colors.grey.shade100,
              ),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: textColor.withOpacity(0.8),
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 16),

          // Footer info
          Row(
            children: [
              // Date
              Icon(
                Icons.calendar_today_outlined,
                size: 16, // Slightly larger
                color: subTextColor,
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: subTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),

              // Time
              Icon(Icons.access_time, size: 16, color: subTextColor),
              const SizedBox(width: 6),
              Text(
                time,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: subTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              // Business Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Para',
                    style: GoogleFonts.inter(fontSize: 10, color: subTextColor),
                  ),
                  Text(
                    businessName,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
