import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'providers/chat_provider.dart';
import 'chat_page.dart'; // Import ChatPage for Split View

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
                      _buildHeader(context, isDark, showRefresh: true),
                      Expanded(
                        child: _buildChatList(
                          chatsAsync,
                          isDark,
                          isDesktop: true,
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
                _buildHeader(context, isDark, showRefresh: true),
                Expanded(
                  child: _buildChatList(chatsAsync, isDark, isDesktop: false),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Feature coming soon: Select Contact'),
            ),
          );
        },
        label: const Text('Nuevo Chat'),
        icon: const Icon(Icons.message),
        backgroundColor: const Color(0xFF4285F4),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isDark, {
    bool showRefresh = false,
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
                  onPressed: () => ref.refresh(chatProvider),
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
        ],
      ),
    );
  }

  Widget _buildChatList(
    AsyncValue<List<ChatConversation>> chatsAsync,
    bool isDark, {
    required bool isDesktop,
  }) {
    return chatsAsync.when(
      data: (chats) {
        if (chats.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
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
