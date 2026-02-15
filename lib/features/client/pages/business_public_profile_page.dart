import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../business/presentation/providers/business_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../widgets/send_job_request_dialog.dart';

import '../../search/models/service_search_item.dart';
import '../presentation/sheets/quick_booking_sheet.dart';

// Providers for Data Fetching
final publicBusinessProvider =
    FutureProvider.family<Map<String, dynamic>?, int>((ref, id) async {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getBusinessById(id);
    });

final publicServicesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((ref, id) async {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getServices(id);
    });

final publicReviewsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((ref, id) async {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getReviews(id);
    });

final publicServiceReviewsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((ref, serviceId) {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getServiceReviews(serviceId);
    });

final publicEventReviewsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((ref, eventId) {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getEventReviews(eventId);
    });

final publicEventsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((ref, id) async {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getEvents(id);
    });

// publicPortfolioProvider removed as images are in business table

class BusinessPublicProfilePage extends ConsumerStatefulWidget {
  final String businessId;

  const BusinessPublicProfilePage({super.key, required this.businessId});

  @override
  ConsumerState<BusinessPublicProfilePage> createState() =>
      _BusinessPublicProfilePageState();
}

class _BusinessPublicProfilePageState
    extends ConsumerState<BusinessPublicProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _id;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _id = int.tryParse(widget.businessId) ?? 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://images.unsplash.com/photo-1554774853-aae0a22c8aa4?q=80&w=1000&auto=format&fit=crop';
    }
    if (path.startsWith('http')) return path;
    return Supabase.instance.client.storage.from('business').getPublicUrl(path);
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Could not launch $url: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final businessAsync = ref.watch(publicBusinessProvider(_id));
    final reviewsAsync = ref.watch(publicReviewsProvider(_id));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: businessAsync.when(
        data: (business) {
          if (business == null) {
            return const Center(child: Text("Negocio no encontrado"));
          }

          // Try to get banner from 'banner_image' or first item in 'images'
          String? derivedBanner = business['banner_image'];
          if (derivedBanner == null || derivedBanner.isEmpty) {
            final imagesData = business['images'];
            if (imagesData != null) {
              if (imagesData is List && imagesData.isNotEmpty) {
                derivedBanner = imagesData.first.toString();
              } else if (imagesData is String) {
                try {
                  // Clean up string if needed or parse standard JSON
                  // Simple check if it looks like a list
                  if (imagesData.startsWith('[') && imagesData.endsWith(']')) {
                    final parsed = jsonDecode(imagesData);
                    if (parsed is List && parsed.isNotEmpty) {
                      derivedBanner = parsed.first.toString();
                    }
                  }
                } catch (e) {
                  debugPrint('Error parsing images JSON: $e');
                }
              }
            }
          }

          final bannerUrl = _getImageUrl(derivedBanner);

          final avatarUrl = _getImageUrl(business['profile_image']);
          final name = business['name'] ?? 'Negocio';
          final description = business['description'] ?? '';
          final ratingText = reviewsAsync.when(
            data: (reviews) {
              if (reviews.isEmpty) return '—';
              final sum = reviews
                  .map((r) => (r['rating'] as num?)?.toDouble() ?? 0)
                  .fold<double>(0, (a, b) => a + b);
              final avg = sum / reviews.length;
              return avg.toStringAsFixed(1);
            },
            loading: () => '…',
            error: (e, s) => '—',
          );

          return Stack(
            children: [
              // 1. Fixed Header Image (Behind everything)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (bannerUrl.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: bannerUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Container(color: Colors.grey),
                      )
                    else
                      Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black54, Colors.transparent],
                          stops: [0.0, 0.5],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Scrollable Content
              NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    // Transparent Spacer to show image (Reduced height to account for overlap)
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 226),
                    ), // 250 - 24
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Stack: Avatar (popped out) + Stats
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topLeft,
                              children: [
                                // Stats Row (Aligned relative to Avatar space)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    12,
                                    16,
                                    0,
                                  ), // Top padding for stats inside sheet
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                      ), // Spacer for Avatar (90 + margin)
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildStatItem(
                                              ratingText,
                                              "Rating",
                                            ),
                                            _buildStatItem(
                                              reviewsAsync.value?.length
                                                      .toString() ??
                                                  "0",
                                              "Reseñas",
                                            ),
                                            _buildStatItem(
                                              (business['year_founded'] != null)
                                                  ? ((DateTime.now().year -
                                                            (business['year_founded']
                                                                as int))
                                                        .toString())
                                                  : "N/A",
                                              "Años",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Avatar: Positioned to pop out
                                Positioned(
                                  top: -50,
                                  left: 24,
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                        width: 4,
                                      ),
                                      color: Theme.of(
                                        context,
                                      ).scaffoldBackgroundColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFDE0046),
                                            Color(0xFFF7A34B),
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(2.5),
                                      child: CachedNetworkImage(
                                        imageUrl: avatarUrl,
                                        imageBuilder:
                                            (
                                              context,
                                              imageProvider,
                                            ) => CircleAvatar(
                                              backgroundImage: imageProvider,
                                              backgroundColor: Colors.grey[200],
                                            ),
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.grey[400],
                                                size: 40,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Main Content
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 2. Name & Bio
                                  Text(
                                    name,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  if (business['category'] != null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                      ),
                                      child: Text(
                                        _getCategoryName(business['category']),
                                        style: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  if (description.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 6.0,
                                      ),
                                      child: Text(
                                        description,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  // Link
                                  if (business['website'] != null)
                                    GestureDetector(
                                      onTap: () =>
                                          _launchUrl(business['website']),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.link,
                                              size: 16,
                                              color: Colors.blue[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                business['website'],
                                                style: GoogleFonts.inter(
                                                  color: Colors.blue[600],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  const SizedBox(height: 20),

                                  // 3. Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () => _showInviteDialog(
                                            context,
                                            business,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF4285F4,
                                            ),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "Agendar / Mensaje",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if (business['phone'] != null)
                                              _launchUrl(
                                                'tel:${business['phone']}',
                                              );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            side: BorderSide(
                                              color: isDark
                                                  ? Colors.white24
                                                  : Colors.grey.shade300,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "Llamar",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: isDark
                                                ? Colors.white24
                                                : Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.person_add_outlined,
                                            size: 20,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 8,
                                          ), // Matched height roughly
                                          constraints: const BoxConstraints(
                                            minWidth: 44,
                                            minHeight: 44,
                                          ),
                                          onPressed: () {}, // Save logic
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),
                                  AboutSection(business: business),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          controller: _tabController,
                          labelColor: isDark ? Colors.white : Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: isDark ? Colors.white : Colors.black,
                          indicatorWeight: 1,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          tabs: const [
                            Tab(icon: Icon(Icons.grid_on_outlined), text: null),
                            Tab(
                              icon: Icon(Icons.photo_camera_outlined),
                              text: null,
                            ),
                            Tab(
                              icon: Icon(Icons.calendar_today_outlined),
                              text: null,
                            ),
                            Tab(icon: Icon(Icons.star_outline), text: null),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    _ServicesTab(
                      businessId: _id,
                      businessName: name,
                      businessLogo: avatarUrl,
                      onBook: (service) {
                        final item = ServiceSearchItem(
                          serviceId: service['id'],
                          serviceName: service['name'] ?? 'Servicio',
                          servicePrice: (service['price_cents'] ?? 0) / 100,
                          serviceImage: service['image'],
                          serviceProfileImage: service['profile_image'],
                          serviceDescription: service['description'],
                          businessId: _id,
                          businessName: name,
                          businessProfileImage: business['profile_image'],
                          businessBannerImage: business['banner_image'],
                        );

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              QuickBookingSheet(service: item),
                        );
                      },
                    ),
                    _PortfolioTab(businessId: _id),
                    _EventsTab(businessId: _id),
                    _ReviewsTab(businessId: _id),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  actions: [
                    CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  // Helper Methods
  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  String _getCategoryName(dynamic categoryId) {
    // Ideally this fetches from a provider or map.
    // Returning a placeholder or string representation.
    if (categoryId == null) return "Servicios";
    // Mock category mapping or simple string return
    return "Categoría $categoryId";
  }

  Future<void> _showInviteDialog(
    BuildContext context,
    Map<String, dynamic> business, {
    String? serviceInterest,
  }) async {
    final messageController = TextEditingController(
      text: serviceInterest != null
          ? 'Hola, me interesa el servicio de $serviceInterest.'
          : 'Hola, me interesa saber más sobre sus servicios.',
    );
    final isLoading = ValueNotifier<bool>(false);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          serviceInterest != null
              ? 'Consultar sobre servicio'
              : 'Contactar a ${business['name']}',
          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceInterest != null
                  ? 'Envía un mensaje para cotizar o agendar este servicio.'
                  : 'Envía un mensaje para conectar con este negocio.',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          // Button: Go to Chat
          TextButton(
            onPressed: () {
              final user = ref.read(currentUserProvider);
              if (user == null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Debes iniciar sesión para chatear.'),
                    ),
                  );
                  Navigator.pop(context);
                }
                return;
              }

              Navigator.pop(context);
              // Navigate to chat with business
              // Using the business_id to find or create a chat
              // For now, navigate to chats list - in future implement direct chat creation
              context.push(
                '/chats/new',
                extra: {
                  'businessId': business['id'],
                  'businessName': business['name'],
                  'initialMessage': messageController.text.trim(),
                },
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
            child: const Text('Ir al chat'),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              return ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        // Close the simple invite dialog and open the detailed request dialog.
                        if (context.mounted) Navigator.pop(context);
                        await SendJobRequestDialog.show(
                          context,
                          businessId: (business['id'] as num).toInt(),
                          businessServices:
                              (business['services'] as List?) ?? const [],
                        );
                      },
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Enviar solicitud'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServicesTab extends ConsumerWidget {
  final int businessId;
  final Function(Map<String, dynamic>) onBook;
  final String businessName;
  final String businessLogo;

  const _ServicesTab({
    required this.businessId,
    required this.onBook,
    required this.businessName,
    required this.businessLogo,
  });

  String _getServiceImage(Map<String, dynamic> service) {
    if (service['profile_image'] != null &&
        service['profile_image'].toString().isNotEmpty) {
      final path = service['profile_image'].toString();
      if (path.startsWith('http')) return path;
      return Supabase.instance.client.storage
          .from('business')
          .getPublicUrl(path);
    }
    // Fallback to images array
    if (service['images'] != null) {
      try {
        // If it's a string, try direct or parse
        String raw = service['images'].toString();
        // Simple check if it's a list string like "['a','b']"
        if (raw.startsWith('[')) {
          // Remove brackets and quotes rudimentarily if simple
          // Better: just use a default placeholder if complex parsing needed without dart:convert import availability check
          // But likely it is a JSON string.
          // Let's just return placeholder to be safe to avoid parse errors if we don't import dart:convert
          // Or assume backend sends list if using Postgres JSONB
        }
      } catch (_) {}
    }
    return 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(publicServicesProvider(businessId));

    return servicesAsync.when(
      data: (services) {
        if (services.isEmpty) {
          return const Center(child: Text("No hay servicios disponibles"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            final imageUrl = _getServiceImage(service);
            final name = service['name'] ?? 'Servicio';
            final desc = service['description'] ?? '';
            final price = service['price_cents'] != null
                ? (service['price_cents'] / 100).toStringAsFixed(2)
                : (service['price']?.toString() ?? 'Consultar');

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 220, // Increased height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (c, u, e) => Container(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(204),
                        ],
                      ),
                    ),
                  ),
                  // Business Logo (Top Left)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(businessLogo),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            businessName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (desc.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$$price",
                              style: GoogleFonts.inter(
                                color: const Color(0xFF4285F4), // Brand Blue
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => onBook(service),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4285F4),
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text("Agendar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text("Error: $e")),
    );
  }
}

class _PortfolioTab extends ConsumerWidget {
  final int businessId;
  const _PortfolioTab({required this.businessId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the business provider again to get images
    final businessAsync = ref.watch(publicBusinessProvider(businessId));

    return businessAsync.when(
      data: (business) {
        if (business == null) {
          return const Center(child: Text("Error cargando portfolio"));
        }

        final images = business['images'];

        // Handle both String and List types for images
        List<String> imageList = [];
        if (images != null) {
          if (images is List) {
            imageList = images.map((e) => e.toString()).toList();
          } else if (images is String) {
            // If it's a string like "[]" or empty, skip
            if (images.trim().isEmpty || images.trim() == '[]') {
              return const Center(child: Text("No hay fotos"));
            }
            // If it's a JSON string, try to parse it
            try {
              imageList = [images]; // Treat as single image path
            } catch (e) {
              return const Center(child: Text("No hay fotos"));
            }
          }
        }

        if (imageList.isEmpty) {
          return const Center(child: Text("No hay fotos"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            final url = imageList[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: url.startsWith('http')
                      ? url
                      : Supabase.instance.client.storage
                            .from('business')
                            .getPublicUrl(url),
                  fit: BoxFit.cover,
                  errorWidget: (c, u, e) => Container(color: Colors.grey),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text("Error: $e")),
    );
  }
}

class _EventsTab extends ConsumerWidget {
  final int businessId;
  const _EventsTab({required this.businessId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(publicEventsProvider(businessId));
    return eventsAsync.when(
      data: (events) {
        if (events.isEmpty) {
          return const Center(child: Text("No hay eventos próximos"));
        }
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              title: Text(event['title'] ?? 'Evento'),
              subtitle: Text(event['description'] ?? ''),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text("Error: $e")),
    );
  }
}

class _ReviewsTab extends ConsumerStatefulWidget {
  final int businessId;
  const _ReviewsTab({required this.businessId});

  @override
  ConsumerState<_ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends ConsumerState<_ReviewsTab> {
  final _contentController = TextEditingController();
  bool _isSaving = false;
  int _rating = 5;
  String _target = 'business'; // business | service | event
  int? _selectedServiceId;
  int? _selectedEventId;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<int?> _getClientId() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return null;

    try {
      final clientRes = await Supabase.instance.client
          .from('clients')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();
      return (clientRes?['id'] as num?)?.toInt();
    } catch (_) {
      return null;
    }
  }

  Future<void> _submitReview() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un comentario para tu reseña.')),
      );
      return;
    }

    final clientId = await _getClientId();
    if (clientId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión para reseñar.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final repo = ref.read(businessRepositoryProvider);
      Map<String, dynamic>? created;

      if (_target == 'business') {
        created = await repo.createBusinessReview(
          clientId: clientId,
          businessId: widget.businessId,
          rating: _rating,
          content: content,
        );
        ref.invalidate(publicReviewsProvider(widget.businessId));
      } else if (_target == 'service') {
        final serviceId = _selectedServiceId;
        if (serviceId == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Selecciona un servicio.')),
          );
          return;
        }
        created = await repo.createServiceReview(
          clientId: clientId,
          serviceId: serviceId,
          rating: _rating,
          content: content,
        );
        ref.invalidate(publicServiceReviewsProvider(serviceId));
      } else if (_target == 'event') {
        final eventId = _selectedEventId;
        if (eventId == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Selecciona un evento.')),
          );
          return;
        }
        created = await repo.createEventReview(
          clientId: clientId,
          eventId: eventId,
          rating: _rating,
          content: content,
        );
        ref.invalidate(publicEventReviewsProvider(eventId));
      }

      if (!mounted) return;
      if (created == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo publicar la reseña.')),
        );
      } else {
        _contentController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reseña publicada.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(publicServicesProvider(widget.businessId));
    final eventsAsync = ref.watch(publicEventsProvider(widget.businessId));

    AsyncValue<List<Map<String, dynamic>>> reviewsAsync;
    if (_target == 'business') {
      reviewsAsync = ref.watch(publicReviewsProvider(widget.businessId));
    } else if (_target == 'service' && _selectedServiceId != null) {
      reviewsAsync = ref.watch(
        publicServiceReviewsProvider(_selectedServiceId!),
      );
    } else if (_target == 'event' && _selectedEventId != null) {
      reviewsAsync = ref.watch(publicEventReviewsProvider(_selectedEventId!));
    } else {
      reviewsAsync = const AsyncValue.data([]);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withAlpha(26)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Escribe una reseña',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  DropdownButton<String>(
                    value: _target,
                    items: const [
                      DropdownMenuItem(
                        value: 'business',
                        child: Text('Empresa'),
                      ),
                      DropdownMenuItem(
                        value: 'service',
                        child: Text('Servicio'),
                      ),
                      DropdownMenuItem(value: 'event', child: Text('Evento')),
                    ],
                    onChanged: _isSaving
                        ? null
                        : (val) {
                            if (val == null) return;
                            setState(() {
                              _target = val;
                              _selectedServiceId = null;
                              _selectedEventId = null;
                            });
                          },
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(5, (i) {
                      final star = i + 1;
                      return IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: _isSaving
                            ? null
                            : () => setState(() => _rating = star),
                        icon: Icon(
                          Icons.star,
                          size: 18,
                          color: star <= _rating ? Colors.amber : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              if (_target == 'service')
                servicesAsync.when(
                  data: (services) {
                    if (services.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Este negocio no tiene servicios.'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: _selectedServiceId,
                        hint: const Text('Selecciona un servicio'),
                        items: services
                            .map(
                              (s) => DropdownMenuItem<int>(
                                value: (s['id'] as num?)?.toInt(),
                                child: Text(
                                  (s['name'] ?? 'Servicio').toString(),
                                ),
                              ),
                            )
                            .where((i) => i.value != null)
                            .toList(),
                        onChanged: _isSaving
                            ? null
                            : (val) => setState(() => _selectedServiceId = val),
                      ),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                  error: (e, s) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Error cargando servicios: $e'),
                  ),
                ),
              if (_target == 'event')
                eventsAsync.when(
                  data: (events) {
                    if (events.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Este negocio no tiene eventos.'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: _selectedEventId,
                        hint: const Text('Selecciona un evento'),
                        items: events
                            .map(
                              (e) => DropdownMenuItem<int>(
                                value: (e['id'] as num?)?.toInt(),
                                child: Text(
                                  (e['title'] ?? 'Evento').toString(),
                                ),
                              ),
                            )
                            .where((i) => i.value != null)
                            .toList(),
                        onChanged: _isSaving
                            ? null
                            : (val) => setState(() => _selectedEventId = val),
                      ),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                  error: (e, s) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Error cargando eventos: $e'),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: _contentController,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Escribe tu comentario...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _submitReview,
                  child: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Publicar'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        reviewsAsync.when(
          data: (reviews) {
            if (reviews.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Center(child: Text('No hay reseñas aún')),
              );
            }

            return Column(
              children: reviews.map((review) {
                final client = review['client'];
                final rating = (review['rating'] as num?)?.toInt() ?? 5;
                final content = (review['content'] ?? '').toString();
                final clientName = (client != null && client is Map)
                    ? (client['first_name'] ?? 'Cliente')
                    : 'Cliente';

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withAlpha(26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              clientName.toString().isNotEmpty
                                  ? clientName.toString()[0].toUpperCase()
                                  : 'C',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              clientName.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                Icons.star,
                                size: 14,
                                color: i < rating ? Colors.amber : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(content),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  final Map<String, dynamic> business;
  const AboutSection({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withAlpha(26)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "About us",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_up),
            ],
          ),
          const Divider(),
          if (business['address'] != null)
            _buildInfoRow(Icons.pin_drop, business['address'].toString()),
          // _buildInfoRow(Icons.access_time, "Lun - Vie: 9:00 - 18:00"),
          if (business['phone'] != null)
            _buildInfoRow(Icons.phone, business['phone'].toString()),
          if (business['email'] != null)
            _buildInfoRow(Icons.mail, business['email'].toString()),
          if (business['website'] != null)
            _buildInfoRow(Icons.language, business['website'].toString()),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 13))),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  final double _height;

  _SliverAppBarDelegate(this._tabBar)
    : _height = _tabBar.preferredSize.height + 16;

  @override
  double get minExtent => _height;
  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate._tabBar != _tabBar;
  }
}
