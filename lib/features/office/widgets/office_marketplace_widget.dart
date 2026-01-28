import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers/greg_provider.dart';
import 'marketplace_bot_card.dart';
import '../../../../core/providers/locale_provider.dart';

class OfficeMarketplaceWidget extends ConsumerStatefulWidget {
  const OfficeMarketplaceWidget({super.key});

  @override
  ConsumerState<OfficeMarketplaceWidget> createState() =>
      _OfficeMarketplaceWidgetState();
}

class _OfficeMarketplaceWidgetState
    extends ConsumerState<OfficeMarketplaceWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Section
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1D21) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : Colors.black12, // Subtle Blue-Grey Border
              ),
              // Premium Deep Dark Gradient
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter, // Top to Bottom for depth
                colors: isDark
                    ? [
                        const Color(0xFF0A1016), // Almost Black
                        const Color(0xFF0F2027), // Deep Blue
                        const Color(
                          0xFF152735,
                        ), // Slightly lighter Blue-Grey at bottom
                      ]
                    : [
                        const Color(0xFFE0E7FF),
                        const Color(0xFFF0F4FF),
                        const Color(0xFFE8F5E9),
                      ],
              ),
              boxShadow: isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
              // TODO: Add Image.asset('assets/images/Marketplace_BG.png') when available
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t['office_marketplace_title'] ?? 'Marketplace',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.white
                          : const Color(
                              0xFF1A1D21,
                            ), // Keep explicit dark for banner contrast
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t['office_marketplace_subtitle'] ??
                        'Explora nuestra colección de bots especializados diseñados para transformar tu negocio',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Section Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t['office_assistants_title'] ?? 'Connek assistants',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t['office_assistants_subtitle'] ??
                    'Bots con mejor desempeño general',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color:
                      Theme.of(context).textTheme.bodySmall?.color ??
                      Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bot Card (Greg)
          Consumer(
            builder: (context, ref, child) {
              final gregState = ref.watch(gregProvider);
              final bool isActive =
                  gregState is GregLoaded && gregState.greg.active;

              return MarketplaceBotCard(
                name: 'Greg',
                description:
                    t['bot_greg_description'] ??
                    'Bot especializado en atención al cliente 24/7 con IA avanzada. Gestiona citas, responde dudas y más.',
                imageUrl:
                    'https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=256&q=80', // Placeholder or real URL
                price: '\$0',
                actionLabel: isActive ? 'Entrenar' : 'Contratar',
                onAction: () {
                  if (isActive) {
                    context.push('/office/train-greg');
                  } else {
                    context.push('/office/settings-greg');
                  }
                },
              );
            },
          ),

          const SizedBox(height: 24),

          // You could add more cards here
          // const MarketplaceBotCard(name: 'Another Bot', ...),
          const SizedBox(height: 80), // Bottom padding
        ],
      ),
    );
  }
}
