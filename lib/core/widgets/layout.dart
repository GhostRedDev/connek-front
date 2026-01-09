import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Added
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Added
import 'package:google_fonts/google_fonts.dart'; // Added

import '../../core/providers/theme_provider.dart'; // Added
import '../../features/settings/providers/profile_provider.dart'; // Added
import '../../features/auth/widgets/auth_success_overlay.dart'; // Added

// Removed local import of login_dropdown_button.dart since we are migrating it here
// import '../../features/home/widgets/login_dropdown_button.dart';

// ==============================================================================
// 1. MODERN GLASS IMPLEMENTATION
// ==============================================================================

/// Efecto moderno de glass con blur limpio y sin distorsión.
/// Usa BackdropFilter para un efecto frosted glass real y performante.
class ModernGlass extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double borderRadius;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final Color? tintColor;
  final bool border;

  const ModernGlass({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 16.0,
    this.blur = 15.0,
    this.opacity = 0.08,
    this.padding,
    this.tintColor,
    this.border = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            color: (tintColor ?? (isDark ? Colors.black : Colors.white))
                .withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: border
                ? Border.all(
                    color: Colors.white.withOpacity(isDark ? 0.05 : 0.15),
                    width: 0.5,
                  )
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}

// ==============================================================================
// 2. GLASS CONTAINER COMPATIBLE
// ==============================================================================

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double opacity;
  final double blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 16,
    this.backgroundColor,
    this.padding,
    this.opacity = 0.08,
    this.blur = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ModernGlass(
      height: height,
      width: width,
      borderRadius: borderRadius,
      opacity: opacity,
      blur: blur,
      padding: padding,
      tintColor: backgroundColor,
      child: child,
    );
  }
}

// ==============================================================================
// 3. HEADER CONFIGURATION
// ==============================================================================

class HeaderAction {
  final IconData icon;
  final VoidCallback? onTap;
  final String? route;
  final Color? color;

  const HeaderAction({required this.icon, this.onTap, this.route, this.color});
}

class HeaderData {
  final String? title;
  final Widget? titleWidget;
  final List<HeaderAction> actions;
  final bool bgTrans;
  final bool showProfile;
  final double? height;
  final bool isCustom;
  final List<String> tabs;

  const HeaderData({
    this.title,
    this.titleWidget,
    this.actions = const [],
    this.bgTrans = false,
    this.showProfile = true,
    this.height = 130,
    this.isCustom = false,
    this.tabs = const [],
  });
}

HeaderData getHeaderConfig(String route, bool isDark, bool isLoggedIn) {
  Widget logoWidget = Image.asset(
    isDark
        ? 'assets/images/conneck_logo_white.png'
        : 'assets/images/conneck_logo_dark.png',
    height: 38, // Increased from 32
    fit: BoxFit.contain,
    errorBuilder: (_, __, ___) => Text(
      'connek',
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF1A1D21),
        fontSize: 28, // Increased font size
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    ),
  );

  if (route == '/') {
    // Hide actions if not logged in
    final List<HeaderAction> actions = isLoggedIn
        ? [
            HeaderAction(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: () => print('Chat'),
            ),
            HeaderAction(
              icon: Icons.notifications_none_rounded,
              onTap: () => print('Notify'),
            ),
          ]
        : [];

    return HeaderData(titleWidget: logoWidget, bgTrans: true, actions: actions);
  }

  if (route.startsWith('/business')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      height: 200,
      tabs: ['Overview', 'Leads', 'Clientes'], // Standard tabs
      actions: [
        HeaderAction(icon: Icons.add_circle_outline),
        HeaderAction(icon: Icons.chat_bubble_outline),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route.startsWith('/client')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      height: 200,
      tabs: ['Overview', 'Market', 'Orders'], // Example tabs
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route.startsWith('/office')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      height: 200,
      tabs: ['Overview', 'Reports', 'Team'], // Standard tabs
      actions: [
        HeaderAction(icon: Icons.add_circle_outline),
        HeaderAction(icon: Icons.chat_bubble_outline),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route == '/search') {
    return const HeaderData(
      title: 'Search',
      bgTrans: false,
      isCustom: false, // Show default header
    );
  }

  if (route.startsWith('/chats')) {
    return const HeaderData(title: 'Messages', bgTrans: false, isCustom: false);
  }

  if (route.startsWith('/settings')) {
    return const HeaderData(title: 'Settings', bgTrans: false, isCustom: false);
  }

  return HeaderData(titleWidget: logoWidget, bgTrans: false, height: 130);
}

// ==============================================================================
// 4. MAIN LAYOUT - SIMPLIFICADO
// ==============================================================================

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({required this.child, super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final initialSession = Supabase.instance.client.auth.currentSession;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Pre-calculate config to check for tabs
    // Note: We need isLoggedIn here if we want to be perfectly accurate with getHeaderConfig
    // but strict tabs logic usually depends on route.
    // Let's rely on route logic primarily or handle isLoggedIn inside builder.
    // For TABS, let's assume they exist if the route says so.
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      initialData: initialSession != null
          ? AuthState(AuthChangeEvent.signedIn, initialSession)
          : null,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;

        // Re-get config with correct auth state
        final activeConfig = getHeaderConfig(location, isDark, isLoggedIn);
        final hasTabs = activeConfig.tabs.isNotEmpty;

        Widget scaffold = Scaffold(
          // Use theme background (handles both Dark #131619 and Light #F5F7FA)
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              // Contenido principal
              child,

              // AppBar moderno
              _ModernGlassAppBar(location: location),

              // NavBar solo si está logueado
              if (isLoggedIn)
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _ModernGlassNavBar(),
                ),
            ],
          ),
        );

        // Always wrap in DefaultTabController to maintain widget tree stability.
        // If no tabs, use length 1 (dummy).
        return DefaultTabController(
          length: hasTabs ? activeConfig.tabs.length : 1,
          child: scaffold,
        );
      },
    );
  }
}

