import 'dart:ui';
import 'package:flutter/material.dart';
import 'search_bar_widget.dart';
import 'login_dropdown_button.dart';

class MobileAppBarWidget extends StatelessWidget {
  final bool bgTrans;
  final bool enableSearch;

  const MobileAppBarWidget({
    super.key,
    this.bgTrans = false,
    this.enableSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    // Premium Dark Gradient
    final premiumGradient = LinearGradient(
       colors: [
         const Color(0xFF1A1D21).withOpacity(0.95), // Nearly opaque dark
         const Color(0xFF252A34).withOpacity(0.90), // Slightly lighter dark/blue
       ],
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter,
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 30, // Increased blur for frosted glass
            sigmaY: 30,
          ),
          child: Container(
            width: double.infinity,
            height: 90, // Increased height
            decoration: BoxDecoration(
              // If bgTrans (Home), use transparent. Else, use premium gradient.
              gradient: bgTrans ? null : premiumGradient,
              color: bgTrans ? Colors.transparent : null,
              border: bgTrans ? null : Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.08),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // LOGO (Left Side)
                    Image.asset(
                      'assets/images/conneck_logo_white.png',
                      height: 32, // Slightly larger logo
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'connek',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    
                    const Spacer(),

                    // Middle Search (Only if enabled)
                    if (enableSearch)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SearchBarWidget(
                            onSubmitted: (val) {
                              print('Search for: $val');
                            },
                          ),
                        ),
                      ),

                    // RIGHT ICONS (Chat, Bell, Profile)
                    // Encapsulated in glass bubbles for premium feel
                    if (!enableSearch) ...[
                      _buildGlassIcon(Icons.chat_bubble_outline, () {}),
                      const SizedBox(width: 12),
                      _buildGlassIcon(Icons.notifications_none, () {}),
                      const SizedBox(width: 16), // More space before profile
                    ],
                    
                     // User/Profile Button (Circular)
                     const LoginDropdownButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48, height: 48, // Larger touch target
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08), // Subtle glass fill
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 24),
      ),
    );
  }
}
