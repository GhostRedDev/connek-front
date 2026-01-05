import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/home/widgets/search_result_google_widget.dart';
import 'package:connek_frontend/features/home/widgets/search_result_google_card.dart';
import 'package:connek_frontend/features/home/widgets/search_bar_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('SearchResultGoogleWidget renders correctly', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SearchResultGoogleWidget(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Header Text
      expect(find.text('Encuentra el servicio que necesitas'), findsOneWidget);
      expect(find.textContaining('65 resultados para'), findsOneWidget);

      // Verify Search Bar
      expect(find.byType(SearchBarWidget), findsOneWidget);

      // Verify Cards
      expect(find.byType(SearchResultGoogleCard), findsWidgets);
      
      // Verify specific card content (from the first card or all)
      expect(find.text('AR Labs & Vision'), findsWidgets);
      expect(find.text('Invitar a Connek'), findsWidgets);
    });
  });
}
