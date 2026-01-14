import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientLeadCardWidget extends StatelessWidget {
  final Map<String, dynamic> lead;
  const ClientLeadCardWidget({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Adaptive bg
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image:
              (lead['image'] != null &&
                  lead['image'].toString().startsWith('http'))
              ? NetworkImage(lead['image'])
              : const AssetImage('assets/images/placeholder_user.png')
                    as ImageProvider,
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            // Fail silently
          },
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Labels
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D21).withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Lead',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF00C853),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '\$${lead['amount']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Name and Role
          Positioned(
            bottom: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead['role'],
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 10),
                ),
                Text(
                  lead['name'],
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
