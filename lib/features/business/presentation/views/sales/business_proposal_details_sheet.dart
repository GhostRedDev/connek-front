import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BusinessProposalDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> quote;

  const BusinessProposalDetailsSheet({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1D21) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    // Extract Data
    final description = quote['description'] ?? 'Sin descripción';
    final amountCents = quote['amountCents'] ?? 0;
    final amount = NumberFormat.currency(
      symbol: '\$',
    ).format(amountCents / 100);
    final status = quote['status'] ?? 'pending';

    final createdStr = quote['created_at'];
    final createdDate = createdStr != null
        ? DateTime.tryParse(createdStr)
        : null;
    final formattedCreated = createdDate != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(createdDate)
        : '-';

    final expiringStr = quote['expiring'];
    final expiringDate = expiringStr != null
        ? DateTime.tryParse(expiringStr)
        : null;
    final formattedExpiring = expiringDate != null
        ? DateFormat('dd MMM yyyy').format(expiringDate)
        : '-';

    // Leads/Client Data
    final leads = quote['leads'];
    final client = leads != null ? leads['client'] : null;
    final clientName = client != null
        ? '${client['first_name'] ?? ''} ${client['last_name'] ?? ''}'.trim()
        : 'Cliente Desconocido';

    // Resolve Image - logic copied from widget or passed down?
    // Usually the provider resolves it. If it's a URL it works.
    String? clientImage = client != null
        ? (client['photo_id'] ??
              client['profile_url'] ??
              client['profile_image'])
        : null;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 8,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle Bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, size: 20, color: textColor),
                ),
              ),
              Text(
                'Detalles de Propuesta',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 40), // Spacer
            ],
          ),
          const SizedBox(height: 24),

          // Content
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: clientImage != null
                              ? CachedNetworkImageProvider(clientImage)
                              : null,
                          child: clientImage == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cliente',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                clientName,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildDetailRow('Estado', status, textColor, isStatus: true),
                  const Divider(height: 32),
                  _buildDetailRow(
                    'Monto',
                    amount,
                    const Color(0xFF4285F4),
                    isBold: true,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailInfo('Descripción', description, textColor),
                  const SizedBox(height: 16),
                  _buildDetailRow('Creado', formattedCreated, textColor),
                  const SizedBox(height: 16),
                  _buildDetailRow('Expira', formattedExpiring, textColor),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    Color color, {
    bool isStatus = false,
    bool isBold = false,
    double fontSize = 14,
  }) {
    Color? statusColor;
    Color? statusBg;
    if (isStatus) {
      switch (value.toLowerCase()) {
        case 'accepted':
          statusColor = const Color(0xFF4285F4);
          statusBg = const Color(0xFFE3F2FD);
          value = 'Aceptada';
          break;
        case 'pending':
          statusColor = const Color(0xFFF9A825);
          statusBg = const Color(0xFFFFF8E1);
          value = 'Pendiente';
          break;
        default:
          statusColor = Colors.grey;
          statusBg = Colors.grey[200];
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey, fontSize: 14)),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        else
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
      ],
    );
  }

  Widget _buildDetailInfo(String label, String value, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.inter(color: textColor, fontSize: 14)),
      ],
    );
  }
}
