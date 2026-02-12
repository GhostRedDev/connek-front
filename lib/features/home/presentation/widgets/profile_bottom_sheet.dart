import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../settings/providers/profile_provider.dart';
import '../../auth/widgets/auth_success_overlay.dart';

// Design System Components (React-style)
import '../../../../system_ui/utils/theme_toggle.dart';
import '../../../../system_ui/navigation/menu_items.dart';
import '../../../../system_ui/data_display/avatars.dart';
import '../../../../system_ui/typography.dart';

// Helper to show the bottom sheet
void showProfileBottomSheet(BuildContext context) {
  showShadSheet(
    side: ShadSheetSide.bottom,
    context: context,
    builder: (context) => const ProfileBottomSheet(),
  );
}

class ProfileBottomSheet extends ConsumerWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final profileState = ref.watch(profileProvider);
    final profile = profileState.value;

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;
        final user = session?.user;

        final String fullName =
            (profile != null &&
                (profile.firstName.isNotEmpty || profile.lastName.isNotEmpty))
            ? '${profile.firstName} ${profile.lastName}'.trim()
            : (user?.email ?? 'Guest');

        final String email = user?.email ?? '';

        return ShadSheet(
          title: Text(isLoggedIn ? 'Perfil' : 'Bienvenido'),
          description: Text(
            isLoggedIn
                ? 'Administra tu cuenta'
                : 'Inicia sesión para continuar',
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Theme Toggle Group Component
                ThemeToggleGroup(
                  currentMode: themeMode,
                  onThemeChanged: (mode) =>
                      ref.read(themeProvider.notifier).setTheme(mode),
                ),

                const SizedBox(height: 24),

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
              ],
            ),
          ),
          actions: [
            if (isLoggedIn)
              ShadButton.destructive(
                width: double.infinity,
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    await showAuthSuccessDialog(
                      context,
                      message: 'Gracias por visitar Connect.\nAdiosss.',
                      isLogin: false,
                    );
                    if (context.mounted) context.go('/');
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 16),
                    SizedBox(width: 8),
                    Text('Cerrar Sesión'),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildAuthenticatedView(
    BuildContext context,
    String name,
    String email,
    String? photoUrl,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Active Account Card
        ShadCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AppAvatar(
                src: photoUrl,
                alt: name.isNotEmpty ? name : 'U',
                size: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [AppText.h4(name), AppText.muted(email)],
                ),
              ),
              ShadButton.outline(
                icon: const Icon(Icons.settings, size: 16),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/profile?tab=settings');
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Add Account / Switch (Placeholder)
        ShadButton.ghost(
          width: double.infinity,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add, size: 16),
              SizedBox(width: 8),
              Text('Agregar otra cuenta'),
            ],
          ),
          onPressed: () => context.push('/login'),
        ),
      ],
    );
  }

  Widget _buildGuestView(BuildContext context) {
    return Column(
      children: [
        // 2. Menu Link Items (React-style Props)
        MenuLinkItem(
          label: 'Log In',
          icon: Icons.arrow_forward_rounded,
          onTap: () {
            Navigator.of(context).pop();
            context.push('/login');
          },
        ),
        const SizedBox(height: 16),
        MenuLinkItem(
          label: 'Register',
          icon: Icons.person_add_outlined,
          onTap: () {
            Navigator.of(context).pop();
            context.push('/register');
          },
        ),
      ],
    );
  }
}
