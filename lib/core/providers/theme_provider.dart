import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. App Theme Definitions
class AppTheme {
  // --- DARK THEME (Existing Premium Dark) ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF4F87C9), // App Blue
    scaffoldBackgroundColor: const Color(0xFF131619), // Deep Dark
    cardColor: const Color(0xFF1E1E1E), // Slightly lighter for cards
    
    // Text Theme (Dark Mode)
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.white),
    
    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4F87C9),
      secondary: Color(0xFF4285F4),
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF131619),
      onBackground: Colors.white,
    ),
  );

  // --- LIGHT THEME (New Premium Light) ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF4F87C9),
    scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Premium Light Grey/White
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
      background: Color(0xFFF5F7FA),
      onBackground: Color(0xFF1A1D21),
    ),
  );
}

// 2. Theme Notifier
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  void setTheme(ThemeMode mode) {
    state = mode;
  }
}

// 3. Provider Definition
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);
