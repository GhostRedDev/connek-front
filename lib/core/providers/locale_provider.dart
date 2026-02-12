import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:ui' as ui;

// --- Locale State ---

// Stores the currently selected language code (default: system or 'en')
class LocaleNotifier extends Notifier<String> {
  @override
  String build() {
    // Auto-detect system locale
    final systemLoc = ui.window.locale.languageCode; // or platformDispatcher
    if (['es', 'fr', 'ru'].contains(systemLoc)) {
      return systemLoc;
    }
    return 'en'; // Default fallback
  }

  void setLocale(String languageCode) {
    state = languageCode;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, String>(
  LocaleNotifier.new,
);

// --- Translation Loader ---

// Loads the JSON file corresponding to the current locale
final translationProvider = FutureProvider<Map<String, String>>((ref) async {
  final locale = ref.watch(localeProvider);
  String jsonString;

  // Map locale code to filename
  String filename;
  switch (locale) {
    case 'es':
      filename = 'lang_spanish.json';
      break;
    case 'ru':
      filename = 'lang_russian.json';
      break;
    case 'fr':
      filename = 'lang_french.json';
      break;
    case 'en':
    default:
      filename = 'lang_english.json';
      break;
  }

  try {
    jsonString = await rootBundle.loadString('assets/lang/$filename');
  } catch (e) {
    // Fallback to just lang/ if assets/ prefix fails
    try {
      jsonString = await rootBundle.loadString('lang/$filename');
    } catch (e2) {
      print('Error loading locale $locale: $e, $e2');
      // Final fallback to English
      jsonString = await rootBundle.loadString('assets/lang/lang_english.json');
    }
  }

  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return jsonMap.map((key, value) => MapEntry(key, value.toString()));
});

// Helper provider to get a specific translation synchronously (if loaded)
// Usage: ref.watch(tProvider('nav_home'))
// Note: This might be tricky if async. Better pattern is to watch translationProvider in the widget
// and access the map directly. Or create a simpler helper class.
