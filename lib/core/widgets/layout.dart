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
import '../../features/notifications/providers/notification_provider.dart'; // Added
import '../../features/call/services/call_service.dart'; // Added
import '../../features/call/widgets/incoming_call_overlay.dart'; // Added
import '../../core/providers/user_mode_provider.dart'; // Added
import '../../features/business/providers/business_provider.dart'; // Added

import '../../core/providers/locale_provider.dart'; // Added for Localization

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
  final int badgeCount;

  const HeaderAction({
    required this.icon,
    this.onTap,
    this.route,
    this.color,
    this.badgeCount = 0,
  });
}

class HeaderData {
  final String? title;
  final Widget? titleWidget;
  final List<HeaderAction> actions;
  final bool bgTrans;
  final bool showProfile;
  final double? height;
  final bool isCustom;
  final List<dynamic> tabs;
  final Widget? bottomWidget;

  const HeaderData({
    this.title,
    this.titleWidget,
    this.actions = const [],
    this.bgTrans = false,
    this.showProfile = true,
    this.height = 130,
    this.isCustom = false,
    this.tabs = const [],
    this.bottomWidget,
  });
}

HeaderData getHeaderConfig(
  String route,
  bool isDark,
  bool isLoggedIn,
  Map<String, String> t,
  WidgetRef? ref, // Added Ref
) {
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
              route: '/chats',
              // badgeCount defaulted to 0
            ),
            HeaderAction(
              icon: Icons.notifications_none_rounded,
              route: '/notifications',
            ),
          ]
        : [];

    // Home Header: Transparent, Logo, Actions
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      actions: actions,
      height: 120, // Increased from 100 to fix overflow
    );
  }

  if (route.startsWith('/business')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: false,
      height: 200, // Increased to 200 to clear safe area overflow
      tabs: [
        {
          'label': t['tab_overview'] ?? 'Overview',
          'icon': Icons.dashboard_outlined,
        },
        {
          'label': t['tab_leads'] ?? 'Leads',
          'icon': Icons.person_search_outlined,
        },
        {'label': t['tab_clients'] ?? 'Clientes', 'icon': Icons.people_outline},
        // REPLACED SALES TAB WITH DROPDOWN CONFIG
        {
          'label': (ref != null)
              ? _getSalesLabel(ref.watch(selectedSalesViewProvider), t)
              : (t['tab_sales'] ?? 'Ventas'),
          'icon': (ref != null)
              ? _getSalesIcon(ref.watch(selectedSalesViewProvider))
              : Icons.receipt,
          'type': 'dropdown',
          'items': [
            {
              'label': 'Resumen',
              'value': 'ventas',
              'icon': Icons.dashboard_customize_outlined,
            },
            {'label': 'Facturas', 'value': 'invoices', 'icon': Icons.receipt},
            {
              'label': 'Propuestas',
              'value': 'proposals',
              'icon': Icons.monetization_on_outlined,
            },
            {
              'label': 'Bookings',
              'value': 'bookings',
              'icon': Icons.calendar_today_outlined,
            },
          ],
          'onSelected': (value) {
            if (ref != null) {
              ref.read(selectedSalesViewProvider.notifier).setView(value);
            }
          },
        },
        // NEW TABS: Services, Employees, Profile, Settings
        {
          'label': t['tab_services'] ?? 'Servicios',
          'icon': Icons.design_services_outlined,
        },
        {
          'label': t['tab_employees'] ?? 'Empleados',
          'icon': Icons.badge_outlined,
        },
        {'label': t['tab_profile'] ?? 'Perfil', 'icon': Icons.person_outline},
        {
          'label': t['tab_settings'] ?? 'Ajustes',
          'icon': Icons.settings_outlined,
        },
      ],
      // bottomWidget: _BusinessSubHeader(isDark: isDark), // Removed in favor of Tabs
      actions: [
        HeaderAction(icon: Icons.add_circle_outline),
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  // Specific exception for Support
  if (route.contains('/client/dashboard/support')) {
    return HeaderData(
      title: t['header_support'] ?? 'Support',
      bgTrans: true, // Transparent
      showProfile: true,
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route.contains('/client/dashboard/requests')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: false,
      showProfile: true,
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route == '/client') {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: false,
      isCustom: true,
      height: 0,
    );
  }

  // Catch-all for other Client Sub-routes (Booking, Wallet, etc.)
  if (route.startsWith('/client')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: false,
      showProfile: true,
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route.startsWith('/office')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      height: 125, // Increased from 110 to fix overflow on notch devices
      tabs: [], // Tab removed as per request (moved to Profile)
      actions: [
        HeaderAction(icon: Icons.add_circle_outline),
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route.contains('/office/train-greg')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      height: 125,
      actions: [
        const HeaderAction(icon: Icons.add_circle_outline),
        const HeaderAction(icon: Icons.chat_bubble_outline),
        const HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route == '/search') {
    return HeaderData(
      title: t['header_search'] ?? 'Search',
      bgTrans: false,
      isCustom: false,
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route == '/chats') {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      actions: [
        HeaderAction(icon: Icons.notifications_none),
      ], // Removed badgeCount
      showProfile: true,
    );
  }

  if (route.startsWith('/chats/')) {
    return const HeaderData(bgTrans: false, isCustom: true, height: 0);
  }

  if (route.startsWith('/profile')) {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: false, // Opaque (Normal Color)
      showProfile: true,
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  if (route.startsWith('/settings')) {
    return HeaderData(
      titleWidget: logoWidget, // Replaced title text with Logo
      // title: t['header_settings'] ?? 'Settings',
      bgTrans: true, // Transparent
      showProfile: true, // Show user avatar
      actions: [
        HeaderAction(icon: Icons.chat_bubble_outline, route: '/chats'),
        HeaderAction(icon: Icons.notifications_none),
      ],
    );
  }

  // Auth Routes Configuration
  if (route == '/login' ||
      route == '/register' ||
      route == '/forgot-password' ||
      route == '/reset-password' ||
      route == '/confirm-phone') {
    return HeaderData(
      titleWidget: logoWidget,
      bgTrans: true,
      showProfile: false, // No profile on auth pages
      actions: [], // No actions on auth pages
    );
  }

  return HeaderData(titleWidget: logoWidget, bgTrans: false, height: 130);
}

// Helper to get dynamic label for Sales
String _getSalesLabel(String view, Map<String, String> t) {
  switch (view) {
    case 'invoices':
      return 'Facturas';
    case 'proposals':
      return 'Propuestas';
    case 'bookings':
      return 'Bookings';
    default:
      return t['tab_sales'] ?? 'Ventas';
  }
}

IconData _getSalesIcon(String view) {
  switch (view) {
    case 'invoices':
      return Icons.receipt;
    case 'proposals':
      return Icons.monetization_on_outlined;
    case 'bookings':
      return Icons.calendar_today_outlined;
    default:
      return Icons.point_of_sale_outlined;
  }
}

// ==============================================================================
// 4. MAIN LAYOUT - SIMPLIFICADO
// ==============================================================================

// ==============================================================================
// 4. MAIN LAYOUT - SIMPLIFICADO
// ==============================================================================

class AppLayout extends ConsumerStatefulWidget {
  final Widget child;

  const AppLayout({required this.child, super.key});

  @override
  ConsumerState<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends ConsumerState<AppLayout> {
  CallService? _callService;
  Map<String, dynamic>? _incomingCall; // {call_id, caller}
  int? _myDbId; // Client or Business ID

  @override
  void initState() {
    super.initState();
    _initCallService();
  }

  Future<void> _initCallService() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    // 1. Fetch My ID (Try Client first, then Business)
    // Minimal optimization: check path? No, app layout is global.
    // We check both.
    final supabase = Supabase.instance.client;

    try {
      // Try Client
      final clientRes = await supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();
      if (clientRes != null) {
        _myDbId = clientRes['id'];
      } else {
        // Try Business
        final businessRes = await supabase
            .from('business')
            .select('id')
            .eq('user_id', user.id)
            .maybeSingle();
        if (businessRes != null) {
          _myDbId = businessRes['id'];
        }
      }

      if (_myDbId != null) {
        // 2. Initialize Service
        // We create a standalone instance here.
        // Ideally use a Provider, but manual management in shell is robust for listeners.
        _callService = CallService(
          supabase,
          onOffer: (_) {},
          onAnswer: (_) {},
          onIceCandidate: (_) {},
          onIncomingCall: (payload) {
            if (mounted) {
              setState(() {
                _incomingCall = payload;
                // Payload: {call_id, caller: {name, image}}
              });
            }
          },
        );

        _callService!.listenToIncomingCalls(_myDbId!);
      }
    } catch (e) {
      print('Error init call service: $e');
    }

    // 3. Initialize Global Notifications
    // This ensures notifications are fetched regardless of which page we are on
    // Use the provider's notifier to fetch.
    // We delay slightly to ensure context/provider is ready if needed, currently safe in async.
  }

  @override
  void dispose() {
    _callService?.dispose();
    super.dispose();
  }

  void _acceptCall() {
    if (_incomingCall == null) return;
    final callId = _incomingCall!['call_id'];
    final caller = _incomingCall!['caller'] as Map<String, dynamic>?;
    final isVideo = caller?['isVideo'] ?? true; // Default to true

    context.push('/call/$callId?isCaller=false&isVideo=$isVideo');
    setState(() {
      _incomingCall = null;
    });
  }

  void _declineCall() {
    setState(() {
      _incomingCall = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final initialSession = Supabase.instance.client.auth.currentSession;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      initialData: initialSession != null
          ? AuthState(AuthChangeEvent.signedIn, initialSession)
          : null,
      builder: (context, snapshot) {
        // Show loading while initializing logic if session restoration is pending
        if (snapshot.connectionState == ConnectionState.waiting &&
            initialSession == null) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;

        // Get Translations
        final tAsync = ref.watch(translationProvider);
        final t = tAsync.value ?? {};

        // Re-get config with correct auth state and translation
        // Re-get config with correct auth state and translation
        final activeConfig = getHeaderConfig(
          location,
          isDark,
          isLoggedIn,
          t,
          ref,
        );
        final hasTabs = activeConfig.tabs.isNotEmpty;

        Widget scaffold = Scaffold(
          // Use theme background
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              final showSidebar = isLoggedIn && isDesktop;
              // Hide BottomBar if on desktop OR if in Chat views (to avoid overlay)
              final bool isChatView =
                  location.startsWith('/chats') ||
                  location.startsWith('/chat/');
              final showBottomBar = isLoggedIn && !isDesktop && !isChatView;

              return Row(
                children: [
                  // Desktop Sidebar
                  if (showSidebar) _ModernSidebar(activeRoute: location),

                  // Main Content
                  Expanded(
                    child: Stack(
                      children: [
                        // Content
                        Padding(
                          padding: EdgeInsets.only(
                            top: (activeConfig.isCustom || activeConfig.bgTrans)
                                ? 0
                                : (activeConfig.height ?? 0),
                          ),
                          child: widget.child,
                        ),

                        // AppBar moderno (Top)
                        _ModernGlassAppBar(location: location),

                        // NavBar (Bottom) - Mobile Only
                        if (showBottomBar)
                          const Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: _ModernGlassNavBar(),
                          ),

                        // INCOMING CALL OVERLAY
                        if (_incomingCall != null)
                          IncomingCallOverlay(
                            caller: _incomingCall!['caller'] ?? {},
                            onAccept: _acceptCall,
                            onDecline: _declineCall,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );

        // Always wrap in DefaultTabController
        return DefaultTabController(
          key: ValueKey(hasTabs ? activeConfig.tabs.length : 1),
          length: hasTabs ? activeConfig.tabs.length : 1,
          child: scaffold,
        );
      },
    );
  }
}

// ==============================================================================
// 4b. DESKTOP SIDEBAR
// ==============================================================================

class _ModernSidebar extends StatelessWidget {
  final String activeRoute;

  const _ModernSidebar({required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    // Watch Translations for sidebar
    // Since this is Stateless, we need to convert to ConsumerWidget OR Consumer
    // Or just pass 't' but this widget is called from LayoutBuilder which is inside ConsumerState
    // Actually, AppLayout is ConsumerStateful, BUT _ModernSidebar is stateless.
    // Let's use Consumer here.
    return Consumer(
      builder: (context, ref, _) {
        final tAsync = ref.watch(translationProvider);
        final t = tAsync.value ?? {};

        final isDark = Theme.of(context).brightness == Brightness.dark;

        // Check active
        bool isActive(String route) => activeRoute.startsWith(route);

        return Container(
          width: 250,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131619) : Colors.white,
            border: Border(
              right: BorderSide(
                color: isDark
                    ? Colors.white10
                    : (Colors.grey[200] ?? Colors.grey),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo Area in Sidebar?
              Image.asset(
                isDark
                    ? 'assets/images/conneck_logo_white.png'
                    : 'assets/images/conneck_logo_dark.png',
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),

              // Nav Items
              _SidebarItem(
                icon: Icons.shopping_bag_outlined,
                label: t['header_buy'] ?? 'Buy (Client)',
                isActive: isActive('/client'),
                onTap: () => context.go('/client'),
              ),
              _SidebarItem(
                icon: Icons.receipt_long_outlined,
                label: t['header_sell'] ?? 'Sell (Business)',
                isActive: isActive('/business'),
                onTap: () => context.go('/business'),
              ),
              _SidebarItem(
                icon: Icons.cleaning_services_outlined,
                label: t['header_office'] ?? 'Backoffice',
                isActive: isActive('/office'),
                onTap: () => context.go('/office'),
              ),

              const Spacer(),

              // Bottom items (Messages, Settings) could go here too
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _SidebarItem(
                  icon: Icons.settings_outlined,
                  label: t['header_settings'] ?? 'Settings',
                  isActive: isActive('/settings'),
                  onTap: () => context.push('/settings'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isActive
        ? const Color(0xFF4285F4)
        : (isDark ? Colors.white70 : Colors.black54);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: isActive
            ? (isDark ? const Color(0xFF1E2530) : const Color(0xFFE8F0FE))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Pooling(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: color,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
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

class Pooling extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  const Pooling({super.key, required this.padding, required this.child});
  @override
  Widget build(context) => Padding(padding: padding, child: child);
}

// ==============================================================================
// 5. APPBAR MODERNO (SIMPLE & CLEAN)
// ==============================================================================

class _ModernGlassAppBar extends ConsumerWidget {
  final String location;

  const _ModernGlassAppBar({required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoggedIn = Supabase.instance.client.auth.currentSession != null;

    // Watch Notifications
    final notificationState = ref.watch(notificationProvider);
    final notificationList = notificationState.value ?? [];
    final unreadNotifications = notificationList.where((n) => !n.isRead).length;

    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    HeaderData config = getHeaderConfig(location, isDark, isLoggedIn, t, ref);

    // Inject real data into config actions if they exist
    if (config.actions.isNotEmpty) {
      final newActions = config.actions.map((a) {
        // Check for both rounded and normal notification icons
        if (a.icon == Icons.notifications_none ||
            a.icon == Icons.notifications_none_rounded) {
          return HeaderAction(
            icon: a.icon,
            route: '/notifications',
            badgeCount: unreadNotifications,
            onTap: () => context.push('/notifications'),
          );
        }
        if (a.icon == Icons.chat_bubble_outline && a.badgeCount > 0) {
          // Keep chat mock or link to real chat provider later
          return a;
        }
        return a;
      }).toList();

      config = HeaderData(
        title: config.title,
        titleWidget: config.titleWidget,
        actions: newActions,
        bgTrans: config.bgTrans,
        showProfile: config.showProfile,
        height: config.height,
        isCustom: config.isCustom,
        tabs: config.tabs,
        bottomWidget: config.bottomWidget, // Include bottomWidget!
      );
    }

    if (config.isCustom) {
      return const SizedBox.shrink();
    }

    // Contenido interno con TABS Support
    Widget innerContent = SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TOP ROW (Logo + Icons)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 28,
                          ),
                          onPressed: () => context.pop(),
                        )
                      else if (location == '/chats' &&
                          config.titleWidget != null)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 28,
                              ),
                              onPressed: () => context.go('/'),
                            ),
                            const SizedBox(width: 8),
                            config.titleWidget!,
                          ],
                        )
                      else
                      // Standard Title/Logo
                      if (config.titleWidget != null)
                        config.titleWidget!
                      else if (config.title != null)
                        Text(
                          config.title!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
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
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              IconButton(
                                icon: Icon(
                                  action.icon,
                                  color:
                                      action.color ??
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.7),
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
                              if (action.badgeCount > 0)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '${action.badgeCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
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
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
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
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelColor: Theme.of(context).colorScheme.surface,
                  unselectedLabelColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
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
                  tabs: config.tabs.map((t) {
                    if (t is String) {
                      return Tab(text: t); // Fallback for pure strings
                    } else if (t is Map) {
                      final label = t['label'] ?? '';
                      // Custom Dropdown Tab
                      if (t['type'] == 'dropdown') {
                        return Tab(
                          child: PopupMenuButton<String>(
                            onSelected: (value) {
                              // Find the index of this tab to select it
                              final index = config.tabs.indexOf(t);
                              DefaultTabController.of(context).animateTo(index);

                              // Trigger callback
                              final onSelected =
                                  t['onSelected'] as Function(String)?;
                              if (onSelected != null) {
                                onSelected(value);
                              }
                            },
                            offset: const Offset(
                              0,
                              40,
                            ), // Push down to avoid overlapping
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Added Dynamic Icon
                                if (t['icon'] != null) ...[
                                  Icon(
                                    t['icon'],
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(label),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ],
                            ),
                            itemBuilder: (context) {
                              final items =
                                  t['items'] as List<Map<String, dynamic>>;
                              return items.map((item) {
                                return PopupMenuItem<String>(
                                  value: item['value'],
                                  child: Row(
                                    children: [
                                      Icon(
                                        item['icon'],
                                        size: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(item['label']),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        );
                      } else {
                        // Standard Tab with Icon
                        return Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (t['icon'] != null) ...[
                                Icon(t['icon'], size: 18),
                                const SizedBox(width: 8),
                              ],
                              Text(label),
                            ],
                          ),
                        );
                      }
                    }
                    return const Tab(text: 'Error');
                  }).toList(),
                ),
              ),
            ],

            // Display Custom Bottom Widget (e.g., Business Chips)
            if (config.bottomWidget != null) config.bottomWidget!,
          ],
        ),
      ),
    );

    // ============================================
    // ¡APPBAR SIN BLUR (SOLIDO O TRANSPARENTE)!
    // ============================================

    // Si la config pide transparencia (Ej: Home), lo hacemos totalmente transparente sin blur.
    if (config.bgTrans) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: config.height ?? 120, // Default increased to 120 safe
        child: Container(
          // No color set -> Transparent and allows click-through to body
          // This allows scrolling the list even if starting drag on header area (except on buttons)
          child: innerContent,
        ),
      );
    }

    // Para el resto (Ej: Search, Business), usamos color sólido del tema.
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: config.height ?? 130,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor, // Solid color for opacity
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: innerContent, // Content (Buttons, etc.)
      ),
    );
  }
}

// ==============================================================================
// 6. NAVIGATION BAR MODERNO
// ==============================================================================

class _ModernGlassNavBar extends ConsumerWidget {
  const _ModernGlassNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusinessMode = ref.watch(userModeProvider);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    bool isActive(String route) =>
        GoRouterState.of(context).uri.toString().startsWith(route);

    if (!isBusinessMode) {
      // --- CLIENT VIEW (Strictly 3 buttons) ---
      return SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: ModernGlass(
              height: 70,
              borderRadius: 35,
              opacity: 0.08,
              blur: 30,
              border: true,
              tintColor: Theme.of(context).cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    context,
                    Icons.shopping_bag_outlined,
                    t['nav_requests'] ?? 'Compras',
                    '/client/dashboard/requests',
                    isActive('/client/dashboard/requests'),
                  ),
                  _buildNavItem(
                    context,
                    Icons.search_rounded,
                    t['nav_market'] ?? 'Buscar',
                    '/search',
                    isActive('/search'),
                  ),
                  _buildNavItem(
                    context,
                    Icons.help_outline_rounded,
                    t['nav_support'] ?? 'Soporte',
                    '/client/dashboard/support', // Placeholder
                    isActive('/client/dashboard/support'),
                  ),
                  _buildNavItem(
                    context,
                    Icons.person_outline_rounded,
                    t['nav_profile'] ?? 'Perfil',
                    '/profile',
                    isActive('/profile'),
                  ),
                  // Note: FAB is hidden in Client Mode as per "son solo estos"
                ],
              ),
            ),
          ),
        ),
      );
    }

    // --- BUSINESS / ADMIN VIEW (Legacy + Search FAB) ---
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: ModernGlass(
                height: 70,
                borderRadius: 35,
                opacity: 0.08,
                blur: 30,
                border: true,
                tintColor: Theme.of(context).cardColor,
                child: _buildNavItems(context, isActive, t),
              ),
            ),
            const SizedBox(width: 16),
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

  Widget _buildNavItems(
    BuildContext context,
    bool Function(String) isActive,
    Map<String, String> t,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem(
          context,
          Icons.shopping_bag_outlined,
          t['nav_buy'] ?? 'Buy',
          '/client',
          isActive('/client'),
        ),
        _buildNavItem(
          context,
          Icons.receipt_long_outlined,
          t['nav_sell'] ?? 'Sell',
          '/business',
          isActive('/business'),
        ),
        _buildNavItem(
          context,
          Icons.cleaning_services_outlined,
          t['nav_office'] ?? 'Office',
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
    // Only use blue accent if active
    final color = active
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.onSurface.withOpacity(0.6);

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
                  style: GoogleFonts.inter(
                    // Use Layout's imported font
                    color: color,
                    fontSize: 10,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
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

        final isBusinessMode = ref.watch(userModeProvider);
        final profileState = ref.watch(profileProvider);
        final user = profileState.value;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        // Resolve Image Source
        String? displayImage;
        if (isLoggedIn && user != null) {
          if (isBusinessMode) {
            // Use Business Profile Image
            displayImage = user.businessProfileImage ?? user.photoId;
          } else {
            // Use Client Profile Image
            displayImage = user.photoId;
          }
        }

        return InkWell(
          onTap: () {
            final currentRoute = GoRouterState.of(context).uri.toString();
            showProfileBottomSheet(context, currentRoute);
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(2), // Border width
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isLoggedIn
                  ? LinearGradient(
                      colors: isBusinessMode
                          ? [
                              Colors.purpleAccent,
                              Colors.deepPurple,
                            ] // Differentiate Business Border
                          : [const Color(0xFF4285F4), const Color(0xFF90CAF9)],
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
                        displayImage != null &&
                        displayImage.isNotEmpty)
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(displayImage),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child:
                  (isLoggedIn &&
                      displayImage != null &&
                      displayImage.isNotEmpty)
                  ? null // Image is in decoration
                  : Center(
                      child: Icon(
                        isLoggedIn
                            ? (isBusinessMode
                                  ? Icons.store_mall_directory_outlined
                                  : Icons.person)
                            : Icons.person_outline,
                        color: Colors.white,
                        size: 20, // Adjusted size
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

void showProfileBottomSheet(BuildContext context, String currentRoute) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true, // Fix: Overlay above Custom NavBar
    backgroundColor: Theme.of(context).cardColor, // Use theme card color
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => ProfileBottomSheet(currentRoute: currentRoute),
  );
}

class ProfileBottomSheet extends ConsumerStatefulWidget {
  final String currentRoute;
  const ProfileBottomSheet({super.key, required this.currentRoute});

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
                    ref,
                  )
                else
                  _buildGuestView(context),

                const SizedBox(height: 16),

                // 2.5 OFFICE MENU (Contextual)
                if (widget.currentRoute.startsWith('/office'))
                  _buildOfficeMenu(context),

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
    WidgetRef ref, // Add ref to fetch providers
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final subTextColor = isDark ? Colors.grey[500] : Colors.grey[600];

    // Access Providers
    final isBusinessMode = ref.watch(userModeProvider);
    final profile = ref.watch(profileProvider).value;
    final hasBusiness = profile?.hasBusiness ?? false;

    // Translations
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {}; // Default to empty map if loading

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            t['switch_account'] ?? 'Switch Account Mode',
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

        // 1. CLIENT ACCOUNT
        _buildAccountOption(
          context: context,
          isSelected: !isBusinessMode,
          name: name.isEmpty ? (t['client_account'] ?? 'Client User') : name,
          subtitle: t['client_account'] ?? 'Personal Account',
          photoUrl: photoUrl,
          icon: Icons.person_rounded,
          onTap: () {
            ref.read(userModeProvider.notifier).setMode(false);
            context.pop(); // Close sheet
            // Optionally navigate to home to refresh view
            if (widget.currentRoute != '/client/dashboard/requests') {
              // Context might be unstable for .go if not carefully handled, but usually safe.
              // Better: use the GoRouter attached to the context safe way?
              // Actually context.go is an extension.
              // The issue was GoRouterState.of(context) which fails.
              // context.go() does lookup too but finding the Delegate not the State.
              context.go('/client/dashboard/requests');
            }
          },
        ),

        const SizedBox(height: 12),

        // 2. BUSINESS ACCOUNT (If exists)
        if (hasBusiness)
          _buildAccountOption(
            context: context,
            isSelected: isBusinessMode,
            name:
                profile?.businessName ??
                (t['business_account'] ?? 'My Business'),
            subtitle: t['business_account'] ?? 'Business Account',
            photoUrl:
                profile?.businessProfileImage, // Use the image from profile
            icon: Icons.store_rounded,
            onTap: () {
              ref.read(userModeProvider.notifier).setMode(true);
              context.pop();
              context.go('/business');
            },
          )
        else
          // Upsell/Create Business Optional
          _buildAccountOption(
            context: context,
            isSelected: false,
            name: t['create_business_title'] ?? 'Create Business',
            subtitle: t['create_business_subtitle'] ?? 'Start selling services',
            icon: Icons.add_business_rounded,
            onTap: () {
              context.pop();
              // Navigate to create business flow
              // context.push('/business/create');
            },
            isAction: true,
          ),

        const SizedBox(height: 12),

        // Add Account Button (Restore)
        InkWell(
          onTap: () {
            // TODO: fast account switching logic or login
            context.push('/login');
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isDark
                    ? Colors.white24
                    : (Colors.grey[300] ?? Colors.grey),
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
                  child: Icon(
                    Icons.add,
                    color: isDark ? Colors.white : const Color(0xFF1A1D21),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  t['add_account'] ?? 'Add another account',
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white : const Color(0xFF1A1D21),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // --- LANGUAGE SWITCHER ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            t['menu_language'] ?? 'Language / Idioma',
            style: GoogleFonts.inter(
              color: subTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildLangChip(context, ref, 'English', 'en', '🇺🇸'),
              _buildLangChip(context, ref, 'Español', 'es', '🇪🇸'),
              _buildLangChip(context, ref, 'Français', 'fr', '🇫🇷'),
              _buildLangChip(context, ref, 'Русский', 'ru', '🇷🇺'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Footer: Signed in as + Settings + Logout
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t['signed_in_as'] ?? 'Signed in as',
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
                if (context.mounted) {
                  context.pop();
                  await showAuthSuccessDialog(
                    context,
                    message: 'Gracias por visitar Connek.\\nAdiosss.',
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

  Widget _buildLangChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    String code,
    String flag,
  ) {
    final currentLocale = ref.watch(localeProvider);
    final isSelected = currentLocale == code;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => ref.read(localeProvider.notifier).setLocale(code),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4F87C9)
                : (isDark ? Colors.white10 : Colors.grey[200]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white70 : Colors.black87),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountOption({
    required BuildContext context,
    required bool isSelected,
    required String name,
    required String? subtitle,
    String? photoUrl,
    IconData? icon,
    required VoidCallback onTap,
    bool isAction = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final borderColor = isSelected
        ? const Color(0xFF4F87C9)
        : (isDark ? Colors.white24 : (Colors.grey[300] ?? Colors.grey));
    final bgColor = isSelected
        ? const Color(0xFF4F87C9).withOpacity(0.15)
        : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          children: [
            // Avatar / Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4F87C9)
                    : (isDark ? Colors.grey[800] : Colors.grey[200]),
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
                  : Icon(
                      icon ?? Icons.person,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black54),
                      size: 20,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF4F87C9), size: 20)
            else if (!isAction)
              const Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey,
                size: 20,
              ),
            if (isAction)
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
          ],
        ),
      ),
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

  Widget _buildOfficeMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1F24) : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business_center_outlined,
                size: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                'OFFICE MENU',
                style: GoogleFonts.inter(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildOfficeMenuItem(context, 'Overview', Icons.dashboard_outlined),
          _buildOfficeMenuItem(context, 'Reports', Icons.bar_chart_rounded),
          _buildOfficeMenuItem(context, 'Team', Icons.people_outline_rounded),
        ],
      ),
    );
  }

  Widget _buildOfficeMenuItem(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        context.pop(); // Close sheet
        // TODO: Navigate to specific subsection if implemented
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                color: isDark ? Colors.white : const Color(0xFF1A1D21),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isDark ? Colors.white24 : Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
