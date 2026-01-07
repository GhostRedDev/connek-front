import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileNavBar2Widget extends StatelessWidget {
  const MobileNavBar2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50), 
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 70, // Slightly taller to accommodate the button nicely
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E).withOpacity(0.90),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Even spacing for 5 items
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(context, Icons.shopping_bag_outlined, 'Buy', '/client'),
                _buildNavItem(context, Icons.receipt_long_outlined, 'Sell', '/business'),
                
                // CENTER SEARCH BUTTON
                Container(
                  height: 52, 
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4285F4), Color(0xFF2B569A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4285F4).withOpacity(0.5), 
                        blurRadius: 15, 
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white, size: 28),
                    onPressed: () => context.push('/search'),
                  ),
                ),

                _buildNavItem(context, Icons.cleaning_services_outlined, 'Oficina', '/office'), 
                _buildNavItem(context, Icons.person_outline, 'Profile', '/profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, String route, {bool isActive = false}) {
    final color = isActive ? Colors.white : Colors.white60;
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
