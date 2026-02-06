import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../business/presentation/providers/business_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../client/services/client_requests_service.dart';
import '../../../core/widgets/category_badge.dart';

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
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final businessAsync = ref.watch(publicBusinessProvider(_id));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: businessAsync.when(
        data: (business) {
          if (business == null) {
            return const Center(child: Text("Negocio no encontrado"));
          }

          final bannerUrl = _getImageUrl(business['banner_image']);
          final avatarUrl = _getImageUrl(business['profile_image']);
          final name = business['name'] ?? 'Negocio';
          final description = business['description'] ?? '';

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    onPressed: () => context.pop(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: bannerUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Container(color: Colors.grey),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black45, Colors.transparent],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: avatarUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                        'https://images.unsplash.com/photo-1554774853-aae0a22c8aa4?q=80&w=1000&auto=format&fit=crop',
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Call
                                  if (business['phone'] != null)
                                    _buildAction(
                                      icon: Icons.phone,
                                      onTap: () => _launchUrl(
                                        'tel:${business['phone']}',
                                      ),
                                    ),
                                  // Website
                                  if (business['website'] != null)
                                    _buildAction(
                                      icon: Icons.language,
                                      onTap: () =>
                                          _launchUrl(business['website']),
                                    ),
                                  // Chat (Primary)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _showInviteDialog(context, business);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          shape: const StadiumBorder(),
                                        ),
                                        child: const Text("Conversar"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          name,
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Category Badge
                        if (business['category'] != null) ...[
                          const SizedBox(height: 8),
                          CategoryBadge(categoryId: business['category']),
                        ],
                        // Username or short desc
                        // Text("@username", style: GoogleFonts.inter(color: Colors.grey, fontSize: 14)),
                        const SizedBox(height: 12),
                        if (description.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white10 : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              description,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                height: 1.4,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const SizedBox(height: 16),
                        // Stats Row (Mock for now, or fetch real counts if available)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // We don't have these counts in `getBusinessById` yet
                            _buildStat("5.0", "Rating"),
                            // _buildStat("?", "Seguidores"),
                            _buildStat("Verified", "Status"),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AboutSection(business: business),
                        const SizedBox(height: 16),
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
                      indicatorColor: Colors.blue,
                      indicatorWeight: 3,
                      labelStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: "Servicios"),
                        Tab(text: "Fotos"),
                        Tab(text: "Eventos"),
                        Tab(text: "Reseñas"),
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
                    _showInviteDialog(
                      context,
                      business,
                      serviceInterest: service['name'],
                    );
                  },
                ),
                _PortfolioTab(businessId: _id),
                _EventsTab(businessId: _id),
                _ReviewsTab(businessId: _id),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
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
                        isLoading.value = true;
                        try {
                          final user = ref.read(currentUserProvider);

                          if (user == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Debes iniciar sesión para conectar.',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                            return;
                          }

                          int? clientId;
                          try {
                            final clientRes = await Supabase.instance.client
                                .from('clients')
                                .select('id')
                                .eq('user_id', user.id)
                                .maybeSingle();

                            if (clientRes != null) {
                              clientId = clientRes['id'];
                            }
                          } catch (e) {
                            print('Error fetching client: $e');
                          }

                          if (clientId == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error: No se encontró perfil de cliente.',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                            return;
                          }

                          final success = await ref
                              .read(clientRequestsServiceProvider)
                              .createRequest({
                                'client_id': clientId,
                                'business_id': business['id'],
                                'description':
                                    messageController.text.trim().isNotEmpty
                                    ? messageController.text.trim()
                                    : 'Solicitud de contacto',
                                'is_direct': true,
                              });

                          if (context.mounted) {
                            Navigator.pop(context);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Solicitud enviada con éxito'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error al enviar solicitud'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          print('Error sending invite: $e');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                            Navigator.pop(context);
                          }
                        } finally {
                          isLoading.value = false;
                        }
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

  Widget _buildAction({IconData? icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Icon(icon, size: 20, color: Colors.grey),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
      ],
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
                    color: Colors.black.withOpacity(0.1),
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
                          Colors.black.withOpacity(0.8),
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
                        color: Colors.black.withOpacity(0.5),
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
        if (business == null)
          return const Center(child: Text("Error cargando portfolio"));

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
        if (events.isEmpty)
          return const Center(child: Text("No hay eventos próximos"));
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(events[index]['title'] ?? 'Evento'),
            subtitle: Text(events[index]['description'] ?? ''),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text("Error: $e")),
    );
  }
}

class _ReviewsTab extends ConsumerWidget {
  final int businessId;
  const _ReviewsTab({required this.businessId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(publicReviewsProvider(businessId));
    return reviewsAsync.when(
      data: (reviews) {
        if (reviews.isEmpty)
          return const Center(child: Text("No hay reseñas aún"));
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            final client = review['client'];
            final rating = review['rating'] ?? 5;
            final content = review['comment'] ?? '';

            // Handle optional client data if join failed or simple object
            final clientName = (client != null && client is Map)
                ? (client['first_name'] ?? 'Cliente')
                : 'Cliente';

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          clientName[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientName, // Need fetch client name
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Date
                        ],
                      ),
                      const Spacer(),
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
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text("Error: $e")),
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
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
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
