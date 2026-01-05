import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      
      // Wait for animations and routing to settle
      await tester.pumpAndSettle();

      // Verify that we start at the no-auth home page with the new design
      expect(find.text('connek'), findsOneWidget);
    });
  });
}
