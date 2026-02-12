import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'models/contact_model.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/providers/user_mode_provider.dart';
import '../chat/presentation/providers/chat_provider.dart';
import '../../features/settings/providers/profile_provider.dart';
import '../../core/widgets/category_badge.dart';

class UserProfilePage extends ConsumerWidget {
  // Accepts either a full contact model or just basic info if fetching
  final ContactDetails? contact;
  final int?
  userId; // Backup to fetch if contact is null (todo: implement fetch)

  const UserProfilePage({super.key, this.contact, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    // TODO: If contact is null, fetch using userId via provider
    // For now, assume contact is passed or mock it in UI
    final unknownUser = t['profile_unknown_user'] ?? 'Unknown User';
    final nameParts = unknownUser.split(' ');

    final displayContact =
        contact ??
        ContactDetails(
          id: userId ?? 0,
          firstName: nameParts.isNotEmpty ? nameParts[0] : 'User',
          lastName: nameParts.length > 1 ? nameParts[1] : 'Unknown',
          hasBusiness: false,
          verifiedIdentity: false,
        );

    return Scaffold(
      body: Stack(
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
                if (displayContact.bannerUrl != null)
                  CachedNetworkImage(
                    imageUrl: displayContact.bannerUrl!,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.shade800,
                            Colors.purple.shade800,
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade800, Colors.purple.shade800],
                      ),
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
          CustomScrollView(
            slivers: [
              // Transparent Spacer to show image
              // Transparent Spacer to show image
              const SliverToBoxAdapter(child: SizedBox(height: 226)),
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
                      // Stack: Avatar (popped out) + Info
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topLeft,
                        children: [
                          // Info Row (Aligned relative to Avatar space)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                ), // Spacer for Avatar (90 + margin)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              displayContact.fullName,
                                              style: GoogleFonts.outfit(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (displayContact
                                              .verifiedIdentity) ...[
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.verified,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                          ],
                                        ],
                                      ),
                                      if (displayContact.hasBusiness)
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(
                                              0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            t['profile_pro_business'] ??
                                                'Pro Business',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      else
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          child: const ClientBadge(),
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
                            child: GestureDetector(
                              onTap: () {
                                if (displayContact.profileUrl != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => _FullScreenImage(
                                        imageUrl: displayContact.profileUrl!,
                                      ),
                                    ),
                                  );
                                }
                              },
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
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                  ),
                                  padding: const EdgeInsets.all(2.5),
                                  child: displayContact.profileUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: displayContact.profileUrl!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        imageProvider,
                                                    radius: 40,
                                                  ),
                                          placeholder: (context, url) =>
                                              const CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Colors.grey,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: Text(
                                                  displayContact.firstName
                                                      .substring(0, 1),
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.grey[200],
                                          child: Text(
                                            displayContact.firstName.substring(
                                              0,
                                              1,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Main Content Body
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // About Section
                            _SectionHeader(
                              title: t['profile_section_about'] ?? 'Sobre mí',
                            ),
                            Text(
                              displayContact.aboutMe ??
                                  (t['profile_no_description'] ??
                                      'Sin descripción.'),
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: isDark ? Colors.white70 : Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Actions - Improved Design
                            Row(
                              children: [
                                // Message Button
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF4285F4),
                                          Color(0xFF2B6CB0),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF4285F4,
                                          ).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () async {
                                          final profile = ref
                                              .read(profileProvider)
                                              .value;
                                          if (profile == null) return;

                                          final isBusinessMode = ref.read(
                                            userModeProvider,
                                          );
                                          final myId = isBusinessMode
                                              ? profile.businessId
                                              : profile.id;

                                          if (myId == null) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Error: No ID found for current mode',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          try {
                                            final chatId = await ref
                                                .read(chatProvider.notifier)
                                                .createConversation(
                                                  myId: myId,
                                                  amIBusiness: isBusinessMode,
                                                  peerId: displayContact.id,
                                                  isPeerBusiness: false,
                                                );

                                            if (chatId != null &&
                                                context.mounted) {
                                              context.push('/chats/$chatId');
                                            }
                                          } catch (e) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Error starting chat: $e',
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.chat_bubble_outline,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                t['profile_action_message'] ??
                                                    'Mensaje',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Add Contact Button
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF00C853),
                                          Color(0xFF009624),
                                        ], // Green Gradient
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF00C853,
                                          ).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Solicitud enviada a ${displayContact.firstName}',
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.person_add_rounded,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  t['profile_action_add_contact'] ??
                                                      'Añadir',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 100), // Bottom padding
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. Floating Action Buttons (Back)
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
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const _FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(child: CachedNetworkImage(imageUrl: imageUrl)),
      ),
    );
  }
}
