import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCardWidget extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCardWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final title = event['title'] ?? 'Evento';
    final description = event['description'] ?? '';
    final image =
        event['image'] ??
        'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?ixlib=rb-4.0.3';
    final promoText = event['promo_text'] ?? 'PROMOCIÓN';

    // Parse date if needed, or use a duration string
    // For now assuming promo_text covers the "Finaliza en..." or we show static

    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.timer, color: Colors.white, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'Ver detalles', // Generic for now
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promoText.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (description.isNotEmpty)
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
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
