import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_bar_widget.dart';
import 'search_result_google_card.dart';
import '../../../core/providers/locale_provider.dart';

class SearchResultGoogleWidget extends ConsumerWidget {
  const SearchResultGoogleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment
                .start, // Align top (standard) although original had center for crossAxis? Original had center for crossAxis, start for main.
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Section
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 40), // Top spacing
                  Text(
                    t['search_hero_title'] ?? 'Find the service you need',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 32, // DisplaySmall approx
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t['search_hero_subtitle'] ??
                        'Explore thousands of verified businesses and services on our platform',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF95A1AC), // Secondary300 approx
                      fontSize: 14, // BodySmall approx
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SearchBarWidget(
                    hintText:
                        t['search_placeholder'] ??
                        'Search for a service or business',
                    onSubmitted: (val) {
                      final msg = (t['searching_for'] ?? 'Buscando: {query}...')
                          .replaceAll('{query}', val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(msg),
                          backgroundColor: const Color(0xFF22262B),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Results Section
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align count text to start
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (t['search_results_count'] ??
                              '65 resultados para: Servicios de diseño web')
                          .replaceAll('{count}', '65')
                          .replaceAll('{query}', 'Servicios de diseño web'),
                      style: GoogleFonts.inter(
                        color: Colors.white, // Neutral100
                        fontSize: 14, // BodyMedium
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Results List
                  // The original code had an empty column. We will populate it for visualization.
                  // Since reel card is designed for grid, we can just show a few or adapt.
                  // Or just use placeholders like "Generic Result Tile".
                  // Let's use a Wrap or Grid inside Column for the Reel cards, or just list items.
                  // Given "Google" name, maybe list items are better.
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4, // Show a few cards
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return const SearchResultGoogleCard();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
