import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistence {
  static const String prefsKey = 'theme_mode';

  static String encode(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'system',
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
    };
  }

  static ThemeMode decode(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}

// Theme Notifier
class ThemeNotifier extends Notifier<ThemeMode> {
  ThemeNotifier({ThemeMode? initialTheme}) : _initialTheme = initialTheme;

  final ThemeMode? _initialTheme;

  @override
  ThemeMode build() {
    // If main() preloaded the value, use it to avoid startup flicker.
    final initial = _initialTheme ?? ThemeMode.system;

    // Also attempt a lazy load in case we weren't preloaded.
    unawaited(_loadFromPrefsIfNeeded(current: initial));
    return initial;
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    unawaited(_saveToPrefs(mode));
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    unawaited(_saveToPrefs(state));
  }

  Future<void> _loadFromPrefsIfNeeded({required ThemeMode current}) async {
    // If a caller provided an initialTheme, we can skip reading.
    if (_initialTheme != null) {
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = ThemePersistence.decode(
        prefs.getString(ThemePersistence.prefsKey),
      );

      if (saved != current) {
        state = saved;
      }
    } catch (_) {
      // Ignore persistence failures.
    }
  }

  Future<void> _saveToPrefs(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        ThemePersistence.prefsKey,
        ThemePersistence.encode(mode),
      );
    } catch (_) {
      // Ignore persistence failures.
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

// App Theme Definition
class AppTheme {
  // Material Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.blueAccent,
      surface: Colors.white,
      background: Color(0xFFF5F5F5),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    useMaterial3: true,
  );

  // Material Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.blueAccent,
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
  );

  // Shadcn Light Theme
  static final shadThemeLight = ShadThemeData(
    brightness: Brightness.light,
    colorScheme: const ShadZincColorScheme.light(background: Color(0xFFF5F5F5)),
  );

  // Shadcn Dark Theme
  static final shadThemeDark = ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: const ShadZincColorScheme.dark(background: Color(0xFF121212)),
  );
}
