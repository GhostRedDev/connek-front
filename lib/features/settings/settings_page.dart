import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/services/biometric_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final currentLocale = ref.watch(localeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            t['settings'] ?? 'Settings',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          // --- Language Section ---
          _buildSectionHeader(context, t['settings_language'] ?? 'Language'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildLanguageOption(
                  context,
                  ref,
                  'English',
                  'en',
                  '🇺🇸',
                  currentLocale,
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                _buildLanguageOption(
                  context,
                  ref,
                  'Español',
                  'es',
                  '🇪🇸',
                  currentLocale,
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                _buildLanguageOption(
                  context,
                  ref,
                  'Français',
                  'fr',
                  '🇫🇷',
                  currentLocale,
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                _buildLanguageOption(
                  context,
                  ref,
                  'Русский',
                  'ru',
                  '🇷🇺',
                  currentLocale,
                ),
              ],
            ),
          ),

          // --- Security Section ---
          _buildSectionHeader(context, t['settings_security'] ?? 'Seguridad'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(children: [_buildBiometricOption(context, ref, t)]),
          ),

          const SizedBox(height: 30),

          // --- Appearance Section ---
          _buildSectionHeader(
            context,
            t['settings_appearance'] ?? 'Appearance',
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildThemeOption(
                  context,
                  ref,
                  t['settings_theme_light'] ?? 'Light',
                  ThemeMode.light,
                  Icons.wb_sunny_rounded,
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                _buildThemeOption(
                  context,
                  ref,
                  t['settings_theme_dark'] ?? 'Dark',
                  ThemeMode.dark,
                  Icons.nightlight_round,
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                _buildThemeOption(
                  context,
                  ref,
                  t['settings_theme_system'] ?? 'System',
                  ThemeMode.system,
                  Icons.settings_system_daydream_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[400]
            : Colors.grey[600],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    String label,
    String code,
    String flag,
    String currentCode,
  ) {
    final isSelected = code == currentCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: () => ref.read(localeProvider.notifier).setLocale(code),
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF4285F4))
          : null,
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    String label,
    ThemeMode mode,
    IconData icon,
  ) {
    final currentMode = ref.watch(themeProvider);
    final isSelected = currentMode == mode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: () => ref.read(themeProvider.notifier).setTheme(mode),
      leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
      title: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF4285F4))
          : null,
    );
  }

  Widget _buildBiometricOption(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> t,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<bool>(
      future: ref.read(biometricServiceProvider).isBiometricEnabled(),
      builder: (context, snapshot) {
        final isEnabled = snapshot.data ?? false;

        return SwitchListTile(
          value: isEnabled,
          onChanged: (value) async {
            await ref.read(biometricServiceProvider).setBiometricEnabled(value);
            // Force rebuild to update UI state
            (context as Element).markNeedsBuild();
          },
          secondary: Icon(
            Icons.fingerprint,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          title: Text(
            t['settings_biometric'] ?? 'Ingreso Biométrico',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          activeThumbColor: const Color(0xFF4285F4),
        );
      },
    );
  }
}
