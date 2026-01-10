import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. App Theme Definitions
class AppTheme {
  // --- DARK THEME (Existing Premium Dark) ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF4F87C9), // App Blue
    scaffoldBackgroundColor: const Color(0xFF131619), // Deep Dark
    cardColor: const Color(0xFF1E1E1E), // Slightly lighter for cards
    // Text Theme (Dark Mode)
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),

    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.white),

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4F87C9),
      secondary: Color(0xFF4285F4),
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
  );

  // --- LIGHT THEME (New Premium Light) ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF4F87C9),
    scaffoldBackgroundColor: const Color(
      0xFFF5F7FA,
    ), // Premium Light Grey/White
    cardColor: const Color(0xFFFFFFFF),

    // Text Theme (Light Mode)
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: const Color(0xFF1A1D21), // Dark text for contrast
      displayColor: const Color(0xFF1A1D21),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Color(0xFF1A1D21)),

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4F87C9),
      secondary: Color(0xFF4285F4),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1D21),
    ),
  );
}

// 2. Theme Notifier with Persistence
class ThemeNotifier extends Notifier<ThemeMode> {
  static const String _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    // Synchronously try to load (hacky but standard for simple providers)
    // Better pattern is async init, but let's default to system then correct.
    _loadTheme();
    return ThemeMode.system;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      if (savedTheme == 'light') state = ThemeMode.light;
      if (savedTheme == 'dark') state = ThemeMode.dark;
      if (savedTheme == 'system') state = ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    String modeStr = 'system';
    if (mode == ThemeMode.light) modeStr = 'light';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    await prefs.setString(_themeKey, modeStr);
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setTheme(ThemeMode.light);
    } else {
      setTheme(ThemeMode.dark);
    }
  }
}

// 3. Provider Definition
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
