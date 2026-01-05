import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_bar_widget.dart';
import 'search_result_google_card.dart';

class SearchResultGoogleWidget extends StatelessWidget {
  const SearchResultGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start, // Align top (standard) although original had center for crossAxis? Original had center for crossAxis, start for main.
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Section
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 40), // Top spacing
                  Text(
                    'Encuentra el servicio que necesitas',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 32, // DisplaySmall approx
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Explora miles de empresas y servicios verificados en nuestra plataforma',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF95A1AC), // Secondary300 approx
                      fontSize: 14, // BodySmall approx
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SearchBarWidget(
                    onSubmitted: (val) {
                      // print('Search Google widget submitted: $val'); 
                      // In a real app, this would use a provider or callback. 
                      // For visual functionality as requested, we can suggest a loading state or just log.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Buscando: $val...'),
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
                crossAxisAlignment: CrossAxisAlignment.start, // Align count text to start
                children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                      '65 resultados para: Servicios de diseño web',
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
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
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
