import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/greg_card.dart';

class OfficePage extends ConsumerStatefulWidget {
  const OfficePage({super.key});

  @override
  ConsumerState<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends ConsumerState<OfficePage> {
  String _selectedFilter = 'Todos'; // Filters: Todos, Activos, Inactivos

  @override
  Widget build(BuildContext context) {
    // Determine background color based on theme - mocking dark theme for now as per design
    final backgroundColor = const Color(0xFF131619);

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Background handled by shell? Or set here.
      // If shell handles background, this is transparent. If not, set it.
      // Based on screenshot, it's a dark page.
      body: Container(
        color: backgroundColor, // Explicit background for this page
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Header
                Text(
                  'My bots',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Find, train and tune your bots.',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF95A1AC), // Light grey
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),

                // Filters
                Row(
                  children: [
                    _buildFilterChip('Todos'),
                    const SizedBox(width: 12),
                    _buildFilterChip('Activos'),
                    const SizedBox(width: 12),
                    _buildFilterChip('Inactivos'),
                  ],
                ),
                const SizedBox(height: 24),

                // Grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75, // Adjust for card height
                    children: [
                      // Always show GregCard for now as requested
                      // In real app, check state
                      const GregCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4B39EF).withOpacity(0.1) // Selected tint
              : const Color(0xFF262D34), // Unselected dark
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4B39EF) : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: isSelected ? const Color(0xFF4B39EF) : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
