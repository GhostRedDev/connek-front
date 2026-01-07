import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/router.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/supabase_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Cambia esto por la URL de tu backend desplegado (o IP local)
  // Ejemplo: "https://connek-ai.herokuapp.com"
  const backendUrl = "https://connek-dev-aa5f5db19836.herokuapp.com"; 

  try {
    debugPrint("Fetching Supabase config from $backendUrl...");
    final config = await SupabaseConfig.fetch(backendUrl);
    debugPrint("Initializing Supabase with fetched config...");
    
    await Supabase.initialize(
      url: config.url,
      anonKey: config.anonKey,
    );
    debugPrint("Supabase Initialized successfully.");
  } catch (e) {
    debugPrint("CRITICAL ERROR: Failed to init Supabase via Backend Config. \n$e");
    // Fallback? Or just crash/log.
  }

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Connek',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
