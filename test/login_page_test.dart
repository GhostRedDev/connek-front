import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/auth/login_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('LoginPage renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LoginPage(),
        ),
      );

      // Verify Header
      expect(find.text('connek'), findsOneWidget);
      expect(find.text('Back to search'), findsOneWidget);

      // Verify Form
      expect(find.text('Search and find services'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      
      // Verify Social Buttons
      expect(find.text('Sign in with Google'), findsOneWidget);
      expect(find.text('Sign in with Apple'), findsOneWidget);
      expect(find.text('Sign up now'), findsOneWidget);
    });
  });
}
