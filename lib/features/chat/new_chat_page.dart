import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'providers/chat_provider.dart';
import '../../../core/providers/user_mode_provider.dart';

class NewChatPage extends ConsumerStatefulWidget {
  const NewChatPage({super.key});

  @override
  ConsumerState<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends ConsumerState<NewChatPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  void _loadSuggestions() async {
    setState(() => _isLoading = true);
    try {
      final suggestions = await ref
          .read(chatProvider.notifier)
          .getSuggestedUsers();
      if (mounted) {
        setState(() {
          _searchResults = suggestions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _performSearch(String query) async {
    if (query.isEmpty) {
      // Reload suggestions if query cleared
      _loadSuggestions();
      return;
    }

    setState(() => _isLoading = true);

    // Call Provider Search
    final results = await ref.read(chatProvider.notifier).searchUsers(query);

    if (mounted) {
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    }
  }

  void _startChat(Map<String, dynamic> user) async {
    setState(() => _isLoading = true);

    final isBusinessMode = ref.read(userModeProvider);
    // Needed: ID of current user (My ID)
    // ChatNotifier fetchConversations does logic to get ID.
    // We should expose getMyId from ChatNotifier or fetch it again.
    // Simpler: Reuse logic or check provider state? No, provider state is List calls.

    // Quick Fix: Reuse fetch logic pattern or create helper in provider.
    // Assuming user is authenticated if here.

    try {
      final myId = await ref
          .read(chatProvider.notifier)
          .getMyId(isBusinessMode);
      if (myId == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error identifying user')),
          );
        }
        return;
      }

      final conversationId = await ref
          .read(chatProvider.notifier)
          .createConversation(
            myId: myId,
            amIBusiness: isBusinessMode,
            peerId: user['id'],
            isPeerBusiness: user['is_business'],
          );

      if (mounted) {
        setState(() => _isLoading = false);
        if (conversationId != null) {
          context.push('/chats/$conversationId', extra: user['name']);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Failed to start chat')));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Nuevo Chat',
          style: GoogleFonts.outfit(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar usuario o negocio...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onSubmitted: _performSearch,
            ),
            const SizedBox(height: 16),
            if (_isLoading) const LinearProgressIndicator(),

            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final user = _searchResults[index];

                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: user['image'] != null
                          ? CachedNetworkImage(
                              imageUrl: user['image'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: Text(
                                  user['name'].isNotEmpty
                                      ? user['name'][0]
                                      : '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Text(
                                  user['name'].isNotEmpty
                                      ? user['name'][0]
                                      : '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                user['name'].isNotEmpty ? user['name'][0] : '?',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    title: Text(user['name']),
                    subtitle: Text(user['is_business'] ? 'Negocio' : 'Cliente'),
                    onTap: () => _startChat(user),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
