import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/business_profile_service.dart';
import '../../social/providers/review_provider.dart';
import '../../social/models/review_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Ensure this package is used for input

class BusinessProfileView extends ConsumerStatefulWidget {
  final String businessId;
  const BusinessProfileView({super.key, required this.businessId});

  @override
  ConsumerState<BusinessProfileView> createState() =>
      _BusinessProfileViewState();
}

class _BusinessProfileViewState extends ConsumerState<BusinessProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _toggleLike() async {
    await ref
        .read(businessProfileServiceProvider)
        .toggleLike(widget.businessId);
    ref.invalidate(businessProfileProvider(widget.businessId));
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(businessProfileProvider(widget.businessId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F7);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
        data: (profile) {
          if (profile == null)
            return const Center(child: Text('Business not found'));

          return NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  leading: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
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
                        CachedNetworkImage(
                          imageUrl: profile.coverImage,
                          fit: BoxFit.cover,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black26],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Info Section
                SliverToBoxAdapter(
                  child: Container(
                    color: cardColor,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundImage: CachedNetworkImageProvider(
                                profile.avatarImage,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: _toggleLike,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        color: profile.isLiked
                                            ? Colors.red.withOpacity(0.1)
                                            : null,
                                      ),
                                      child: Icon(
                                        profile.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: profile.isLiked
                                            ? Colors.red
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  _buildCircleAction(
                                    context,
                                    Icons.calendar_month,
                                  ),
                                  _buildPillAction(
                                    context,
                                    'Llamar',
                                    Colors.blue,
                                    Colors.white,
                                    Icons.phone,
                                  ),
                                  _buildPillAction(
                                    context,
                                    'Chat',
                                    Colors.grey[200]!,
                                    Colors.black,
                                    Icons.chat_bubble_outline,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.name,
                                style: GoogleFonts.outfit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                profile.handle,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.black26
                                      : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  profile.description,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    height: 1.4,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat(
                              '${(profile.followers / 1000).toStringAsFixed(1)}K',
                              'Seguidores',
                              textColor,
                            ),
                            _buildStat(
                              '${profile.servicesCount}',
                              'Servicios',
                              textColor,
                            ),
                            _buildStat(
                              '${profile.rating}',
                              '${profile.reviewCount} reseñas',
                              textColor,
                            ),
                            _buildStat(
                              '${profile.likesCount}',
                              'Likes',
                              textColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              'About us',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            childrenPadding: EdgeInsets.zero,
                            tilePadding: EdgeInsets.zero,
                            initiallyExpanded: true,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF121212)
                                      : const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    _buildContactRow(
                                      Icons.location_on_outlined,
                                      profile.location,
                                      isDark,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildContactRow(
                                      Icons.access_time,
                                      profile.hours,
                                      isDark,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildContactRow(
                                      Icons.phone_outlined,
                                      profile.phone,
                                      isDark,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildContactRow(
                                      Icons.email_outlined,
                                      profile.email,
                                      isDark,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildContactRow(
                                      Icons.language,
                                      profile.website,
                                      isDark,
                                      isLink: true,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        _buildSocialIcon(
                                          Icons.camera_alt_outlined,
                                          profile.instagram,
                                          Colors.purple,
                                          isDark,
                                        ),
                                        const SizedBox(width: 16),
                                        _buildSocialIcon(
                                          Icons.facebook,
                                          profile.facebook,
                                          Colors.blue,
                                          isDark,
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
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      labelColor: const Color(0xFF4285F4),
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
                    cardColor,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildServicesTab(widget.businessId, isDark),
                _buildPhotosTab(profile.images),
                const Center(child: Text("Eventos (Próximamente)")),
                _buildReviewsTab(isDark),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildServicesTab(String id, bool isDark) {
    final servicesAsync = ref.watch(businessServicesProvider(id));
    return servicesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (services) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final s = services[index];
            return Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(s.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.black45,
                        radius: 16,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                s.rating,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s.title,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PRECIO',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  s.price,
                                  style: GoogleFonts.outfit(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
                              ),
                              child: const Text('Agendar'),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildPhotosTab(List<String> images) {
    if (images.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No photos yet',
              style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[300]),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab(bool isDark) {
    final reviewsAsync = ref.watch(reviewProvider(widget.businessId));

    return reviewsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error loading reviews: $e')),
      data: (reviews) {
        return Stack(
          children: [
            if (reviews.isEmpty)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No reviews yet',
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 80,
                ),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  // Safe access to client data
                  final clientName = review.client != null
                      ? '${review.client!['first_name']} ${review.client!['last_name']}'
                      : 'Anonymous';
                  // Handle profile url or fallback
                  final clientImage =
                      review.client?['profile_url'] ??
                      'https://ui-avatars.com/api/?name=${clientName.replaceAll(' ', '+')}';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(clientImage),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    clientName,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          review.rating.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              /*
                              Text(
                                'Subtitle/Company', // Assuming we don't have this in ReviewModel yet
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              */
                              const SizedBox(height: 8),
                              Text(
                                review.content,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Like Button
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(
                                        reviewProvider(
                                          widget.businessId,
                                        ).notifier,
                                      )
                                      .toggleLike(review.id);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Like', // We can show count if available in future
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    if (review.likesCount > 0) ...[
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${review.likesCount})',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            // Floating Action Button for Adding Review
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton.extended(
                onPressed: () => _showAddReviewDialog(context),
                icon: const Icon(Icons.edit),
                label: const Text('Write Review'),
                backgroundColor: const Color(0xFF4285F4),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    final commentController = TextEditingController();
    double rating = 5.0;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Write a Review'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Rate your experience:'),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (r) {
                    setState(() {
                      rating = r;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Share your thoughts...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (commentController.text.isEmpty) return;
                  try {
                    await ref
                        .read(reviewProvider(widget.businessId).notifier)
                        .addReview(
                          rating: rating.toInt(),
                          content: commentController.text,
                        );
                    if (ctx.mounted) Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review added successfully'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                },
                child: const Text('Post'),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helpers
  Widget _buildCircleAction(BuildContext context, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Icon(icon, size: 20, color: Colors.grey[700]),
    );
  }

  Widget _buildPillAction(
    BuildContext context,
    String label,
    Color bg,
    Color text,
    IconData? icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: text),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              color: text,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildContactRow(
    IconData icon,
    String text,
    bool isDark, {
    bool isLink = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: isLink
                ? Colors.blue
                : (isDark ? Colors.white70 : Colors.grey[800]),
            decoration: isLink ? TextDecoration.underline : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
    IconData icon,
    String text,
    Color color,
    bool isDark,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  final Color _bgColor;

  _SliverAppBarDelegate(this._tabBar, this._bgColor);

  @override
  double get minExtent => _tabBar.preferredSize.height + 1;
  @override
  double get maxExtent => _tabBar.preferredSize.height + 1;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: _bgColor, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
