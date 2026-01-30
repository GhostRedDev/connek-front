import 'package:flutter/material.dart';
import '../../../core/widgets/layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Added
import '../providers/business_provider.dart';
import '../../../core/widgets/glass_fab_button.dart';
import 'business_service_sheet.dart'; // Added // Corrected Path

class BusinessServicesWidget extends ConsumerStatefulWidget {
  const BusinessServicesWidget({super.key});

  @override
  ConsumerState<BusinessServicesWidget> createState() =>
      _BusinessServicesWidgetState();
}

class _BusinessServicesWidgetState
    extends ConsumerState<BusinessServicesWidget> {
  String _searchQuery = '';
  // String _selectedFilter = 'Todos'; // Replaced by Tabs
  int _selectedTabIndex = 0; // 0: Servicios, 1: Items
  int _currentEventIndex = 0; // Carousel Index

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    final allServices = businessData.maybeWhen(
      data: (data) => data.services,
      orElse: () => <Map<String, dynamic>>[],
    );

    // Filter Logic
    // Filter Logic
    final filteredList = allServices.where((s) {
      final name = (s['name'] ?? '').toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      final type = (s['type'] ?? '').toString().toLowerCase();

      // Tab 0: Services (Show all non-items: services, events, legacy)
      if (_selectedTabIndex == 0) {
        if (type == 'item') return false;
      }
      // Tab 1: Items (Show only items)
      else if (_selectedTabIndex == 1) {
        if (type != 'item') return false;
      }

      return name.contains(query);
    }).toList();

    // Real Events from DB
    final realEvents = allServices
        .where((s) => (s['type'] ?? '').toString().toLowerCase() == 'event')
        .toList();

    // Use Real Events if available, otherwise use Mock for demo if empty (or just empty)
    // For Development/Demo purposes, keeping the Mock if real is empty to show the UI
    final events = realEvents.isNotEmpty
        ? realEvents
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: GlassFabButton(onPressed: () => _showCreationMenu(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Servicios y Eventos',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Añade y maneja los servicios que ofrece tu negocio.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),

            // Eventos Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Eventos',
                    style: GoogleFonts.outfit(
                      fontSize: 20, // Slightly larger
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  // Add Button
                  InkWell(
                    onTap: () => _showServiceSheet(context, type: 'event'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white10 : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Icon(Icons.add, size: 20, color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Events Carousel
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.93),
                itemCount: events.length,
                onPageChanged: (index) =>
                    setState(() => _currentEventIndex = index),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _buildModernEventCard(context, events[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Dots Indicator
            if (events.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(events.length, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentEventIndex == index
                          ? (isDark ? Colors.white : Colors.black87)
                          : Colors.grey.withOpacity(0.3),
                    ),
                  );
                }),
              ),
            const SizedBox(height: 24),

            // Tabs (Servicios / Items)
            Container(
              height: 50,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      context,
                      label: 'Servicios',
                      icon: Icons.spa_outlined,
                      index: 0,
                    ),
                  ),
                  Expanded(
                    child: _buildTabButton(
                      context,
                      label: 'Items',
                      icon: Icons.shopping_bag_outlined,
                      index: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1e2530) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDark ? Colors.white10 : Colors.grey[300]!,
                ),
              ),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Buscar servicios',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Items List
            if (filteredList.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    'No se encontraron resultados',
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                ),
              )
            else
              ...filteredList.map((s) {
                if (_selectedTabIndex == 0) {
                  return _buildDetailedServiceCard(context, s);
                }
                return _buildCompactItemCard(context, s);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required int index,
  }) {
    final isSelected = _selectedTabIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF2C3E50) : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? (isDark ? Colors.white : Colors.black87)
                  : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? (isDark ? Colors.white : Colors.black87)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedServiceCard(
    BuildContext context,
    Map<String, dynamic> service,
  ) {
    final title = service['name'] ?? 'Servicio';
    final desc = service['description'] ?? 'Sin descripción';
    final price = service['price'] ?? 0;
    // Price Range Mock - usually services have variations or fixed price
    // We can show "$price" or "$price - $high" if available
    final priceDisplay =
        '\$$price'; // Simplify for now unless we have range data

    // Image Handling
    String? imageUrl = service['image'] ?? service['image_url'];
    if (imageUrl == null &&
        service['photos'] != null &&
        (service['photos'] as List).isNotEmpty) {
      imageUrl = service['photos'][0];
    }

    return Container(
      height: 240,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: imageUrl != null && imageUrl.isNotEmpty
            ? DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
        color: imageUrl == null ? Colors.grey[300] : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Top Left: Title Pill
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Top Right: Date/Time Pill (Mock for now, or use 'created_at' if available)
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Oct 12, 10:00 AM', // Mock - Replace with real date if needed
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Bottom Content
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        desc,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        priceDisplay,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4285F4), // Brand Blue
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Actions
                Row(
                  children: [
                    // Edit Button
                    _buildGlassActionButton(
                      icon: Icons.edit_outlined,
                      label: 'Editar',
                      onTap: () => _showServiceSheet(
                        context,
                        serviceToEdit: service,
                        type: 'service',
                      ),
                    ),
                    const SizedBox(width: 8),
                    // View Button
                    _buildGlassActionButton(
                      icon: Icons.remove_red_eye_outlined,
                      label: null, // Icon only
                      onTap: () {
                        // TODO: View Details Logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernEventCard(
    BuildContext context,
    Map<String, dynamic> event,
  ) {
    final title = event['name'] ?? event['title'] ?? 'Evento';
    // Image resolution
    String? imageUrl = event['image'] ?? event['image_url'];
    if (imageUrl == null &&
        event['photos'] != null &&
        (event['photos'] as List).isNotEmpty) {
      imageUrl = event['photos'][0];
    }

    // Date Logic
    String timeLeft = 'Próximamente';
    if (event['event_date'] != null) {
      try {
        final date = DateTime.parse(event['event_date']);
        final diff = date.difference(DateTime.now()).inDays;
        if (diff < 0) {
          timeLeft = 'Finalizado';
        } else if (diff == 0)
          timeLeft = 'Finaliza hoy';
        else
          timeLeft = 'Finaliza en $diff días';
      } catch (_) {}
    } else if (event['timeLeft'] != null) {
      timeLeft = event['timeLeft']; // Fallback for mock
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: imageUrl != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
        color: imageUrl == null ? Colors.grey[300] : null,
      ),
      child: Stack(
        children: [
          // Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
            ),
          ),

          // Top Left: Time Pill (Blue)
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    timeLeft,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Content
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROMOCIÓN',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Action Button (White Circle)
                InkWell(
                  onTap: () {
                    // Edit/View Action
                    _showServiceSheet(
                      context,
                      serviceToEdit: event,
                      type: 'event',
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassActionButton({
    required IconData icon,
    String? label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: label != null ? 16 : 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCompactItemCard(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final title = item['name'] ?? 'Item';
    final desc = item['description'] ?? 'Descripción del item';
    final price = item['price'] ?? 0;
    final cat = item['category'] ?? 'Extra';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black54,
                        ), // Outline style like image
                      ),
                      child: Text(
                        cat,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$ $price',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'CREADO DESDE FAC-002024', // Mock ref
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              const Icon(Icons.more_vert, size: 20, color: Colors.black54),
              const SizedBox(height: 20),
              Switch(
                value: true, // Mock value
                onChanged: (v) {},
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF4285F4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreationMenu(BuildContext context) async {
    // Hide navbar with animation
    ref.read(navbarVisibilityProvider.notifier).state = false;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;

        return Container(
          padding: const EdgeInsets.fromLTRB(
            24,
            24,
            24,
            40,
          ), // More bottom padding for safety
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crear nuevo',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildCreationOption(
                context,
                icon: Icons.spa_outlined,
                label: 'Servicio',
                subLabel: 'Añadir un nuevo servicio',
                color: const Color(0xFF4285F4),
                onTap: () {
                  Navigator.pop(context);
                  _showServiceSheet(context, type: 'service');
                },
              ),
              _buildCreationOption(
                context,
                icon: Icons.event_available_outlined,
                label: 'Evento',
                subLabel: 'Crear un evento temporal',
                color: const Color(0xFFEA4335),
                onTap: () {
                  Navigator.pop(context);
                  _showServiceSheet(context, type: 'event');
                },
              ),
              _buildCreationOption(
                context,
                icon: Icons.shopping_bag_outlined,
                label: 'Item',
                subLabel: 'Añadir un producto o artículo',
                color: const Color(0xFF34A853),
                onTap: () {
                  Navigator.pop(context);
                  _showServiceSheet(context, type: 'item');
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );

    // Show navbar again
    ref.read(navbarVisibilityProvider.notifier).state = true;
  }

  Widget _buildCreationOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subLabel,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    subLabel,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white54 : Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceSheet(
    BuildContext context, {
    Map<String, dynamic>? serviceToEdit,
    String type = 'service',
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          BusinessServiceSheet(serviceToEdit: serviceToEdit, type: type),
    );
  }
}
