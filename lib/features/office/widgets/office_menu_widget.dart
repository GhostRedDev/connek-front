import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/providers/locale_provider.dart';

class OfficeMenuWidget extends ConsumerWidget {
  final Function(int index) onTabSelected;
  final int selectedIndex;

  const OfficeMenuWidget({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    // Theme Colors
    // Background of the pill container
    final containerColor = isDark
        ? const Color(0xFF1E2429) // Dark grey
        : Colors.grey.shade200; // Light grey

    // Active Tab Color
    final activeTabColor = isDark
        ? const Color(0xFF262D34) // Slightly lighter dark
        : Colors.white;

    // Text Colors
    final activeTextColor = isDark ? Colors.white : Colors.black;
    final inactiveTextColor = isDark
        ? const Color(0xFF95A1AC)
        : Colors.grey.shade600;

    return Center(
      // Center horizontally
      child: Container(
        height: 50,
        width: 300, // Fixed width for the pill look (or remove for full width)
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(100),
          // Optional border for contrast in light mode
          border: isDark ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tab 1: My Bots
            Expanded(
              child: _buildMenuOption(
                context,
                index: 0,
                icon: Icons.smart_toy_outlined, // More specific icon
                label: t['office_tab_my_bots'] ?? 'My bots',
                isActive: selectedIndex == 0,
                activeBg: activeTabColor,
                activeText: activeTextColor,
                inactiveText: inactiveTextColor,
              ),
            ),

            const SizedBox(width: 4),

            // Tab 2: Marketplace
            Expanded(
              child: _buildMenuOption(
                context,
                index: 1,
                icon: Icons.storefront_outlined,
                label: t['office_tab_marketplace'] ?? 'Marketplace',
                isActive: selectedIndex == 1,
                activeBg: activeTabColor,
                activeText: activeTextColor,
                inactiveText: inactiveTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeBg,
    required Color activeText,
    required Color inactiveText,
  }) {
    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? activeText : inactiveText, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isActive ? activeText : inactiveText,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
