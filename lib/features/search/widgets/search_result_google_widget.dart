import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_bar_widget.dart';
import 'search_result_google_card.dart';
import '../../../core/providers/locale_provider.dart';
import '../providers/search_provider.dart';

// Local state provider for the selected tab
// Local Notifier for the selected tab
class SelectedTabNotifier extends Notifier<String> {
  @override
  String build() => 'Servicios';

  void select(String tab) {
    state = tab;
  }
}

final selectedTabProvider = NotifierProvider<SelectedTabNotifier, String>(SelectedTabNotifier.new);

class SearchResultGoogleWidget extends ConsumerWidget {
  const SearchResultGoogleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final searchState = ref.watch(searchProvider);
    final selectedTab = ref.watch(selectedTabProvider);

    // Filter results based on selected tab
    final filteredResults = searchState.results.where((business) {
      if (selectedTab == 'Google') {
        return business.id < 0; // Negative ID for Google results
      } else {
        // 'Servicios' or 'Empresas' -> Local results (positive ID)
        // Ideally we would filter by category, but for now we group all locals
        return business.id > 0;
      }
    }).toList();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity, // Ensure it takes full height for the stack
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 210), // Add padding for floating tab bar
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
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
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t['search_hero_subtitle'] ??
                            'Explore thousands of verified businesses and services on our platform',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF95A1AC),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SearchBarWidget(
                        hintText:
                            t['search_placeholder'] ??
                            'Search for a service or business',
                        onChanged: (val) {
                          ref.read(searchProvider.notifier).onQueryChanged(val);
                        },
                        onSubmitted: (val) {
                          ref.read(searchProvider.notifier).onQueryChanged(val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Results Section
                  if (searchState.isLoading)
                    const Center(
                       child: Padding(
                         padding: EdgeInsets.all(20.0),
                         child: CircularProgressIndicator(color: Colors.white),
                       ),
                    )
                  else if (searchState.error != null)
                    Center(
                      child: Text(
                        'Error: ${searchState.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else if (searchState.results.isEmpty && searchState.query.isNotEmpty)
                    Center(
                      child: Column(
                        children: [
                           const Icon(Icons.search_off, size: 50, color: Colors.grey),
                           const SizedBox(height: 10),
                           Text(
                            t['no_results_found'] ?? 'No se encontraron resultados',
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )
                    )
                  else if (searchState.results.isNotEmpty)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${filteredResults.length} resultados de ${searchState.results.length} para: ${searchState.query}',
                            style: GoogleFonts.inter(
                              color: Colors.white, // Neutral100
                              fontSize: 14, // BodyMedium
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        if (filteredResults.isEmpty)
                           Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'No hay resultados en esta categoría',
                                style: GoogleFonts.inter(color: Colors.grey),
                              ),
                            ),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredResults.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final business = filteredResults[index];
                              return SearchResultGoogleCard(business: business);
                            },
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),

        // Floating Tab Bar
        Positioned(
          bottom: 140,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2429), // Dark background
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabItem(ref, selectedTab, 'Servicios'),
                  _buildTabItem(ref, selectedTab, 'Empresas'),
                  _buildTabItem(ref, selectedTab, 'Google', icon: Icons.g_mobiledata), // Example icon for Google
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(WidgetRef ref, String currentTab, String label, {IconData? icon}) {
    final isSelected = currentTab == label;
    return GestureDetector(
      onTap: () {
        ref.read(selectedTabProvider.notifier).select(label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF262D34) : Colors.transparent, // Slightly lighter for selected
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? Border.all(color: Colors.white.withOpacity(0.1)) : null,
        ),
        child: Row(
          children: [
            if (label == 'Google') ...[
              // Custom Google G Style if needed, or just text/icon
               const Text(
                 'G', 
                 style: TextStyle(
                   color: Colors.red, 
                   fontWeight: FontWeight.bold,
                   fontSize: 18
                 )
               ),
               const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