// ==============================================================================
// 5. APPBAR MODERNO (SIMPLE & CLEAN)
// ==============================================================================

class _ModernGlassAppBar extends StatelessWidget {
  final String location;

  const _ModernGlassAppBar({required this.location});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Check auth synchronously for header state (or we could pass it down)
    final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
    final HeaderData config = getHeaderConfig(location, isDark, isLoggedIn);

    if (config.isCustom) {
      return const SizedBox.shrink();
    }

    // Contenido interno con TABS Support
    Widget innerContent = SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TOP ROW (Logo + Icons)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. CENTER LOGO (Absolute Center) - Only for Search
                if (location == '/search' && config.titleWidget != null)
                  config.titleWidget!,

                // 2. LEFT & RIGHT CONTENT (Row)
                Row(
                  children: [
                    // --- LEFT SIDE ---
                    if (location == '/search')
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1A1D21),
                          size: 28,
                        ),
                        onPressed: () => context.pop(),
                      )
                    else
                    // Standard Title/Logo
                    if (config.titleWidget != null)
                      config.titleWidget!
                    else if (config.title != null)
                      Text(
                        config.title!,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1A1D21),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),

                    const Spacer(),

                    // --- RIGHT SIDE ---
                    ...config.actions.map(
                      (action) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: IconButton(
                          icon: Icon(
                            action.icon,
                            color:
                                action.color ??
                                (isDark
                                    ? Colors.white70
                                    : const Color(0xFF1A1D21)),
                            size: 28,
                          ),
                          onPressed:
                              action.onTap ??
                              () {
                                if (action.route != null) {
                                  context.push(action.route!);
                                }
                              },
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    ),

                    // Profile
                    if (config.showProfile)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: LoginDropdownButton(),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // TABS ROW (If present)
          if (config.tabs.isNotEmpty) ...[
            const Spacer(),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.withOpacity(
                            0.2,
                          ), // Gray border for Light Mode
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                indicator: BoxDecoration(
                  color: isDark ? Colors.white : const Color(0xFF1A1D21),
                  borderRadius: BorderRadius.circular(50),
                ),
                labelColor: isDark ? const Color(0xFF1A1D21) : Colors.white,
                unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
                // We need google fonts imported here, assuming it is.
                // If not, we use system font or standard TextStyles.
                // Assuming imported as project uses it.
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'Inter',
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: config.tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),
          ],
        ],
      ),
    );

    // ============================================
    // ¡APPBAR REALMENTE TRANSPARENTE!
    // ============================================

    // Para homepage y otras paginas con fondo transparente - GLASS SUTIL
    // Para homepage y otras paginas con fondo transparente - GLASS SUTIL
    if (config.bgTrans) {
      return Align(
        alignment: Alignment.topCenter,
        child: ModernGlass(
          height: config.height ?? 100,
          width: double.infinity,
          borderRadius: 0,
          opacity: isDark
              ? 0.01
              : 0.65, // More visible/comfortable glass in Light Mode
          blur: isDark ? 10 : 20, // Stronger blur in light mode for comfort
          border: false, // Sin borde para look limpio
          tintColor: isDark ? Colors.black : Colors.white,
          child: innerContent,
        ),
      );
    }

    // Para otras páginas - MODERN GLASS
    return Align(
      alignment: Alignment.topCenter,
      child: ModernGlass(
        height: config.height ?? 100,
        width: double.infinity,
        borderRadius: 0,
        opacity: 0.02, // Ultra transparent as per user request
        blur: 30, // High blur
        border: true, // Show border to define "App Bar" area
        tintColor: isDark ? Colors.black : Colors.white,
        child: innerContent,
      ),
    );
  }
}

