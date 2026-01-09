import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../settings/providers/profile_provider.dart';
import '../../auth/widgets/auth_success_overlay.dart';

// Helper to show the bottom sheet ... (unchanged)

// ... (ProfileBottomSheet definitions unchanged until helper)

void showProfileBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true, // Fix: Overlay above Custom NavBar
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
    // Watch Theme Provider
    final themeMode = ref.watch(themeProvider);
    // Watch Profile Data
    final profileState = ref.watch(profileProvider);
    final profile = profileState.value;

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;
        final user = session?.user;

        // Extract Metadata from Profile Provider (Prioritize) or Auth Metadata
        // Actually ProfileProvider is derived from Auth, so just use it.
        final String fullName =
            (profile != null &&
                (profile.firstName.isNotEmpty || profile.lastName.isNotEmpty))
            ? '${profile.firstName} ${profile.lastName}'.trim()
            : (user?.email ?? ''); // Fallback to email if no name

        final String email = user?.email ?? '';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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

                // 2. Theme Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      _buildThemeOption(
                        icon: Icons.wb_sunny_rounded,
                        label: 'Light',
                        isSelected: themeMode == ThemeMode.light,
                        onTap: () => ref
                            .read(themeProvider.notifier)
                            .setTheme(ThemeMode.light),
                        context: context,
                      ),
                      _buildThemeOption(
                        icon: Icons.nightlight_round,
                        label: 'Dark',
                        isSelected: themeMode == ThemeMode.dark,
                        onTap: () => ref
                            .read(themeProvider.notifier)
                            .setTheme(ThemeMode.dark),
                        context: context,
                      ),
                      _buildThemeOption(
                        icon: Icons.settings_system_daydream_rounded,
                        label: 'System',
                        isSelected: themeMode == ThemeMode.system,
                        onTap: () => ref
                            .read(themeProvider.notifier)
                            .setTheme(ThemeMode.system),
                        context: context,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Content based on Auth State
                if (isLoggedIn)
                  _buildAuthenticatedView(
                    context,
                    fullName,
                    email,
                    profile?.photoId,
                  )
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
  Widget _buildAuthenticatedView(
    BuildContext context,
    String name,
    String email,
    String? photoUrl,
  ) {
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
        // Active Account Item (Tap to View Profile)
        InkWell(
          onTap: () {
            context.pop(); // Close sheet
            context.push('/profile'); // Go to main profile
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4F87C9).withOpacity(0.15),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color(0xFF4F87C9), width: 1),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F87C9),
                    shape: BoxShape.circle,
                    image: (photoUrl != null && photoUrl.isNotEmpty)
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(photoUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: (photoUrl != null && photoUrl.isNotEmpty)
                      ? null
                      : const Icon(Icons.person, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name.isEmpty ? 'Usuario' : name,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Changed check icon to Arrow Forward to indicate navigation
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF4F87C9),
                  size: 16,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Add Account Button (Fast Switcher)
        InkWell(
          onTap: () {
            // TODO: fast account switching logic (verify 'remember me')
            context.push('/login'); // For now, allow logging in as another user
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isDark ? Colors.white24 : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: textColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add another account',
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
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
                context.push('/profile?tab=settings'); // Go to profile/settings
              },
            ),
            const SizedBox(width: 12),
            // Logout Button
            _buildFooterButton(
              icon: Icons.logout_rounded,
              color: const Color(
                0xFF4F87C9,
              ), // Using blue accent for logout actions in this design
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
                // Close bottom sheet first
                if (context.mounted) {
                  context.pop();

                  // Show Custom Neon Overlay
                  await showAuthSuccessDialog(
                    context,
                    message: 'Gracias por visitar Connect.\nAdiosss.',
                    isLogin: false,
                  );

                  if (context.mounted) context.go('/');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
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

  Widget _buildGuestMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
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
        ? Border.all(
            color: isDark ? Colors.white24 : Colors.black12,
            width: 0.5,
          )
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
            boxShadow: isSelected && !isDark
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? activeText : inactiveText,
              ),
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
