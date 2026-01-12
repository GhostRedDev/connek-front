import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/router.dart';
import 'core/providers/theme_provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
// import 'core/services/supabase_config_service.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // LiquidGlassLayer configuration removed due to final field error
  // Using SimpleGlassContainer by default in AppLayout instead.

  await _startApp();
}

Future<void> _startApp() async {
  // Hardcoded Supabase Config to prevent startup hang
  const supabaseUrl = 'https://bzndcfewyihbytjpitil.supabase.co';
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6bmRjZmV3eWloYnl0anBpdGlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc1ODM2MzYsImV4cCI6MjAxMzE1OTYzNn0.pPtLFyOjTCuErcEGdcCh6Htg2pkqqb5xJRH2wLmRa4Y';

  try {
    debugPrint("Initializing Supabase...");

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    debugPrint("Supabase Initialized successfully.");

    // Success: Run the main app
    runApp(
      ProviderScope(
        child: DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const MyApp(),
        ),
      ),
    );
  } catch (e) {
    debugPrint("CRITICAL ERROR: Failed to init Supabase. \n$e");
    // Failure: Run the error screen
    runApp(ConnectionErrorScreen(error: e.toString(), onRetry: _startApp));
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme provider for changes
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Connek',
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode, // Dynamic Theme Mode (System/Light/Dark)

      routerConfig: ref.watch(routerProvider),
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
