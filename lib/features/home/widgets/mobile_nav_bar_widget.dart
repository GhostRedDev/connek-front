import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MobileNavBar2Widget extends StatelessWidget {
  const MobileNavBar2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    // SECURITY: Double-check Auth. If no session, do not render ANYTHING.
    // This prevents the navbar from showing if the parent toggle fails.
    if (Supabase.instance.client.auth.currentSession == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine active route
    final String location = GoRouterState.of(context).uri.toString();
    
    // Simple helper to check if location starts with route
    bool isActive(String route) => location.startsWith(route);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // LEFT PILL: Navigation Items
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50), 
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 70, 
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: isDark 
                        ? const Color(0xFF1E1E1E).withOpacity(0.90) 
                        : Colors.white.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: !isDark ? [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                    ] : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildNavItem(context, Icons.shopping_bag_outlined, 'Buy', '/client', 
                          isActive: isActive('/client')),
                      _buildNavItem(context, Icons.receipt_long_outlined, 'Sell', '/business',
                          isActive: isActive('/business')),
                      _buildNavItem(context, Icons.cleaning_services_outlined, 'Oficina', '/office',
                          isActive: isActive('/office')), 
                      _buildNavItem(context, Icons.person_outline, 'Profile', '/profile',
                          isActive: isActive('/profile')),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),

          // RIGHT: Search FAB
          Container(
            height: 60, 
            width: 60,
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
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                 borderRadius: BorderRadius.circular(30),
                 onTap: () => context.push('/search'),
                 child: Icon(Icons.search, color: isActive('/search') ? Colors.white : Colors.white.withOpacity(0.9), size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, String route, {bool isActive = false}) {
    // Active Color: Blue (#4285F4)
    // Inactive Color: White60 (Dark Mode) or Black54 (Light Mode)
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final activeColor = const Color(0xFF4285F4);
    final inactiveColor = isDark ? Colors.white60 : Colors.black54;
    
    final color = isActive ? activeColor : inactiveColor;
    
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
