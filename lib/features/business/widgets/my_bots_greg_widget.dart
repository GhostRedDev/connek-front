import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyBotsGregWidget extends StatelessWidget {
  final Map<String, dynamic>? employee;
  const MyBotsGregWidget({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final e =
        employee ??
        {
          'name': 'Greg',
          'role': 'Asistente IA',
          'tag': 'Finanzas',
          'status': 'Active',
          'image': 'https://i.pravatar.cc/150?u=Greg', // Fallback
        };

    return Container(
      width: 160,
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.amber, size: 10),
                    const SizedBox(width: 2),
                    Text(
                      e['tag'] ?? 'AI',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  e['status'] ?? 'Active',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Fallback if no image
          (e['image'] != null)
              ? CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(e['image']),
                  radius: 35,
                )
              : CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: Text(
                    'No\nImage',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
                  ),
                ),
          const SizedBox(height: 12),
          Text(
            e['name'] ?? 'Bot',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark ? Colors.white : const Color(0xFF1A1D21),
            ),
          ),
          Text(
            e['role'] ?? 'Assistant',
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 10),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Entrenar',
              style: GoogleFonts.inter(
                color: const Color(0xFF4285F4),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
