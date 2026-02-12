import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/auth/forgot_password_page.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('ForgotPasswordPage renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: const ForgotPasswordPage(),
        ),
      );

      // Verify Header
      expect(find.text('connek'), findsOneWidget); // Logo fallback or image
      expect(find.text('Back to search'), findsOneWidget);
      expect(find.text('Forgot password'), findsOneWidget);

      // Verify Content
      expect(find.text('Enter your email address'), findsOneWidget);
      expect(find.text('You will receive an email to confirm your password reset.'), findsOneWidget);
      expect(find.text('Send email'), findsOneWidget);
    });
  });
}
