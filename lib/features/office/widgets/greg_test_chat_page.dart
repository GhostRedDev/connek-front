import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../settings/providers/profile_provider.dart';
import '../providers/greg_provider.dart';

class GregTestChatPage extends ConsumerStatefulWidget {
  final int businessId;
  const GregTestChatPage({super.key, required this.businessId});

  @override
  ConsumerState<GregTestChatPage> createState() => _GregTestChatPageState();
}

class _GregTestChatPageState extends ConsumerState<GregTestChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _conversationId;
  String? _currentUserId;
  List<dynamic> _messages = [];
  bool _isLoading = true;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    // Get user profile first
    final user = await ref.read(profileProvider.future);
    if (user == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    _currentUserId = user.id.toString();

    final gregService = ref.read(gregServiceProvider);
    try {
      debugPrint('💬 Initializing Greg Test Chat...');
      final conv = await gregService.createTestConversation(
        client1Id: _currentUserId!,
        business2Id: widget.businessId.toString(),
      );

      if (conv != null && conv['id'] != null) {
        _conversationId = conv['id'].toString();
        debugPrint('✅ Conversation created: $_conversationId');
        await _fetchMessages();
        _startPolling();
      } else {
        debugPrint('❌ Failed to create conversation');
      }
    } catch (e) {
      debugPrint('❌ Error initializing chat: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_conversationId != null) _fetchMessages();
    });
  }

  Future<void> _fetchMessages() async {
    if (_conversationId == null) return;
    try {
      final msgs = await ref
          .read(gregServiceProvider)
          .getConversationMessages(_conversationId!);
      if (mounted) {
        setState(() {
          _messages = msgs;
        });
        // Auto-scroll on first load if at bottom could be good, but standard behavior is fine for now
      }
    } catch (e) {
      // debugPrint('Error polling messages: $e');
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _conversationId == null || _currentUserId == null) {
      return;
    }

    _messageController.clear();
    try {
      await ref
          .read(gregServiceProvider)
          .sendTestMessage(
            conversationId: _conversationId!,
            content: text,
            senderId: _currentUserId!,
            receiverBusinessId: widget.businessId.toString(),
          );
      await _fetchMessages();
      _scrollToBottom();
    } catch (e) {
      debugPrint('Error sending message: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending message: $e')));
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine safe area for bottom input
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF131619), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2429),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/Greg_Top_Bot_CArd.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Greg',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Modo prueba',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF4B39EF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
                  )
                : _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2429),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10),
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white54,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Envía un mensaje para comenzar',
                          style: GoogleFonts.outfit(
                            color: Colors.white60,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return _buildMessageBubble(msg);
                    },
                  ),
          ),
          _buildInputArea(bottomPadding),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    // Per Technical Prompt:
    // sender_client == true -> User (Right)
    // sender_bot == true -> Greg (Left)
    // Fallback: Check if sender ID matches current user
    final bool isBot = msg['sender_bot'] == true;
    final bool isMe =
        msg['sender_client'] == true ||
        (!isBot && msg['sender'].toString() == _currentUserId.toString());

    final content = msg['content'] ?? '';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFF635BFF)
              : const Color(0xFF1E2025), // Purple for Me, Dark for Bot
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          content,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 15,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(double bottomPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottomPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2429),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF131619),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: TextField(
                controller: _messageController,
                style: GoogleFonts.outfit(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  hintStyle: GoogleFonts.outfit(color: Colors.white38),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: _sendMessage,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF4B39EF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
