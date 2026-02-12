import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../system_ui/data_display/badges.dart';
import '../../../system_ui/data_display/cards.dart';
import '../../../system_ui/layout/buttons.dart';

class MarketplaceBotCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final int userCount;
  final String price;
  final List<String> tags;
  final String actionLabel;
  final VoidCallback? onAction;

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
    this.actionLabel = 'Contratar',
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final textColor = Theme.of(context).colorScheme.onSurface;
    final subTextColor =
        Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return AppCard(
      padding: const EdgeInsets.all(20),
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
            children: tags
                .map(
                  (tag) =>
                      AppBadge.secondary(tag, icon: Icons.flash_on_rounded),
                )
                .toList(),
          ),

          const SizedBox(height: 24),
          Divider(color: shadTheme.colorScheme.border),
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
                        color: shadTheme.colorScheme.primary,
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
                        color: shadTheme.colorScheme.secondary,
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
                            color: shadTheme.colorScheme.primary,
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
              AppButton.primary(text: actionLabel, onPressed: onAction),
            ],
          ),
        ],
      ),
    );
  }
}
