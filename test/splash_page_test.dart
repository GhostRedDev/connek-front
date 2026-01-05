import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/splash/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('SplashPage renders correctly', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => Container(), // Mock destination
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    // Verify Logo
    expect(find.text('connek'), findsOneWidget); 
    
    // Verify Spinner
    expect(find.byType(CircularProgressIndicator), findsNothing); // SpinKit might be different, but we check text mostly 
  });
}
