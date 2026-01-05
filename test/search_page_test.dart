import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/home/search_page.dart';
import 'package:connek_frontend/features/home/widgets/mobile_app_bar_widget.dart';
import 'package:connek_frontend/features/home/widgets/search_bar_widget.dart';
import 'package:connek_frontend/features/home/widgets/search_result_reel_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('SearchPage renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async { // Mock network images
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(prompt: 'Cleaning'),
        ),
      );

      await tester.pumpAndSettle(); // Wait for animations/futures

      // Verify Search Results Grid
      expect(find.byType(GridView), findsOneWidget);
      
      // Verify Cards are present
      expect(find.byType(SearchResultReelCard), findsWidgets);
      
      // Verify Search Bar is present
      expect(find.byType(SearchBarWidget), findsOneWidget);
      expect(find.text('Busca un servicio o empresa'), findsOneWidget); // Hint text
      
      // Verify "Home" text is NOT present (replaced by search bar)
      expect(find.text('Home'), findsNothing);
      
      // Verify Nav Bar (Icon check)
      expect(find.byIcon(Icons.home), findsOneWidget);
    });
  });

  testWidgets('SearchPage empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SearchPage(prompt: ''),
      ),
    );

    expect(find.text('Start typing to search...'), findsOneWidget);
  });
}
