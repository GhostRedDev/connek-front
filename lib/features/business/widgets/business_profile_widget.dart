import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  bool _isAboutExpanded = true; // For "About us" accordion

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

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider);
    // Safe access to profile data
    final profile = businessData.maybeWhen(
      data: (d) => d.businessProfile,
      orElse: () => null,
    );

    // Mock Data (or safe defaults) if profile is incomplete
    final name = profile?['name'] ?? 'Studio Creativo Luna';
    final description =
        profile?['description'] ??
        'Transformamos ideas en experiencias visuales memorables. Especialistas en branding, diseño web y producción audiovisual.';

    // Attempt to resolve images from provider logic or fallback
    // Note: In a real scenario, ensure imageUrl is a full URL.
    final coverImage =
        'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=1200&q=80'; // Mock Office
    final profileImage =
        profile?['image'] ?? 'https://i.pravatar.cc/300?u=studio';

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Logic to go back or switch tab if needed
                  },
                ),
              ),
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
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(imageUrl: coverImage, fit: BoxFit.cover),
                    // Gradient overlay for text protection if needed
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
              // 1. Profile Info Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Row: Avatar + Actions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: backgroundColor, // Match bg to hide overlap
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
                        // Action Buttons
                        _buildActionButton(Icons.favorite_border, () {}),
                        const SizedBox(width: 8),
                        _buildActionButton(Icons.calendar_today, () {}),
                        const SizedBox(width: 8),
                        // Main blue btn
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            elevation: 0,
                          ),
                          child: const Text('Llamar'),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          Icons.chat_bubble_outline,
                          () {},
                          label: 'Chat',
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Name & Handle
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      '@studiocreativoluna', // Mock handle
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Description Card
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

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('2.4K', 'Seguidores', context),
                        _buildStat('5', 'Servicios', context),
                        _buildStat('4.9', '127 reseñas', context),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // About Us Accordion
                    Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF5F5F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Header
                          InkWell(
                            onTap: () {
                              setState(
                                () => _isAboutExpanded = !_isAboutExpanded,
                              );
                            },
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
                                    'About us',
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
                                    'Ciudad de México, MX',
                                  ),
                                  _buildInfoRow(
                                    Icons.access_time,
                                    'Lun - Vie: 9:00 - 18:00',
                                  ),
                                  _buildInfoRow(
                                    Icons.phone_outlined,
                                    '+52 55 1234 5678',
                                  ),
                                  _buildInfoRow(
                                    Icons.email_outlined,
                                    'hola@studiocreativoluna.com',
                                  ),
                                  _buildInfoRow(
                                    Icons.language,
                                    'www.studiocreativoluna.com',
                                    isLink: true,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 16,
                                        color: Color(0xFFE1306C),
                                      ), // IG color-ish
                                      const SizedBox(width: 8),
                                      Text(
                                        '@studiocreativoluna',
                                        style: GoogleFonts.inter(fontSize: 12),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(
                                        Icons.facebook,
                                        size: 16,
                                        color: Color(0xFF1877F2),
                                      ), // FB Color
                                      const SizedBox(width: 8),
                                      Text(
                                        'studiocreativoluna',
                                        style: GoogleFonts.inter(fontSize: 12),
                                      ),
                                    ],
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

              // Tab Content (Manually rendered for simplicity in nested scroll view)
              // Ideally, we'd use TabBarView inside the body, but with SingleChildScrollView parent, we just mock the selected view or use a fixed height container.
              // Given the design shows services listed below, let's just show Services for this demo.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildServiceCard(isDark),
                    _buildServiceCard(isDark),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    VoidCallback onTap, {
    String? label,
  }) {
    // If label is present, it's the "Chat" button styled differently
    if (label != null) {
      return OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16, color: Colors.grey[800]),
        label: Text(
          label,
          style: GoogleFonts.inter(color: Colors.grey[800], fontSize: 12),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: Colors.grey[100],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.grey[700], size: 20),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        padding: EdgeInsets.zero,
      ),
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

  Widget _buildServiceCard(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?auto=format&fit=crop&w=600&q=80',
          ), // Spa/Service Image
          fit: BoxFit.cover,
        ),
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
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                stops: const [0.5, 1.0],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Rating & Heart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '5.0',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Brand / Tag
                Row(
                  children: [
                    const Icon(Icons.spa, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      'AR Labs & Vision',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Service Name
                Text(
                  'Terapia para mejorar el flujo de energía y aliviar el dolor.',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Bottom Row: Price & Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PRECIO',
                          style: GoogleFonts.inter(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '\$40/h',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4285F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4285F4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        minimumSize: const Size(0, 36),
                      ),
                      child: Text(
                        'Agendar',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}
