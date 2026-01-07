import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ProfileSection {
  profile,
  media,
  reviews,
  settings,
}

class ProfileMenuWidget extends StatelessWidget {
  final ProfileSection currentSection;
  final ValueChanged<ProfileSection> onSectionSelected; // Callback when tab tapped
  final bool isBusiness; // To conditionally show 'Reviews'

  const ProfileMenuWidget({
    super.key,
    required this.currentSection,
    required this.onSectionSelected,
    this.isBusiness = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        // The blur/glass effect is likely handled by the parent container (as seen in user snippet),
        // but this container holds the list.
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Space evenly if possible, or start with spacing
          children: [
            _buildOption(
              context,
              section: ProfileSection.profile,
              icon: Icons.person,
              label: 'Profile',
              isDark: isDark,
            ),
            const SizedBox(width: 20),
            _buildOption(
              context,
              section: ProfileSection.media,
              icon: Icons.photo,
              label: 'Media',
              isDark: isDark,
            ),
            if (isBusiness) ...[
              const SizedBox(width: 20),
              _buildOption(
                context,
                section: ProfileSection.reviews,
                icon: Icons.star,
                label: 'Reviews',
                isDark: isDark,
              ),
            ],
            const SizedBox(width: 20),
            _buildOption(
              context,
              section: ProfileSection.settings,
              icon: Icons.settings,
              label: 'Settings',
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required ProfileSection section,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    final isActive = currentSection == section;
    
    // Colors
    final activeBg = isDark ? Colors.white : const Color(0xFF2C2C2C); 
    final activeText = isDark ? Colors.black : Colors.white;
    final inactiveBorder = isDark ? Colors.white24 : Colors.black12;
    final inactiveText = isDark ? Colors.grey[400] : Colors.grey[600];

    return InkWell(
      onTap: () => onSectionSelected(section),
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 9), // Updated padding

        decoration: BoxDecoration(
          color: isActive ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActive ? Colors.transparent : inactiveBorder,
            width: 1.5,
          ),
          boxShadow: isActive ? [
             BoxShadow(
               color: Colors.black.withOpacity(0.1),
               blurRadius: 4,
               offset: const Offset(0, 2),
             )
          ] : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? activeText : inactiveText,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isActive ? activeText : inactiveText,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
