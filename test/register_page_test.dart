import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/auth/register_page.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });
  testWidgets('RegisterPage renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: const RegisterPage(),
        ),
      );

      // Verify Header
      expect(find.text('connek'), findsOneWidget); // Logo fallback text or image
      expect(find.text('Back to search'), findsOneWidget);
      expect(find.text('Register now on Connek!'), findsOneWidget);

      // Verify Form Fields
      expect(find.text('First name'), findsOneWidget);
      expect(find.text('Last name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Phone'), findsOneWidget);
      expect(find.text('Date of birth'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm password'), findsOneWidget);

      // Verify Buttons
      expect(find.text('Register now'), findsOneWidget);
      expect(find.text('Or register with'), findsOneWidget);
      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Log in now'), findsOneWidget);
    });
  });
}
