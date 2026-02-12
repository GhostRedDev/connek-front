import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'greg_card.dart'; // Using our existing GregCard
import '../../../../core/providers/locale_provider.dart';
import '../providers/greg_provider.dart';

class OfficeMyBotsWidget extends ConsumerStatefulWidget {
  const OfficeMyBotsWidget({super.key});

  @override
  ConsumerState<OfficeMyBotsWidget> createState() => _OfficeMyBotsWidgetState();
}

class _OfficeMyBotsWidgetState extends ConsumerState<OfficeMyBotsWidget> {
  String _selectedFilterKey = 'filter_all';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t['office_my_bots_subtitle'] ??
                        'Find, train and tune your bots.',
                    style: GoogleFonts.outfit(
                      color:
                          Theme.of(context).textTheme.bodyMedium?.color ??
                          Colors.grey,
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
                      isDark,
                    ),
                    const SizedBox(width: 8),
                    _buildFilterButton(
                      'office_filter_active',
                      t['office_filter_active'] ?? 'Activos',
                      isDark,
                    ),
                    const SizedBox(width: 8),
                    _buildFilterButton(
                      'office_filter_inactive',
                      t['office_filter_inactive'] ?? 'Inactivos',
                      isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GRID
              _buildBotsGrid(context, ref),

              const SizedBox(height: 40), // Bottom spacer
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBotsGrid(BuildContext context, WidgetRef ref) {
    final gregState = ref.watch(gregProvider);

    // Default to active for UI test if not loaded, or handle loading state?
    // User wants it to work. If not loaded, we can't filter.
    // Assuming Greg is loaded or we show a loader.
    // For now, if not loaded, show nothing or loader.

    if (gregState is GregLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    bool isGregActive = true;
    if (gregState is GregLoaded) {
      isGregActive = gregState.greg.active;
    }

    // Filter Logic
    // filter_all -> Show Greg (regardless of status? No, usually All shows everything)
    // office_filter_active -> Show Greg if active
    // office_filter_inactive -> Show Greg if !active

    bool showGreg = false;
    if (_selectedFilterKey == 'filter_all') {
      showGreg = true;
    } else if (_selectedFilterKey == 'office_filter_active') {
      showGreg = isGregActive;
    } else if (_selectedFilterKey == 'office_filter_inactive') {
      showGreg = !isGregActive;
    }

    if (!showGreg) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Icon(
                Icons.smart_toy_outlined,
                size: 48,
                color: Theme.of(context).dividerColor,
              ),
              const SizedBox(height: 16),
              Text(
                'No bots found',
                style: GoogleFonts.inter(
                  color:
                      Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.75,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [GregCard(isActive: isGregActive)],
    );
  }

  Widget _buildFilterButton(String key, String label, bool isDark) {
    // ... existing filter button code ...
    final isSelected = _selectedFilterKey == key;

    return InkWell(
      onTap: () => setState(() => _selectedFilterKey = key),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
