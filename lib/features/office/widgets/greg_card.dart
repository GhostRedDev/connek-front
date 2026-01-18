import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/greg_provider.dart';

class GregCard extends ConsumerWidget {
  const GregCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 170, // Approximate width from screenshot
      height: 220, // Approximate height
      decoration: BoxDecoration(
        color: const Color(0xFF1E2429), // Dark card background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: const Color(0x33000000),
            offset: const Offset(0, 2),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image / Content
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/images/GREG_CARD_1.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Action Area
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1F24), // Slightly darker bottom area
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Train Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(
                            '/office/train-greg',
                          ); // Navigation to training page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF133A6C,
                          ), // Deep Blue Button
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Entrenar'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Test Icon
                    InkWell(
                      onTap: () {
                        final state = ref.read(gregProvider);
                        if (state is GregLoaded) {
                          context.push('/test-greg/${state.greg.businessId}');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Greg no está listo aún.'),
                            ),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Settings Icon
                    InkWell(
                      onTap: () {
                        context.push('/office/settings-greg');
                      },
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // "Activo" Badge
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF249689), // Greenish teal
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Activo',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Name "Greg"
          Positioned(
            bottom: 60, // Above the buttons
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Greg',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
