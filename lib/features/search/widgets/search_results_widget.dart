import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_result_reel_card.dart';

class SearchResultsWidget extends StatelessWidget {
  final String prompt;

  const SearchResultsWidget({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    // Placeholder results - in real app, these would be models
    final results = List.generate(6, (index) => 'Item $index');

    if (prompt.isEmpty) {
      return Center(
        child: Text(
          'Start typing to search...',
          style: GoogleFonts.outfit(color: Colors.white70, fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(top: 110, bottom: 80, left: 16, right: 16), // Padding for App Bar and Nav Bar
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65, // Adjust based on card dimensions (163/250 ~= 0.65)
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return const SearchResultReelCard();
      },
    );
  }
}
