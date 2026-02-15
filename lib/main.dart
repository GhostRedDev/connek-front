import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/router.dart';
import 'core/providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Correct placement
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'core/services/supabase_config_service.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appInitProvider = FutureProvider<void>((ref) async {
  // Prevent Font Scaling issues
  // ignore: deprecated_member_use
  GoogleFonts.config.allowRuntimeFetching = true;

  debugPrint("Initializing app...");
  try {
    await dotenv.load(fileName: "assets/env");
  } catch (e1) {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e2) {
      debugPrint("Failed to load env from assets/env or .env: $e1, $e2");
    }
  }

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];

  if (supabaseUrl == null || supabaseKey == null) {
    throw Exception('Supabase configuration missing in .env file');
  }

  debugPrint("Initializing Supabase...");
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  debugPrint("Supabase Initialized successfully.");
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();
  final initialTheme = ThemePersistence.decode(
    prefs.getString(ThemePersistence.prefsKey),
  );

  // LiquidGlassLayer configuration removed due to final field error
  // Using SimpleGlassContainer by default in AppLayout instead.

  // Optimize Font Loading for Web to prevent Layout Shift/Assertion
  // await GoogleFonts.pendingFonts([
  //   GoogleFonts.inter(),
  //   GoogleFonts.roboto(),
  // ]);
  // Actually, waiting for them can slow startup.
  // Better to just ensure they are fetched or use a fallback.
  // The assertion "RenderParagraph._scheduleSystemFontsUpdate" happens when fonts load mid-frame.
  // We can try to suppress it by ensuring WidgetsBinding is fully ready? It is.

  runApp(
    ProviderScope(
      overrides: [
        themeProvider.overrideWith(
          () => ThemeNotifier(initialTheme: initialTheme),
        ),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme provider for changes
    final themeMode = ref.watch(themeProvider);
    final initAsync = ref.watch(appInitProvider);

    return initAsync.when(
      loading: () {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
      error: (e, _) {
        debugPrint("CRITICAL ERROR: Failed to init Supabase. \n$e");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ConnectionErrorScreen(
            error: e.toString(),
            onRetry: () => ref.invalidate(appInitProvider),
          ),
        );
      },
      data: (_) {
        return ShadApp.router(
          title: 'Connek',
          debugShowCheckedModeBanner: false,

          // Theme Configuration
          theme: AppTheme.shadThemeLight,
          darkTheme: AppTheme.shadThemeDark,
          themeMode: themeMode,

          // Bridge to Material Theme
          materialThemeBuilder: (context, theme) {
            return theme.brightness == Brightness.dark
                ? AppTheme.darkTheme
                : AppTheme.lightTheme;
          },

          routerConfig: ref.watch(routerProvider),

          // Localization
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('es', '')],
        );
      },
    );
  }
}

class ConnectionErrorScreen extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ConnectionErrorScreen({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Connection Failed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Could not fetch configuration from server. Please check your internet connection or try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 12),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text('Retry Connection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
