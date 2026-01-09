import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../leads/models/lead_model.dart';

class LeadCardInfoWidget extends StatelessWidget {
  final Lead lead;
  const LeadCardInfoWidget({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final name = '${lead.clientFirstName} ${lead.clientLastName}'.trim();
    final role = 'Cliente';
    // Logic for amount
    final amount = (lead.requestBudgetMax ?? 0) / 100.0;

    final image = lead.clientImageUrl;
    final status = lead.status;
    final description = lead.requestDescription.isNotEmpty
        ? lead.requestDescription
        : 'Solicitud de servicio...';

    // Time logic - very simple for now, using a helper or just checking date
    final diff = DateTime.now().difference(lead.createdAt);
    String timeStr = 'Reciente';
    if (diff.inDays > 0)
      timeStr = '${diff.inDays}d';
    else if (diff.inHours > 0)
      timeStr = '${diff.inHours}h';
    else
      timeStr = '${diff.inMinutes}m';

    Color statusColor;
    Color statusBgColor;
    // Map backend status to UI colors
    switch (status) {
      case 'completed':
      case 'converted': // Assuming 'converted' might be used
        statusColor = const Color(0xFF4285F4);
        statusBgColor = const Color(0xFFE3F2FD);
        break;
      case 'cancelled':
      case 'declined':
        statusColor = const Color(0xFFFF5252);
        statusBgColor = const Color(0xFFFFEBEE);
        break;
      case 'pending':
      default:
        statusColor = const Color(0xFFFB8C00);
        statusBgColor = const Color(0xFFFFF3E0);
        break;
    }

    // Friendly status text
    String statusText = status;
    if (status == 'pending') statusText = 'Pendiente';
    if (status == 'completed') statusText = 'Completado';
    if (status == 'cancelled') statusText = 'Cancelado';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: image ?? '',
                imageBuilder: (context, imageProvider) =>
                    CircleAvatar(backgroundImage: imageProvider, radius: 24),
                placeholder: (context, url) => const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.black,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      name.isNotEmpty ? name : 'Unknown',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : const Color(0xFF1A1D21),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    timeStr,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E20),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
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
