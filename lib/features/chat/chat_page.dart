import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';
import 'widgets/chat_input_area.dart';
import 'providers/chat_provider.dart';
import '../call/services/call_service.dart';
import '../../core/providers/locale_provider.dart';

// ignore: unused_import
import '../social/user_profile_page.dart';
// ignore: unused_import
import '../social/models/contact_model.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId; // Conversation ID
  final bool isEmbedded; // For Split View

  const ChatPage({super.key, required this.chatId, this.isEmbedded = false});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _supabase = Supabase.instance.client;
  int _myClientId = 0;

  @override
  void initState() {
    super.initState();
    _fetchMyClientId();
  }

  Future<void> _fetchMyClientId() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    try {
      final res = await _supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();
      if (res != null && mounted) {
        setState(() {
          _myClientId = res['id'];
        });
      }
    } catch (e) {
      print('Error fetching my client ID: $e');
    }
  }

  // To avoid constant flickering, we cache the stream or use a StreamProvider.
  // But for now, calling getMessagesStream directly in build is okay if the provider is stable.
  // Better: Create a provider family.

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Attachment Methods
  Future<void> _handleAttachment(String type) async {
    final picker = ImagePicker();
    XFile? file;

    if (type == 'camera') {
      file = await picker.pickImage(source: ImageSource.camera);
    } else if (type == 'image') {
      file = await picker.pickImage(source: ImageSource.gallery);
    } else if (type == 'video') {
      file = await picker.pickVideo(source: ImageSource.gallery);
    }

    if (file != null) {
      _uploadAndSend(file, type);
    }
  }

  Future<void> _uploadAndSend(XFile file, String type) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ref.read(translationProvider).value?['chat_uploading'] ??
              'Uploading...',
        ),
      ),
    );

    try {
      final bytes = await file.readAsBytes();
      final fileName = file.name;

      String contentType = 'file';
      if (type == 'camera' || type == 'image') contentType = 'image';
      if (type == 'video') contentType = 'video';
      if (type == 'audio') contentType = 'audio';

      final int conversationId = int.tryParse(widget.chatId) ?? 0;

      final url = await ref
          .read(chatProvider.notifier)
          .uploadFile(bytes, fileName, conversationId);

      if (url != null) {
        await ref
            .read(chatProvider.notifier)
            .sendMessage(conversationId, url, contentType: contentType);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(translationProvider).value?['chat_upload_failed'] ??
                  'Upload failed',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black87;
        final tAsync = ref.watch(translationProvider);

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAttachmentOption(
                Icons.image,
                tAsync.value?['chat_attachment_gallery'] ?? 'Gallery',
                'image',
                textColor,
              ),
              _buildAttachmentOption(
                Icons.videocam,
                tAsync.value?['chat_attachment_video'] ?? 'Video',
                'video',
                textColor,
              ),
              _buildAttachmentOption(
                Icons.camera_alt,
                tAsync.value?['chat_attachment_camera'] ?? 'Camera',
                'camera',
                textColor,
              ),
              _buildAttachmentOption(
                Icons.insert_drive_file,
                tAsync.value?['chat_attachment_file'] ?? 'Document',
                'file',
                textColor,
              ),
              _buildAttachmentOption(
                Icons.mic,
                tAsync.value?['chat_attachment_audio'] ?? 'Audio',
                'audio',
                textColor,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption(
    IconData icon,
    String label,
    String type,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color)),
      onTap: () {
        Navigator.pop(context);
        if (type == 'file' || type == 'audio') {
          final t = ref.read(translationProvider).value;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                t?['chat_attachment_restricted'] ??
                    'Picking documents/audio requires restart/setup. Use Image/Video/Camera for now.',
              ),
            ),
          );
        } else {
          _handleAttachment(type);
        }
      },
    );
  }

  Widget _buildMessageContent(ChatMessage msg, bool isMe, bool isDark) {
    final bool isImage = msg.contentType == 'image';

    if (isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          msg.content,
          width: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
      );
    }

    return Text(
      msg.content,
      style: GoogleFonts.inter(
        color: isMe ? Colors.white : (isDark ? Colors.white : Colors.black87),
        fontSize: 15,
        height: 1.4,
      ),
    );
  }

  Future<void> _initiateCall(
    Map<String, dynamic>? contactInfo, {
    bool isVideo = true,
  }) async {
    if (contactInfo == null) return;

    final receiverId = contactInfo['id']; // int ID
    if (receiverId == null) {
      final t = ref.read(translationProvider).value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t?['chat_cannot_call'] ?? 'Cannot call: User ID not found',
          ),
        ),
      );
      return;
    }

    // 1. Fetch My Profile (Name/Image)
    final user = _supabase.auth.currentUser;
    final myName = user?.userMetadata?['full_name'] ?? user?.email ?? 'Caller';
    final myImage = user?.userMetadata?['avatar_url'];

    // 2. Generate Call ID
    final callId = DateTime.now().millisecondsSinceEpoch.toString();

    // 3. Notify Receiver
    // Pass isVideo param? Currently generic call.
    // We append query param for local usage or signal it in metadata.
    context.push('/call/$callId?isCaller=true&isVideo=$isVideo');

    try {
      final callService = CallService(
        _supabase,
        onOffer: (_) {},
        onAnswer: (_) {},
        onIceCandidate: (_) {},
      );

      await callService.startCallNotification(receiverId, {
        'name': myName,
        'image': myImage,
        'id': _myClientId,
        'isVideo': isVideo, // Pass to receiver
      }, callId);
    } catch (e) {
      print('Error notifying call: $e');
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        // For reverse: true, 0.0 is the bottom (start of list)
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF131619) : Colors.white;
    final int conversationId = int.tryParse(widget.chatId) ?? 0;

    // We can access 'chats' to get the contact info for the header
    final chatsAsync = ref.watch(chatProvider);
    final tAsync = ref.watch(translationProvider);
    Map<String, dynamic>? contactInfo;

    // Use .asData?.value to prevent flicker during refresh (Fixes valueOrNull error)
    final chats = chatsAsync.asData?.value ?? [];
    if (chats.isNotEmpty) {
      final chat = chats.firstWhere(
        (c) => c.id == conversationId,
        orElse: () => ChatConversation(id: 0, contact: {}),
      );
      if (chat.id != 0) {
        contactInfo = chat.contact;
      }
    }

    final contactName =
        contactInfo?['name'] ?? (tAsync.value?['loading'] ?? 'Loading...');
    final contactImage = contactInfo?['image'];
    final t = tAsync.value ?? {};

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor, // isDark ? Colors.transparent : Colors.white,
        elevation: 0,
        surfaceTintColor: bgColor,
        leading: widget.isEmbedded
            ? null
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white : Colors.black,
                      size: 20,
                    ),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
        title: GestureDetector(
          onTap: () {
            if (contactInfo != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserProfilePage(
                    contact: ContactDetails(
                      id: contactInfo!['id'] ?? 0,
                      firstName: contactInfo!['name'] ?? 'User',
                      lastName: '',
                      profileUrl: contactInfo!['image'],
                      hasBusiness: contactInfo!['is_business'] ?? false,
                      verifiedIdentity: true, // Mock
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05), // Glassy
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    contactName,
                    style: GoogleFonts.inter(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 12,
                  backgroundImage:
                      contactImage != null &&
                          contactImage.isNotEmpty &&
                          (contactImage.startsWith('http') ||
                              contactImage.startsWith('https'))
                      ? CachedNetworkImageProvider(contactImage)
                      : null,
                  backgroundColor: Colors.transparent,
                  child:
                      contactImage == null ||
                          contactImage.isEmpty ||
                          (!contactImage.startsWith('http') &&
                              !contactImage.startsWith('https'))
                      ? const Icon(Icons.person, size: 12, color: Colors.grey)
                      : null,
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () => _initiateCall(contactInfo, isVideo: false),
            tooltip: t['chat_call_voice'] ?? 'Llamada de voz',
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () => _initiateCall(contactInfo, isVideo: true),
            tooltip: t['chat_call_video'] ?? 'Videollamada',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              // Handle actions
              if (value == 'view_contact') {
                // Nav logic already in header title
              } else if (value == 'create_group') {
                // TODO: Create Group
              } else if (value == 'block') {
                // TODO: Block
              } else if (value == 'report') {
                // TODO: Report
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'view_contact',
                  child: Text(t['chat_menu_view_contact'] ?? 'Ver contacto'),
                ),
                PopupMenuItem(
                  value: 'create_group',
                  child: Text(t['chat_menu_create_group'] ?? 'Crear grupo'),
                ),
                PopupMenuItem(
                  value: 'block',
                  child: Text(t['chat_menu_block'] ?? 'Bloquear'),
                ),
                PopupMenuItem(
                  value: 'report',
                  child: Text(t['chat_menu_report'] ?? 'Reportar'),
                ),
              ];
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: ref
                  .read(chatProvider.notifier)
                  .getMessagesStream(conversationId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading messages: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data ?? [];
                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      t['chat_no_messages'] ?? 'No messages yet',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  );
                }

                // Auto scroll on new data?
                // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final bool isMe = (msg.sender == _myClientId);

                    return _buildMessage(
                      msg,
                      isMe,
                      isDark,
                      context,
                      contactImage: contactImage,
                      contactName: contactName,
                    );
                  },
                );
              },
            ),
          ),

          // Input Area
          ChatInputArea(
            onSendText: _sendMessage,
            onSendAudio: _sendAudio,
            onAttachmentPress: _showAttachmentMenu,
            onCameraPress: () => _handleAttachment('camera'),
          ),
        ],
      ),
    );
  }

  // Helper to send text
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Optimistic UI update could go here, but we rely on Stream

    try {
      final int conversationId = int.tryParse(widget.chatId) ?? 0;
      await ref.read(chatProvider.notifier).sendMessage(conversationId, text);
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to send message: $e')));
    }
  }

  // Helper to send audio
  Future<void> _sendAudio(String path, int duration) async {
    // Create XFile from path
    final file = XFile(path);
    // Reuse upload logic (type 'audio')
    _uploadAndSend(file, 'audio');
  }

  Widget _buildMessage(
    ChatMessage msg,
    bool isMe,
    bool isDark,
    BuildContext context, {
    String? contactImage,
    String? contactName,
  }) {
    final time = _formatMessageTime(msg.createdAt);

    // Logic for Initials if image missing
    String initials = '?';
    if (contactName != null && contactName.isNotEmpty) {
      final parts = contactName.split(' ');
      if (parts.length > 1) {
        initials = '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      } else {
        initials = contactName[0].toUpperCase();
      }
    }

    // Avatar Widget
    final avatar = ClipOval(
      child: Container(
        width: 32,
        height: 32,
        color: Colors.blueGrey,
        child:
            (contactImage != null &&
                contactImage.isNotEmpty &&
                (contactImage.startsWith('http') ||
                    contactImage.startsWith('https')))
            ? CachedNetworkImage(
                imageUrl: contactImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.blueGrey),
                errorWidget: (context, url, error) => _buildInitials(initials),
              )
            : _buildInitials(initials),
      ),
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, top: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            // Avatar for THEM (on Left)
            if (!isMe) ...[avatar, const SizedBox(width: 8)],

            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // Gradient for ME, Glass/Solid for THEM
                  gradient: isMe
                      ? const LinearGradient(
                          colors: [Color(0xFF4285F4), Color(0xFF3B78E7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isMe
                      ? null
                      : (isDark ? const Color(0xFF2A2A2A) : Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: isMe
                        ? const Radius.circular(16)
                        : const Radius.circular(4),
                    bottomRight: isMe
                        ? const Radius.circular(4)
                        : const Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Sender Name (Optional) - User asked for avatar of person coming from username
                    // If it's a group chat, showing name is good.
                    // But for 1:1, usually hidden.
                    // Let's hide name inside bubble for now since we have avatar.
                    _buildMessageContent(msg, isMe, isDark),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: isMe ? Colors.white70 : Colors.grey,
                          ),
                        ),
                        if (isMe) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.done_all,
                            size: 14,
                            color: Colors.white70,
                          ), // Mock 'Read' status
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitials(String initials) {
    return Center(
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatMessageTime(DateTime createdAt) {
    try {
      return DateFormat('HH:mm').format(createdAt.toLocal());
    } catch (_) {
      return '';
    }
  }
}
