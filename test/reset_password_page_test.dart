import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/auth/reset_password_page.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('ResetPasswordPage renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: const ResetPasswordPage(),
        ),
      );

      // Verify Header
      expect(find.text('connek'), findsOneWidget); 
      expect(find.text('Back to search'), findsOneWidget);
      expect(find.text('Enter new password'), findsOneWidget);
      expect(find.text('Enter new password again'), findsOneWidget);
      expect(find.text('Reset password'), findsOneWidget);
    });
  });
}
