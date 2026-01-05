import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connek_frontend/features/home/search_page.dart';
import 'package:connek_frontend/features/home/widgets/mobile_app_bar_widget.dart';
import 'package:connek_frontend/features/home/widgets/search_bar_widget.dart';
import 'package:connek_frontend/features/home/widgets/search_result_google_widget.dart';
import 'package:connek_frontend/features/home/widgets/search_result_google_card.dart';
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

      await tester.pumpAndSettle(); // Wait for animations/futures

    // Verify Google Widget Logic is present
    expect(find.byType(SearchResultGoogleWidget), findsOneWidget);
    
    // Verify Cards are present
    expect(find.byType(SearchResultGoogleCard), findsWidgets);
      
      // Verify Search Bar is present (The one in the body)
      expect(find.byType(SearchBarWidget), findsOneWidget);
      expect(find.text('Busca un servicio o empresa'), findsOneWidget); // Hint text
      
      // Verify "Home" text IS present (since top search is disabled)
      expect(find.text('Home'), findsOneWidget);
      
      // Verify Nav Bar (Icon check)
      expect(find.byIcon(Icons.home), findsOneWidget);

      // Verify Login Dropdown Button in App Bar (replaces notification/profile icon)
      // Note: MobileAppBarWidget was updated to use LoginDropdownButton
      // We need to import it to find by type or find by icon (Icons.person inside white container)
      expect(find.byIcon(Icons.person), findsWidgets); 
    });
  });

}
