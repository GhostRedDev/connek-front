import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../providers/chat_provider.dart';
import 'chat_page.dart'; // Import ChatPage for Split View
import 'new_chat_page.dart';
import '../../services/greg_ai_service.dart'; // Import Greg AI Service
import '../../services/marketing_ai_service.dart'; // Import Marketing AI Service
import '../../../../core/widgets/glass_fab_button.dart';
import '../../../../core/providers/user_mode_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatChats extends ConsumerStatefulWidget {
  const ChatChats({super.key});

  @override
  ConsumerState<ChatChats> createState() => _ChatChatsState();
}

class _ChatChatsState extends ConsumerState<ChatChats> {
  int? _selectedConversationId;

  @override
  Widget build(BuildContext context) {
    final chatsAsync = ref.watch(chatProvider);
    final isBusinessMode = ref.watch(userModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF131619) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          if (isDesktop) {
            return Row(
              children: [
                // Left Panel: Chat List
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      _buildHeader(
                        context,
                        isDark,
                        showRefresh: true,
                        isBusinessMode: isBusinessMode,
                      ),
                      Expanded(
                        child: _buildChatList(
                          chatsAsync,
                          isDark,
                          isDesktop: true,
                          isBusinessMode: isBusinessMode,
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider
                Container(
                  width: 1,
                  color: isDark ? Colors.white10 : Colors.grey[200],
                ),
                // Right Panel: Chat Page
                Expanded(
                  flex: 8,
                  child: _selectedConversationId != null
                      ? ChatPage(
                          key: ValueKey(
                            _selectedConversationId,
                          ), // Rebuild on ID change
                          chatId: _selectedConversationId.toString(),
                          isEmbedded: true,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64,
                                color: isDark
                                    ? Colors.white24
                                    : Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Select a conversation',
                                style: GoogleFonts.inter(
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.grey[500],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            );
          } else {
            // Mobile Layout
            return Column(
              children: [
                _buildHeader(
                  context,
                  isDark,
                  showRefresh: true,
                  isBusinessMode: isBusinessMode,
                ),
                Expanded(
                  child: _buildChatList(
                    chatsAsync,
                    isDark,
                    isDesktop: false,
                    isBusinessMode: isBusinessMode,
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: GlassFabButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const NewChatPage()));
        },
        icon: Icons.message,
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isDark, {
    bool showRefresh = false,
    bool isBusinessMode = false,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 140, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chats',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              if (showRefresh)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    ref.invalidate(chatProvider);
                  },
                  color: Colors.grey,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'all conversations',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'Search chats...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (!isBusinessMode) _buildSuggestedBusinesses(isDark),
        ],
      ),
    );
  }

  Widget _buildSuggestedBusinesses(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Negocios Sugeridos',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100, // Adjusted height
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: Supabase.instance.client
                .from('business')
                .select('id, name, profile_image')
                .limit(10), // Limit to 10 suggestions
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
              if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return const SizedBox();
              }
              final businesses = List<Map<String, dynamic>>.from(
                snapshot.data as List,
              );

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: businesses.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final b = businesses[index];
                  final imageUrl = b['profile_image'] != null
                      ? Supabase.instance.client.storage
                            .from('business')
                            .getPublicUrl(b['profile_image'])
                      : null;

                  return GestureDetector(
                    onTap: () => context.push('/client/business/${b['id']}'),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2), // Border width
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFE1306C),
                                Color(0xFFF77737),
                              ], // Insta-like gradient
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30, // Microcard size
                            backgroundColor: isDark
                                ? Colors.black
                                : Colors.white,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: imageUrl != null
                                  ? CachedNetworkImageProvider(imageUrl)
                                  : null,
                              backgroundColor: Colors.grey[300],
                              child: imageUrl == null
                                  ? Text(
                                      (b['name'] as String)[0].toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 70,
                          child: Text(
                            b['name'],
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildChatList(
    AsyncValue<List<ChatConversation>> chatsAsync,
    bool isDark, {
    required bool isDesktop,
    required bool isBusinessMode,
  }) {
    return chatsAsync.when(
      data: (chats) {
        if (chats.isEmpty) {
          // Show AI bots even if chats are empty ONLY IF BUSINESS
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            children: [
              if (isBusinessMode) _buildBotsSection(context, isDark, isDesktop),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 48,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No conversations yet',
                      style: GoogleFonts.inter(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          // Add 1 for Bots Section IF BUSINESS
          itemCount: chats.length + (isBusinessMode ? 1 : 0),
          separatorBuilder: (ctx, i) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            // Bots Section is first
            if (isBusinessMode && index == 0) {
              return _buildBotsSection(context, isDark, isDesktop);
            }

            // Adjust index for actual chats
            final chatIndex = isBusinessMode ? index - 1 : index;
            final chat = chats[chatIndex];
            final lastMsg = chat.lastMessage;
            final timeStr = lastMsg != null
                ? _formatTime(lastMsg['created_at'])
                : '';

            final isSelected = _selectedConversationId == chat.id;

            return GestureDetector(
              onTap: () {
                if (isDesktop) {
                  setState(() {
                    _selectedConversationId = chat.id;
                  });
                } else {
                  context.push(
                    '/chats/${chat.id}',
                    extra: chat.contact['name'],
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: isDesktop && isSelected
                    ? const EdgeInsets.all(12)
                    : null,
                decoration: isDesktop && isSelected
                    ? BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 56,
                            height: 56,
                            color: Colors.grey[800],
                            child: chat.contact['image'] != null
                                ? CachedNetworkImage(
                                    imageUrl: chat.contact['image'],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(color: Colors.grey[800]),
                                    errorWidget: (context, url, e) => Center(
                                      child: Text(
                                        (chat.contact['name'] ?? 'U')[0]
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      (chat.contact['name'] ?? 'U')[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        if (chat.unreadCount > 0)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF4285F4),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${chat.unreadCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  chat.contact['name'] ?? 'Unknown',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                timeStr,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            lastMsg?['content'] ?? 'No messages',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Error: $err',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildBotsSection(BuildContext context, bool isDark, bool isDesktop) {
    return Column(
      children: [
        _buildGregChatItem(context, isDark, isDesktop),
        const SizedBox(height: 16),
        _buildMarketingChatItem(context, isDark, isDesktop),
      ],
    );
  }

  Widget _buildGregChatItem(BuildContext context, bool isDark, bool isDesktop) {
    return GestureDetector(
      onTap: () {
        context.push('/greg-chat');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0EA5E9).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0EA5E9).withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      GregAIService.getGregProfile()['image'],
                      fit: BoxFit.cover,
                      width: 56,
                      height: 56,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF0EA5E9),
                                const Color(0xFF0284C7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.smart_toy,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF34A853),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.smart_toy,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${GregAIService.getGregProfile()['name']} 🤖',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'AI',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Asistente de Operaciones y Soporte',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketingChatItem(
    BuildContext context,
    bool isDark,
    bool isDesktop,
  ) {
    return GestureDetector(
      onTap: () {
        context.push('/marketing-chat');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF59E0B).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF59E0B).withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      MarketingAIService.getMarketingProfile()['image'],
                      fit: BoxFit.cover,
                      width: 56,
                      height: 56,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFF59E0B),
                                const Color(0xFFD97706),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.campaign,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF34A853),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.smart_toy,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${MarketingAIService.getMarketingProfile()['name']} 📢',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'AI',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Estrategias de Marketing y Ventas',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String dateString) {
    try {
      final date = DateTime.parse(dateString).toLocal();
      final now = DateTime.now();
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        return DateFormat.Hm().format(date); // HH:MM
      } else {
        // Should use a date formatter for Yesterday/Date
        return '${date.day}/${date.month}';
      }
    } catch (e) {
      return '';
    }
  }
}
