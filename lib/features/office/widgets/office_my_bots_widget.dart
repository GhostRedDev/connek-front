import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'greg_card.dart'; // Using our existing GregCard
import '../../../../core/providers/locale_provider.dart';

class OfficeMyBotsWidget extends ConsumerStatefulWidget {
  const OfficeMyBotsWidget({super.key});

  @override
  ConsumerState<OfficeMyBotsWidget> createState() => _OfficeMyBotsWidgetState();
}

class _OfficeMyBotsWidgetState extends ConsumerState<OfficeMyBotsWidget> {
  String _selectedFilterKey = 'filter_all';

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // Left aligned header
            children: [
              const SizedBox(height: 20), // EmptySpaceTopWidget replacement
              // Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t['office_my_bots_title'] ?? 'My bots',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t['office_my_bots_subtitle'] ??
                        'Find, train and tune your bots.',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF95A1AC), // Secondary300
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16), // Spacing
              // Filters Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisSize: MainAxisSize.max, // Let it shrink
                  children: [
                    _buildFilterButton(
                      'filter_all',
                      t['filter_all'] ?? 'Todos',
                    ),
                    const SizedBox(width: 8),
                    _buildFilterButton(
                      'office_filter_active',
                      t['office_filter_active'] ?? 'Activos',
                    ),
                    const SizedBox(width: 8),
                    _buildFilterButton(
                      'office_filter_inactive',
                      t['office_filter_inactive'] ?? 'Inactivos',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GRID
              // Using existing GregCard (renamed from MyBotsGregWidget to be consistent with our project)
              // Logic: Only show if bots exist (dummy check)
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    0.75, // Adjust for card aspect ratio (160x220)
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Let SingleChildScrollView handle scroll
                padding: EdgeInsets.zero,
                children: const [
                  GregCard(),
                  // Add more cards here if list is populated
                ],
              ),

              const SizedBox(height: 40), // Bottom spacer
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String key, String label) {
    final isSelected = _selectedFilterKey == key;
    // Tweak colors to match design
    // Active: Green/White? No, design shows "Todos" dark in snippet 2 (unselected?).
    // Snippet 1 implies simple pill buttons.
    // Let's use the style from the previous OfficePage implementation which user liked.

    return InkWell(
      onTap: () => setState(() => _selectedFilterKey = key),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4B39EF).withOpacity(0.2)
              : const Color(0xFF262D34), // SecondaryAlpha10
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? const Color(0xFF4B39EF) : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: isSelected
                ? Colors.white
                : const Color(0xFF95A1AC), // Secondary300
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
