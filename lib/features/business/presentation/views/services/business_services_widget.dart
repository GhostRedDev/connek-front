import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/core/widgets/glass_fab_button.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/business/presentation/views/shared/business_shared_widgets.dart';

import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/system_ui/typography.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'sections/business_services_header.dart';
import 'sections/business_event_carousel.dart';
import 'sections/business_services_tabs_filter.dart';
import 'sections/business_services_grid.dart';
import 'sections/business_items_grid.dart';
import '../sales/create_event_dialog.dart';
import '../../sheets/business_sheet_create_service.dart';

class BusinessServicesWidget extends ConsumerStatefulWidget {
  const BusinessServicesWidget({super.key});

  @override
  ConsumerState<BusinessServicesWidget> createState() =>
      _BusinessServicesWidgetState();
}

class _BusinessServicesWidgetState
    extends ConsumerState<BusinessServicesWidget> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0; // 0: Services, 1: Items
  int _currentEventIndex = 0;

  @override
  Widget build(BuildContext context) {
    final businessDataAsync = ref.watch(businessProvider);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return businessDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final allServices = data.services;

        // --- Filter Logic ---
        final filteredList = allServices.where((s) {
          final name = (s['name'] ?? '').toString().toLowerCase();
          final query = _searchController.text.toLowerCase();
          final type = (s['type'] ?? '').toString().toLowerCase();

          if (_selectedTabIndex == 0) {
            // Tab 0: Services & Events (exclude items)
            if (type == 'item') return false;
          } else {
            // Tab 1: Items only
            if (type != 'item') return false;
          }

          return name.contains(query);
        }).toList();

        // Separate real events for carousel
        final events = allServices
            .where((s) => (s['type'] ?? '').toString().toLowerCase() == 'event')
            .toList();

        // Mock events if empty for demo (preserve original logic)
        final displayEvents = events.isNotEmpty
            ? events
            : [
                {
                  'name': '2x1 en masajes para pareja',
                  'image':
                      'https://images.unsplash.com/photo-1600334089648-b0d9d3028eb2?auto=format&fit=crop&q=80',
                  'event_date': DateTime.now()
                      .add(const Duration(days: 2))
                      .toIso8601String(),
                  'isPromo': true,
                  'description': 'Promoción especial de fin de semana',
                  'type': 'event',
                },
              ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 900;

            return Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: GlassFabButton(
                  onPressed: () => _showCreationMenu(context),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmptySpaceTopWidget(),

                    // Header
                    BusinessServicesHeader(t: t, isDark: isDark),
                    const SizedBox(height: 24),

                    // Event Carousel
                    if (_selectedTabIndex == 0) ...[
                      BusinessEventCarousel(
                        events: displayEvents,
                        currentIndex: _currentEventIndex,
                        onPageChanged: (index) =>
                            setState(() => _currentEventIndex = index),
                        isDesktop: isDesktop,
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Tabs & Filter
                    BusinessServicesTabsFilter(
                      searchController: _searchController,
                      selectedTabIndex: _selectedTabIndex,
                      onTabChanged: (index) =>
                          setState(() => _selectedTabIndex = index),
                      onSearchChanged: (val) => setState(() {}),
                      t: t,
                    ),
                    const SizedBox(height: 24),

                    // Content Grid
                    if (_selectedTabIndex == 0)
                      BusinessServicesGrid(
                        services: filteredList,
                        isDesktop: isDesktop,
                      )
                    else
                      BusinessItemsGrid(
                        items: filteredList,
                        isDesktop: isDesktop,
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCreationMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.h3('Crear nuevo'),
            const SizedBox(height: 24),
            _buildCreationOption(
              context,
              icon: Icons.spa_rounded,
              color: Colors.blue,
              title: 'Servicio',
              subtitle: 'Ofrece un nuevo servicio',
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const BusinessSheetCreateService(),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildCreationOption(
              context,
              icon: Icons.event_rounded,
              color: Colors.purple,
              title: 'Evento',
              subtitle: 'Organiza un evento o promoción',
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => const CreateEventDialog(),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildCreationOption(
              context,
              icon: Icons.inventory_2_rounded,
              color: Colors.orange,
              title: 'Item / Producto',
              subtitle: 'Vende un producto físico',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement Item creation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Crear Item - Coming Soon')),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCreationOption(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
