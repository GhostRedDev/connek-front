import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';

// Helper to show the bottom sheet ... (unchanged)

// ... (ProfileBottomSheet definitions unchanged until helper)


void showProfileBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1D21),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const ProfileBottomSheet(),
  );
}

class ProfileBottomSheet extends ConsumerStatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  ConsumerState<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends ConsumerState<ProfileBottomSheet> {
  // No local state needed for theme anymore

  @override
  Widget build(BuildContext context) {
    // Watch Theme Provider
    final themeMode = ref.watch(themeProvider);
    // Detect if effectively Dark Mode
    final bool isDark = themeMode == ThemeMode.dark || 
        (themeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;
        final user = session?.user;
        
        // Extract Metadata
        final String fullName = isLoggedIn && user?.userMetadata != null
            ? '${user!.userMetadata?['first_name'] ?? ''} ${user.userMetadata?['last_name'] ?? ''}'.trim()
            : '';
        final String email = user?.email ?? '';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor, // Dynamic Background
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Drag Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // 2. Theme Toggle (Real Logic)
                Container(
                   padding: const EdgeInsets.all(4),
                   decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.surface, // Dynamic surface
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: Colors.grey.withOpacity(0.1)),
                   ),
                   child: Row(
                     children: [
                       _buildThemeOption(
                         icon: Icons.wb_sunny_rounded,
                         label: 'Light',
                         // We can also allow explicit 'Light' setting
                         isSelected: themeMode == ThemeMode.light,
                         onTap: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.light),
                         context: context,
                       ),
                       _buildThemeOption(
                         icon: Icons.nightlight_round,
                         label: 'Dark',
                         isSelected: themeMode == ThemeMode.dark,
                         onTap: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.dark),
                         context: context,
                       ),
                       _buildThemeOption(
                         icon: Icons.settings_system_daydream_rounded,
                         label: 'System',
                         isSelected: themeMode == ThemeMode.system,
                         onTap: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.system),
                         context: context,
                       ),
                     ],
                   ),
                ),
                const SizedBox(height: 24),

                // 3. Content based on Auth State
                if (isLoggedIn)
                  _buildAuthenticatedView(context, fullName, email)
                else
                  _buildGuestView(context),
                  
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Authenticated View ---
  Widget _buildAuthenticatedView(BuildContext context, String name, String email) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final subTextColor = isDark ? Colors.grey[500] : Colors.grey[600];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Accounts',
            style: GoogleFonts.inter(
              color: subTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Divider(color: isDark ? Colors.white10 : Colors.black12, height: 1),
        const SizedBox(height: 12),

        // Active Account Item
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF4F87C9).withOpacity(0.15), // Keep Blue tint
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xFF4F87C9), width: 1),
          ),
          child: Row(
            children: [
              Container(
                 width: 32, height: 32,
                 decoration: const BoxDecoration(
                   color: Color(0xFF4F87C9),
                   shape: BoxShape.circle,
                 ),
                 child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name.isEmpty ? 'Usuario' : name,
                  style: GoogleFonts.inter(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
               const Icon(Icons.check_circle, color: Color(0xFF4F87C9), size: 20),
            ],
          ),
        ),
        
        // Placeholder for other accounts (if any)
        // ...

         const SizedBox(height: 30),
         
         // Footer: Business Name/Email + Settings + Logout
         Row(
           children: [
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(
                     'Signed in as',
                     style: GoogleFonts.inter(color: subTextColor, fontSize: 10),
                   ),
                   const SizedBox(height: 2),
                   Text(
                     email,
                     style: GoogleFonts.inter(color: textColor, fontWeight: FontWeight.w600, fontSize: 12),
                     overflow: TextOverflow.ellipsis,
                   ),
                 ],
               ),
             ),
             // Settings Button
             _buildFooterButton(
               icon: Icons.settings,
               color: const Color(0xFF7E8491),
               onTap: () {
                 context.pop(); // Close sheet
                 context.push('/profile'); // Go to profile/settings
               }
             ),
             const SizedBox(width: 12),
             // Logout Button
             _buildFooterButton(
               icon: Icons.logout_rounded,
               color: const Color(0xFF4F87C9), // Using blue accent for logout actions in this design
               onTap: () async {
                  await Supabase.instance.client.auth.signOut();
                  if (context.mounted) {
                    context.pop();
                    context.go('/');
                  }
               }
             ),
           ],
         ),
      ],
    );
  }

  Widget _buildFooterButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
       borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  // --- Guest View ---
  Widget _buildGuestView(BuildContext context) {
    return Column(
      children: [
        _buildGuestMenuItem(
          context: context,
          icon: Icons.login_rounded,
          label: 'Log In',
          onTap: () {
            context.pop();
            context.push('/login');
          },
        ),
        const SizedBox(height: 8),
        _buildGuestMenuItem(
          context: context,
          icon: Icons.person_add_outlined,
          label: 'Register',
          onTap: () {
            context.pop();
            context.push('/register');
          },
        ),
      ],
    );
  }

  Widget _buildGuestMenuItem({required BuildContext context, required IconData icon, required String label, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
           color: Colors.transparent,
           borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
             const Spacer(),
             Container(
               padding: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                 color: const Color(0xFF4F87C9).withOpacity(0.1),
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Icon(icon, color: const Color(0xFF4F87C9), size: 20),
             ),
          ],
        ),
      ),
    );
  }

  // Helper moved inside class
  Widget _buildThemeOption({
    required IconData icon, 
    required String label, 
    required bool isSelected, 
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Determine active/inactive colors based on theme
    final activeBg = isDark ? const Color(0xFF252A34) : Colors.white;
    final inactiveBg = Colors.transparent;
    final activeText = isDark ? Colors.white : const Color(0xFF1A1D21);
    final inactiveText = isDark ? Colors.grey : Colors.grey[600];
    final border = isSelected 
        ? Border.all(color: isDark ? Colors.white24 : Colors.black12, width: 0.5) 
        : null;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : inactiveBg,
            borderRadius: BorderRadius.circular(8),
             border: border,
             boxShadow: isSelected && !isDark ? [
               BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
             ] : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? activeText : inactiveText),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected ? activeText : inactiveText,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
