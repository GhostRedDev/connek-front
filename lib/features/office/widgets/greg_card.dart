import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GregCard extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onTap;

  const GregCard({super.key, this.isActive = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    // ... existing theme logic ...
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      // ... existing container decoration ...
      width: 170, // Approximate width from screenshot
      height: 220, // Approximate height
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // ... existing background image / content ...
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
                    color: isActive ? null : Colors.grey.withOpacity(0.8),
                    colorBlendMode: isActive ? null : BlendMode.saturation,
                  ),
                ),
              ),
              // Action Area
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
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
                          backgroundColor: isActive
                              ? const Color(0xFF133A6C)
                              : Colors.grey, // Deep Blue Button or Grey
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
                    // Settings Icon
                    InkWell(
                      onTap: () {
                        context.push('/office/settings-greg');
                      },
                      child: Icon(
                        Icons.settings_outlined,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
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
                color: isActive
                    ? const Color(0xFF249689) // Greenish teal
                    : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActive ? 'Activo' : 'Inactivo',
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