// ==============================================================================
// 6. NAVIGATION BAR MODERNO
// ==============================================================================

class _ModernGlassNavBar extends StatelessWidget {
  const _ModernGlassNavBar();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    bool isActive(String route) =>
        GoRouterState.of(context).uri.toString().startsWith(route);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            // Barra de navegación principal
            Expanded(
              child: ModernGlass(
                height: 70,
                borderRadius: 35,
                opacity: 0.08, // More transparent
                blur: 30, // Higher blur
                border: true,
                tintColor: isDark ? Colors.black : Colors.white,
                child: _buildNavItems(context, isActive),
              ),
            ),

            const SizedBox(width: 16),

            // Botón de búsqueda (FAB)
            ModernGlass(
              height: 60,
              width: 60,
              borderRadius: 30,
              opacity: 0.12,
              blur: 30,
              border: true,
              tintColor: const Color(0xFF4285F4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => context.go('/'),
                  child: const Center(
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems(BuildContext context, bool Function(String) isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem(
          context,
          Icons.shopping_bag_outlined,
          'Buy',
          '/client',
          isActive('/client'),
        ),
        _buildNavItem(
          context,
          Icons.receipt_long_outlined,
          'Sell',
          '/business',
          isActive('/business'),
        ),
        _buildNavItem(
          context,
          Icons.cleaning_services_outlined,
          'Office',
          '/office',
          isActive('/office'),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
    bool active,
  ) {
    final color = active ? const Color(0xFF4285F4) : Colors.white70;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// 7. WIDGETS ADICIONALES SIMPLES
// ==============================================================================

/// Card moderno con glass effect
class ModernGlassCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final double blur;

  const ModernGlassCard({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(20),
    this.opacity = 0.05,
    this.blur = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ModernGlass(
      height: height,
      width: width,
      borderRadius: borderRadius,
      opacity: opacity,
      blur: blur,
      padding: padding,
      child: child,
    );
  }
}

/// Botón moderno con glass effect
class ModernGlassButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? tintColor;

  const ModernGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.tintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: ModernGlass(
          borderRadius: borderRadius,
          opacity: 0.1,
          tintColor: tintColor,
          padding: padding,
          child: Center(child: child),
        ),
      ),
    );
  }
}

// ==============================================================================
// 8. PROFILE & AUTH COMPONENTS (MIGRATED FROM FEATURES)
// ==============================================================================

class LoginDropdownButton extends ConsumerWidget {
  const LoginDropdownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session =
            snapshot.data?.session ??
            Supabase.instance.client.auth.currentSession;
        final bool isLoggedIn = session != null;

        final profileState = ref.watch(profileProvider);
        final user = profileState.value;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return InkWell(
          onTap: () => showProfileBottomSheet(context),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(2), // Border width
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isLoggedIn
                  ? const LinearGradient(
                      colors: [
                        Color(0xFF4285F4),
                        Color(0xFF90CAF9),
                      ], // Blue gradient for Auth
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF2C3138), const Color(0xFF1A1D21)]
                          : [const Color(0xFFE0E0E0), const Color(0xFFF5F5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            ),
            child: Container(
              // width: 40, // Removed to fill parent
              // height: 40, // Removed to fill parent
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.4), // Inner bg
                image:
                    (isLoggedIn &&
                        user?.photoId != null &&
                        user!.photoId!.isNotEmpty)
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(user.photoId!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child:
                  (isLoggedIn &&
                      user?.photoId != null &&
                      user!.photoId!.isNotEmpty)
                  ? null // Image is in decoration
                  : Center(
                      child: Icon(
                        isLoggedIn ? Icons.person : Icons.person_outline,
                        color: Colors.white,
                        size: 28, // Increased from 24
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

void showProfileBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true, // Fix: Overlay above Custom NavBar
    backgroundColor: Theme.of(context).cardColor, // Use theme card color
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
                    message: 'Gracias por visitar Connect.\\nAdiosss.',
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
