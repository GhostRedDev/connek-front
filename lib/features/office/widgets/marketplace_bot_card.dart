import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketplaceBotCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final int userCount;
  final String price;
  final List<String> tags;

  const MarketplaceBotCard({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.rating = 4.8,
    this.ratingCount = 1300,
    this.userCount = 5400,
    this.price = '\$0',
    this.tags = const ['Respuesta instantánea', '24/7', 'Multi-idioma'],
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? const Color(0xFF131619)
        : Colors.white; // Darker bg for card
    final textColor = Theme.of(context).colorScheme.onSurface;
    final subTextColor =
        Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Dark Blue Gradient for Card
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF161B22), const Color(0xFF0D1117)]
              : [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor,
                ], // Use card color for light mode
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? const Color(0xFF4285F4).withOpacity(0.1)
              : Theme.of(context).dividerColor.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Image & Name
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/GREG_CARD_1.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF4285F4,
                      ).withOpacity(0.4), // Blue glow
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: subTextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) => _buildTag(context, tag)).toList(),
          ),

          const SizedBox(height: 24),
          Divider(color: isDark ? Colors.white10 : Colors.black12),
          const SizedBox(height: 16),

          // Footer: Stats & Price & Button
          Row(
            children: [
              // Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: const Color(0xFF4285F4),
                      ), // Blue
                      const SizedBox(width: 4),
                      Text(
                        '${(userCount / 1000).toStringAsFixed(1)}k',
                        style: GoogleFonts.inter(
                          color: subTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: const Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$rating ($ratingCount)',
                        style: GoogleFonts.inter(
                          color: subTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4285F4), // Blue Price
                          ),
                        ),
                        TextSpan(
                          text: '/mes',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: subTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Action Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement hire action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4285F4), // Light Blue
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: const Color(0xFF4285F4).withOpacity(0.5),
                  elevation: 4,
                ),
                child: Text(
                  'Contratar',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF39D2C0).withOpacity(0.1), // Green tint
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF39D2C0).withOpacity(0.5), // Green border
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.flash_on_rounded,
            size: 12,
            color: Color(0xFF39D2C0), // Green Icon
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              color: const Color(0xFF39D2C0), // Green Text
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
