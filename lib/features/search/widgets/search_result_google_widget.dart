import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'search_bar_widget.dart';
import 'search_result_google_card.dart';
import 'search_result_service_card.dart';
import 'package:connek_frontend/features/search/models/business_model.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../system_ui/core/constants.dart';
import '../providers/search_provider.dart';
import '../providers/job_search_provider.dart';
import 'search_result_job_card.dart';
import '../models/service_search_item.dart';

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
    final isJobsTab = selectedTab == 'Trabajos';

    final jobsAsync = ref.watch(jobSearchProvider(searchState.query));

    // Filter results based on selected tab.
    // Backend marks service-only hits as category == 'Service Result'
    // and Google hits as negative IDs with category == 'Google Result'.
    const serviceResultCategory = 'Service Result';

    final List<Business> googleResults = searchState.results
        .where((b) => b.id < 0)
        .toList();
    final List<Business> localResults = searchState.results
        .where((b) => b.id > 0)
        .toList();
    final List<Business> serviceResults = localResults
        .where((b) => (b.category ?? '') == serviceResultCategory)
        .toList();
    final List<Business> businessResults = localResults
        .where((b) => (b.category ?? '') != serviceResultCategory)
        .toList();

    final List<Business> filteredResults = switch (selectedTab) {
      'Google' => googleResults,
      'Servicios' => serviceResults,
      'Empresas' => businessResults,
      'Trabajos' => const <Business>[],
      _ => localResults,
    };

    final List<ServiceSearchItem> serviceItems = selectedTab == 'Servicios'
        ? filteredResults
              .where((b) => b.services.isNotEmpty)
              .map(
                (b) => ServiceSearchItem.fromBusinessAndService(
                  business: b,
                  service: b.services.first,
                ),
              )
              .toList()
        : const <ServiceSearchItem>[];

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
                          const Color(0xFF0000FF).withAlpha(77), // Blue
                          const Color(0xFFFF0000).withAlpha(51), // Red
                          Colors.white.withAlpha(38), // White
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
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.ultraWide,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isJobsTab)
                          jobsAsync.when(
                            data: (jobs) {
                              if (jobs.isEmpty && isSearching) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.work_outline,
                                        size: 50,
                                        color: subTitleColor,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'No se encontraron trabajos',
                                        style: GoogleFonts.inter(
                                          color: textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${jobs.length} trabajos para: ${searchState.query}',
                                    style: GoogleFonts.inter(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: jobs.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 16),
                                    itemBuilder: (context, index) {
                                      final job = jobs[index];
                                      return SearchResultJobCard(job: job);
                                    },
                                  ),
                                ],
                              );
                            },
                            loading: () => Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                  color: isDark
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            error: (e, s) => Center(
                              child: Text(
                                'Error: $e',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          )
                        else if (searchState.isLoading)
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
                        else if ((selectedTab == 'Servicios'
                            ? serviceItems.isNotEmpty
                            : filteredResults.isNotEmpty))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${selectedTab == 'Servicios' ? serviceItems.length : filteredResults.length} resultados de ${searchState.results.length} para: ${searchState.query}',
                                style: GoogleFonts.inter(
                                  color: textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (selectedTab == 'Servicios')
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: serviceItems.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    return SearchResultServiceCard(
                                      service: serviceItems[index],
                                    );
                                  },
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
                                    return SearchResultGoogleCard(
                                      business: business,
                                    );
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

        // 2. HERO CONTENT LAYER (Title + Subtitle)
        // Visible only when NOT searching (query empty)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          // Move up out of view (screenHeight) or stay above center
          bottom: isSearching
              ? screenHeight
              : (screenHeight / 2) + 80, // Moved up from 50 to 80
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSearching ? 0.0 : 1.0,
            child: IgnorePointer(
              ignoring: isSearching,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSearching ? 0.9 : 1.0,
                curve: Curves.easeIn,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppBreakpoints.laptop,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t['search_hero_title'] ??
                                'Find the service you need',
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
            ),
          ),
        ),

        // 3. SUGGESTED BUSINESSES LAYER (Added)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: isSearching
              ? -200
              : (screenHeight / 2) -
                    230, // Adjusted to be visible below search bar
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSearching ? 0.0 : 1.0,
            child: IgnorePointer(
              ignoring: isSearching,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.ultraWide,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildSuggestedBusinesses(
                      isDark: isDark,
                      selectedTab: selectedTab,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // 4. SEARCH BAR LAYER
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutBack,
          bottom: isSearching ? 180 : (screenHeight / 2 - 25),
          left: 0,
          right: 0,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppBreakpoints.laptop,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchBarWidget(
                  autofocus: widget.autofocus,
                  hintText:
                      t['search_placeholder'] ??
                      'Search for a service or business',
                  initialValue: searchState.query,
                  onChanged: (val) {
                    ref.read(searchProvider.notifier).onQueryChanged(val);
                  },
                  onSubmitted: (val) {
                    ref.read(searchProvider.notifier).onQueryChanged(val);
                  },
                ),
              ),
            ),
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
                  color: (isDark ? Colors.black : Colors.white).withAlpha(
                    (204 * _scrollOpacity).round().clamp(0, 255),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: (isDark ? Colors.white : Colors.black).withAlpha(
                        (26 * _scrollOpacity).round().clamp(0, 255),
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
                                Navigator.of(context).canPop() ||
                                true) ...[
                              // Force Back Button always
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                onPressed:
                                    widget.onClose ??
                                    () {
                                      if (Navigator.of(context).canPop()) {
                                        context.pop();
                                      } else {
                                        context.go('/');
                                      }
                                    },
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
                        if (Supabase.instance.client.auth.currentSession !=
                            null)
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
                          )
                        else
                          TextButton(
                            onPressed: () => context.push('/login'),
                            child: Text(
                              t['login_button'] ?? 'Iniciar Sesión',
                              style: GoogleFonts.inter(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                    color: Colors.black.withAlpha(26),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isDark
                      ? Colors.white.withAlpha(26)
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
                  _buildTabItem(
                    ref,
                    selectedTab,
                    'Trabajos',
                    context,
                    icon: Icons.work_outline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedBusinesses({
    required bool isDark,
    required String selectedTab,
  }) {
    // Determine title based on tab
    String title = 'Negocios Sugeridos';
    if (selectedTab == 'Servicios') title = 'Servicios Populares';
    if (selectedTab == 'Empresas') title = 'Empresas Destacadas';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140, // Height for cards
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: Supabase.instance.client
                .from('business')
                .select(
                  'id, name, profile_image, services:service(name, price)',
                ) // Added price for services
                .limit(10),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }
              List<Map<String, dynamic>> businesses;
              if (snapshot.data == null || (snapshot.data as List).isEmpty) {
                // Mock Data Fallback
                if (selectedTab == 'Servicios') {
                  businesses = [
                    {
                      'id': -101,
                      'name': 'Diseño Web Profesional',
                      'profile_image': null,
                      'price': 1500, // Service Price
                      'category': 'Tecnología',
                      'is_service': true,
                    },
                    {
                      'id': -102,
                      'name': 'Limpieza de Jardín',
                      'profile_image': null,
                      'price': 500,
                      'category': 'Hogar',
                      'is_service': true,
                    },
                    {
                      'id': -103,
                      'name': 'Reparación de PC',
                      'profile_image': null,
                      'price': 300,
                      'category': 'Técnico',
                      'is_service': true,
                    },
                  ];
                } else {
                  // Business Mock Data
                  businesses = [
                    {
                      'id': -1,
                      'name': 'Tech Solutions',
                      'profile_image': null,
                      'services': [
                        {'name': 'Desarrollo Web'},
                      ],
                      'is_service': false,
                    },
                    {
                      'id': -2,
                      'name': 'Green Gardens',
                      'profile_image': null,
                      'services': [
                        {'name': 'Jardinería'},
                      ],
                      'is_service': false,
                    },
                    {
                      'id': -3,
                      'name': 'Fast Fix',
                      'profile_image': null,
                      'services': [
                        {'name': 'Reparaciones'},
                      ],
                      'is_service': false,
                    },
                  ];
                }
              } else {
                // Real Data Adapter
                businesses = List<Map<String, dynamic>>.from(
                  snapshot.data as List,
                );
                // Tag real data as business (default for now) or service based on structure
                // Assuming we query businesses, so is_service = false
                for (var b in businesses) {
                  b['is_service'] = false;
                }
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: businesses.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final b = businesses[index];
                  final imageUrl = b['profile_image'] != null
                      ? Supabase.instance.client.storage
                            .from('business')
                            .getPublicUrl(b['profile_image'])
                      : null;

                  // Category & IsService logic
                  final isService = b['is_service'] == true;
                  String categoryText = 'Servicios';
                  if (isService) {
                    categoryText = b['category'] ?? 'General';
                  } else {
                    // Business logic
                    final services = b['services'] as List?;
                    if (services != null && services.isNotEmpty) {
                      categoryText = (services[0] is Map
                          ? (services[0]['name'] as String? ?? 'Servicios')
                          : 'Servicios');
                    }
                  }

                  // Generate gradients based on index for variety
                  final gradients = [
                    const [Color(0xFF2E3192), Color(0xFF1BFFFF)], // Blue/Cyan
                    const [Color(0xFFD4145A), Color(0xFFFBB03B)], // Red/Orange
                    const [
                      Color(0xFF009245),
                      Color(0xFFFCEE21),
                    ], // Green/Yellow
                    const [Color(0xFF662D8C), Color(0xFFED1E79)], // Purple/Pink
                    const [
                      Color(0xFF1A2980),
                      Color(0xFF26D0CE),
                    ], // Dark Blue/Teal
                  ];
                  final gradient = gradients[index % gradients.length];

                  return GestureDetector(
                    onTap: () => context.push('/client/business/${b['id']}'),
                    // Business Card Container
                    child: Container(
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        // Use image as background if available, else gradient
                        image: imageUrl != null
                            ? DecorationImage(
                                image: CachedNetworkImageProvider(imageUrl),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4), // Darken image
                                  BlendMode.darken,
                                ),
                              )
                            : null,
                        gradient: imageUrl == null
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: gradient,
                              )
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Content Overlay
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Right Badge (Category / Price)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Text(
                                        categoryText,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (isService)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          '\$${b['price']}',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    else if (imageUrl != null)
                                      Icon(
                                        Icons.verified,
                                        color: Colors.blue.shade400,
                                        size: 20,
                                      ),
                                  ],
                                ),
                                const Spacer(),

                                // Business Name
                                Text(
                                  b['name'],
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                // Rating
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '5.0 (24)',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
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
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 12 : 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedBg
              : Colors.transparent, // Slightly lighter for selected
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(
                  color: isDark
                      ? Colors.white.withAlpha(26)
                      : Colors.grey.shade300,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label == 'Google') ...[
              SvgPicture.asset(
                'assets/images/google-logo-icon.svg',
                width: 18,
                height: 18,
              ),
              if (isSelected) const SizedBox(width: 8),
            ] else if (icon != null) ...[
              Icon(icon, size: 18, color: contentColor),
              if (isSelected) const SizedBox(width: 8),
            ],
            if (isSelected)
              Text(
                label,
                style: GoogleFonts.inter(
                  color: contentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
