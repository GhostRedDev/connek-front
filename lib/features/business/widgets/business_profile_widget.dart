import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'event_card_widget.dart';
import '../providers/business_provider.dart';

class BusinessProfileWidget extends ConsumerStatefulWidget {
  const BusinessProfileWidget({super.key});

  @override
  ConsumerState<BusinessProfileWidget> createState() =>
      _BusinessProfileWidgetState();
}

class _BusinessProfileWidgetState extends ConsumerState<BusinessProfileWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isAboutExpanded = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showEditProfileSheet(
    BuildContext context,
    Map<String, dynamic>? profile,
  ) {
    // Basic Edit Sheet
    final nameController = TextEditingController(text: profile?['name'] ?? '');
    final descController = TextEditingController(
      text: profile?['description'] ?? '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Editar Perfil',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Negocio',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final success = await ref
                      .read(businessProvider.notifier)
                      .updateBusinessProfile({
                        'name': nameController.text,
                        'description': descController.text,
                      });
                  if (success) {
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4285F4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Guardar Cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider);
    final data = businessData.value;
    final profile = data?.businessProfile;
    // Ensure services is a list and cast properly
    final rawServices = data?.services ?? [];
    // Just in case list contains non-map logic (though provider ensures maps)
    final services = rawServices;

    final reviews = data?.reviews ?? [];

    // Safe defaults
    final name = profile?['name'] ?? 'Mi Negocio';
    final description = profile?['description'] ?? 'Sin descripción';
    final coverImage =
        'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1200&q=80';
    final profileImage =
        profile?['profile_image'] ??
        'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?auto=format&fit=crop&w=300&q=80';

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              actions: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () => _showEditProfileSheet(context, profile),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(imageUrl: coverImage, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Avatar & Main Action
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundImage: CachedNetworkImageProvider(
                              profileImage,
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () =>
                              _showEditProfileSheet(context, profile),
                          icon: const Icon(Icons.edit_outlined, size: 16),
                          label: const Text('Editar Perfil'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      '@negocio',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E1E)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        description,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          height: 1.4,
                          color: isDark ? Colors.grey[300] : Colors.grey[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('0', 'Seguidores', context), // Mock
                        _buildStat('${services.length}', 'Servicios', context),
                        _buildStat('${reviews.length}', 'Reseñas', context),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // About Accordion
                    Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => setState(
                              () => _isAboutExpanded = !_isAboutExpanded,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Información',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    _isAboutExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_isAboutExpanded)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.location_on_outlined,
                                    profile?['address'] ??
                                        'Ubicación no disponible',
                                  ),
                                  _buildInfoRow(
                                    Icons.access_time,
                                    profile?['hours'] ?? 'Horario no definido',
                                  ),
                                  _buildInfoRow(
                                    Icons.phone_outlined,
                                    (profile?['phone'] ??
                                            profile?['contact_phone'] ??
                                            'Teléfono no definido')
                                        .toString(),
                                  ),
                                  _buildInfoRow(
                                    Icons.email_outlined,
                                    profile?['email'] ??
                                        profile?['contact_email'] ??
                                        'Email no definido',
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tabs
              TabBar(
                controller: _tabController,
                isScrollable: false,
                labelColor: isDark ? Colors.white : Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF4285F4),
                indicatorWeight: 3,
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'Servicios'),
                  Tab(text: 'Fotos'),
                  Tab(text: 'Eventos'),
                  Tab(text: 'Reseñas'),
                ],
              ),
              const SizedBox(height: 16),

              // Tab Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedBuilder(
                  animation: _tabController,
                  builder: (context, _) {
                    if (_tabController.index == 0) {
                      return _buildServicesList(services, isDark);
                    }
                    if (_tabController.index == 1) {
                      return _buildPhotosGrid(services, profile);
                    }
                    if (_tabController.index == 2) {
                      return _buildEventsList(data?.events ?? []);
                    }
                    return _buildReviewsList(reviews, isDark);
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesList(List<Map<String, dynamic>> services, bool isDark) {
    if (services.isEmpty) return const Text('No hay servicios disponibles');

    return Column(
      children: services.map((s) => _buildServiceCard(s, isDark)).toList(),
    );
  }

  Widget _buildEventsList(List<Map<String, dynamic>> events) {
    if (events.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('Sin eventos próximos'),
        ),
      );
    }

    return Column(
      children: events.map((event) => EventCardWidget(event: event)).toList(),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, bool isDark) {
    final image = service['image'] as String?;
    final title = service['name'] ?? 'Servicio';
    final price = service['price'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: image != null
            ? DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
            : null,
        color: isDark ? Colors.grey[800] : Colors.grey[300],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$$price',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4285F4),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosGrid(
    List<Map<String, dynamic>> services,
    Map<String, dynamic>? profile,
  ) {
    // 1. Get Portfolio Images from Profile
    List<String> portfolioImages = [];
    if (profile != null && profile['images'] != null) {
      final imgs = profile['images'];
      if (imgs is List) {
        portfolioImages = imgs.map((e) => e.toString()).toList();
      } else if (imgs is String) {
        portfolioImages = [imgs];
      }
    }

    // 2. Get Service Images (Optional: Mix them or separate them. Let's show Portfolio first)
    // final serviceImages = services.where((s) => s['image'] != null).map((s) => s['image'] as String).toList();

    final allImages =
        portfolioImages; // Just portfolio for this tab, or mix? Users usually want "Media" to be what they upload.

    if (allImages.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 20),
          const Text('No hay fotos en el portafolio'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.push('/business/create-portfolio'),
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Agregar Fotos'),
          ),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => context.push('/business/create-portfolio'),
              icon: const Icon(Icons.add_a_photo, size: 16),
              label: const Text('Agregar'),
            ),
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: allImages.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: allImages[index],
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewsList(List<Map<String, dynamic>> reviews, bool isDark) {
    if (reviews.isEmpty)
      return const Center(child: Text('No hay reseÃ±as aÃºn'));

    return Column(
      children: reviews.map((r) {
        final client = r['client'];
        final clientName = client != null
            ? '${client['first_name']} ${client['last_name']}'
            : 'Cliente AnÃ³nimo';
        final rating = r['rating'] ?? 5;
        final content = r['content'] ?? '';
        final clientImage = client != null
            ? (client['profile_url'] ?? client['profile_image'])
            : null;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: clientImage != null
                        ? NetworkImage(clientImage)
                        : null,
                    child: clientImage == null
                        ? const Icon(Icons.person, size: 16)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      clientName,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        size: 14,
                        color: Colors.amber,
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(
                  color: isDark ? Colors.grey[300] : Colors.grey[800],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStat(String value, String label, BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isLink ? const Color(0xFF4285F4) : Colors.black87,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
