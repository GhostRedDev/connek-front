import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

final selectedTabProvider = NotifierProvider<SelectedTabNotifier, String>(
  SelectedTabNotifier.new,
);

class SearchResultGoogleWidget extends ConsumerStatefulWidget {
  final bool autofocus;
  final VoidCallback? onClose; // Added callback

  const SearchResultGoogleWidget({
    super.key,
    this.autofocus = false,
    this.onClose,
  });

  @override
  ConsumerState<SearchResultGoogleWidget> createState() =>
      _SearchResultGoogleWidgetState();
}

class _SearchResultGoogleWidgetState
    extends ConsumerState<SearchResultGoogleWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _metaEffectController;
  double _scrollOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _metaEffectController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    // Fade in over 100 pixels
    final newOpacity = (offset / 100).clamp(0.0, 1.0);
    if (newOpacity != _scrollOpacity) {
      setState(() {
        _scrollOpacity = newOpacity;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _metaEffectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final searchState = ref.watch(searchProvider);
    final selectedTab = ref.watch(selectedTabProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final subTitleColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
    final cardBgColor = isDark ? const Color(0xFF1E2429) : Colors.white;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSearching = searchState.query.isNotEmpty;

    // Filter results based on selected tab
    final filteredResults = searchState.results.where((business) {
      if (selectedTab == 'Google') {
        return business.id < 0; // Negative ID for Google results
      } else {
        // 'Servicios' or 'Empresas' -> Show all local businesses
        return business.id > 0;
      }
    }).toList();

    return Stack(
      children: [
        // 0. AURORA BOREALIS LAYER
        if (isSearching)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.75, // Increased > 70%
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _metaEffectController,
                builder: (context, child) {
                  // Triangle wave 0->1->0 for smooth loop
                  final val = _metaEffectController.value;
                  final wave = (val < 0.5 ? val : (1.0 - val)) * 2.0;
                  // Sway range: -0.6 to +0.6
                  final xShift = -0.6 + (wave * 1.2);

                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(xShift, 1.0), // Swaying bottom
                        end: Alignment(-xShift, -1.0), // Swaying top opposite
                        colors: [
                          const Color(0xFF0000FF).withOpacity(0.3), // Blue
                          const Color(0xFFFF0000).withOpacity(0.2), // Red
                          Colors.white.withOpacity(0.15), // White
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4, 0.75, 1.0],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        // 1. RESULTS LAYER (Visible when searching)
        if (isSearching)
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                top: 120, // Space for Header
                bottom: 250, // Space for Tabs (110) + SearchBar (~60) + Padding
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (searchState.isLoading)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: isDark
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  else if (searchState.error != null)
                    Center(
                      child: Text(
                        'Error: ${searchState.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else if (searchState.results.isEmpty && isSearching)
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 50,
                            color: subTitleColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            t['no_results_found'] ??
                                'No se encontraron resultados',
                            style: GoogleFonts.inter(
                              color: textColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (filteredResults.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${filteredResults.length} resultados de ${searchState.results.length} para: ${searchState.query}',
                          style: GoogleFonts.inter(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 20),
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

        // 2. HERO CONTENT LAYER (Title + Subtitle)
        // Visible only when NOT searching (query empty)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          // Move up out of view (screenHeight) or stay above center
          bottom: isSearching ? screenHeight : (screenHeight / 2) + 50,
          left: 16,
          right: 16,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSearching ? 0.0 : 1.0,
            child: IgnorePointer(
              ignoring: isSearching,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSearching ? 0.9 : 1.0,
                curve: Curves.easeIn,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t['search_hero_title'] ?? 'Find the service you need',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: textColor,
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
                        color: subTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 3. SEARCH BAR LAYER
        // Moves between Center and Bottom
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutBack,
          bottom: isSearching ? 180 : (screenHeight / 2 - 25),
          left: 16,
          right: 16,
          child: SearchBarWidget(
            autofocus: widget.autofocus,
            hintText:
                t['search_placeholder'] ?? 'Search for a service or business',
            initialValue: searchState.query,
            onChanged: (val) {
              ref.read(searchProvider.notifier).onQueryChanged(val);
            },
            onSubmitted: (val) {
              ref.read(searchProvider.notifier).onQueryChanged(val);
            },
          ),
        ),

        // Custom Glass App Bar (Visible on Scroll)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            // Apply Blur
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10 * _scrollOpacity,
                sigmaY: 10 * _scrollOpacity,
              ),
              child: Container(
                height: 100, // Header height
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (isDark ? Colors.black : Colors.white).withOpacity(
                    0.8 * _scrollOpacity,
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: (isDark ? Colors.white : Colors.black).withOpacity(
                        0.1 * _scrollOpacity,
                      ),
                    ),
                  ),
                ),
                child: Opacity(
                  opacity:
                      1.0, // Always visible content, only background fades?
                  // User said: "appbar ... transparente ... al desplazarme tome un color".
                  // So the content (logo/icons) should ALWAYS be visible.
                  // The BG opacity is what changes (handled by Container decoration above).
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dummy spacer to balance if centering, or just logo on left?
                        // Layout usually centers title. Let's start with Logo Center logic or Left.
                        // Getting standard Header logic: TitleWidget is passed to AppBar title.
                        // Let's use a standard Row: [Spacer, Logo, Spacer(minus actions), Actions] is hard.
                        // Let's just use Stack or Row with specific alignment.

                        // Left: Logo
                        // Left: Logo with Back Button
                        Row(
                          children: [
                            if (widget.onClose != null ||
                                Navigator.of(context).canPop()) ...[
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                onPressed:
                                    widget.onClose ?? () => context.pop(),
                              ),
                              const SizedBox(width: 8),
                            ],
                            GestureDetector(
                              onTap:
                                  widget.onClose ??
                                  () {
                                    if (Navigator.of(context).canPop()) {
                                      context.pop();
                                    } else {
                                      context.go('/');
                                    }
                                  },
                              child: Image.asset(
                                isDark
                                    ? 'assets/images/conneck_logo_white.png'
                                    : 'assets/images/conneck_logo_dark.png',
                                height: 38,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),

                        // Right: Actions
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              color: textColor,
                              onPressed: () => context.push('/chats'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none),
                              color: textColor,
                              onPressed: () => context.push('/notifications'),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await Supabase.instance.client.auth.signOut();
                                if (context.mounted) context.go('/');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Floating Tab Bar
        Positioned(
          bottom: 110, // Moved down 30px (140 -> 110)
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: cardBgColor, // Dark background
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabItem(
                    ref,
                    selectedTab,
                    'Servicios',
                    context,
                    icon: Icons.design_services_outlined,
                  ),
                  _buildTabItem(
                    ref,
                    selectedTab,
                    'Empresas',
                    context,
                    icon: Icons.business_outlined,
                  ),
                  _buildTabItem(
                    ref,
                    selectedTab,
                    'Google',
                    context,
                    icon: Icons.g_mobiledata,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(
    WidgetRef ref,
    String currentTab,
    String label,
    BuildContext context, {
    IconData? icon,
  }) {
    final isSelected = currentTab == label;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedBg = isDark ? const Color(0xFF262D34) : Colors.grey.shade100;
    final contentColor = isSelected
        ? (isDark ? Colors.white : Colors.black)
        : Colors.grey;

    return GestureDetector(
      onTap: () {
        ref.read(selectedTabProvider.notifier).select(label);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ), // Increased horizontal padding slightly
        decoration: BoxDecoration(
          color: isSelected
              ? selectedBg
              : Colors.transparent, // Slightly lighter for selected
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade300,
                )
              : null,
        ),
        child: Row(
          children: [
            if (label == 'Google') ...[
              SvgPicture.asset(
                'assets/images/google-logo-icon.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
            ] else if (icon != null) ...[
              Icon(icon, size: 18, color: contentColor),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                color: contentColor,
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
