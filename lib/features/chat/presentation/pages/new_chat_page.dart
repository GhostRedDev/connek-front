import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/chat_provider.dart';
import '../../../../core/providers/user_mode_provider.dart';

class NewChatPage extends ConsumerStatefulWidget {
  const NewChatPage({super.key});

  @override
  ConsumerState<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends ConsumerState<NewChatPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String _activeFilter = 'all'; // 'all', 'client', 'business'

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
      _loadSuggestions();
      return;
    }

    setState(() => _isLoading = true);

    // Call Provider Search with Filter
    final results = await ref
        .read(chatProvider.notifier)
        .searchUsers(query, filter: _activeFilter);

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
            // Search Bar
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
            const SizedBox(height: 12),

            // Filters
            Row(
              children: [
                _buildFilterChip('Todos', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Personas', 'client'),
                const SizedBox(width: 8),
                _buildFilterChip('Negocios', 'business'),
              ],
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

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _activeFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() => _activeFilter = value);
        // Re-run search if text exists
        if (_searchController.text.isNotEmpty) {
          _performSearch(_searchController.text);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
