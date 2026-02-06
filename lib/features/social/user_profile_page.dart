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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(displayContact.fullName),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Banner
                  displayContact.bannerUrl != null
                      ? CachedNetworkImage(
                          imageUrl: displayContact.bannerUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
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
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
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
                      // Profile Image (Clickable for full screen)
                      GestureDetector(
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
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundImage: displayContact.profileUrl != null
                                ? CachedNetworkImageProvider(
                                    displayContact.profileUrl!,
                                  )
                                : null,
                            child: displayContact.profileUrl == null
                                ? Text(
                                    displayContact.firstName.substring(0, 1),
                                    style: const TextStyle(fontSize: 30),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                if (displayContact.verifiedIdentity) ...[
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
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t['profile_pro_business'] ?? 'Pro Business',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            else
                              // Show "Cliente" badge if not a business
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: const ClientBadge(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // About Section
                  _SectionHeader(
                    title: t['profile_section_about'] ?? 'Sobre mí',
                  ),
                  Text(
                    displayContact.aboutMe ??
                        (t['profile_no_description'] ?? 'Sin descripción.'),
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
                              colors: [Color(0xFF4285F4), Color(0xFF2B6CB0)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4285F4).withOpacity(0.3),
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
                                final profile = ref.read(profileProvider).value;
                                if (profile == null) return;

                                final isBusinessMode = ref.read(
                                  userModeProvider,
                                );
                                final myId = isBusinessMode
                                    ? profile.businessId
                                    : profile.id;

                                if (myId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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

                                  if (chatId != null && context.mounted) {
                                    context.push('/chats/$chatId');
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      t['profile_action_message'] ?? 'Mensaje',
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
                                color: const Color(0xFF00C853).withOpacity(0.3),
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
                                ScaffoldMessenger.of(context).showSnackBar(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        overflow: TextOverflow.ellipsis,
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
                ],
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
