import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animate_do/animate_do.dart';

import '../providers/chat_provider.dart';
import '../../../call/services/call_service.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../social/user_profile_page.dart';
import '../../../social/models/contact_model.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId; // Conversation ID
  final bool isEmbedded; // For Split View

  const ChatPage({super.key, required this.chatId, this.isEmbedded = false});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final _supabase = Supabase.instance.client;
  int _myClientId = 0;
  int _myBusinessId = 0;

  @override
  void initState() {
    super.initState();
    _fetchMyIds();
  }

  Future<void> _fetchMyIds() async {
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

        final busRes = await _supabase
            .from('business')
            .select('id')
            .eq('owner_user', user.id)
            .maybeSingle();

        if (busRes != null && mounted) {
          setState(() {
            _myBusinessId = busRes['id'];
          });
        }
      }
    } catch (e) {
      print('Error fetching my IDs: $e');
    }
  }

  @override
  void dispose() {
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
              'Subiendo...',
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
                  'Falló la subida',
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
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAttachmentOption(
                Icons.image,
                'Galería',
                'image',
                Colors.white,
              ),
              _buildAttachmentOption(
                Icons.videocam,
                'Video',
                'video',
                Colors.white,
              ),
              _buildAttachmentOption(
                Icons.camera_alt,
                'Cámara',
                'camera',
                Colors.white,
              ),
              _buildAttachmentOption(
                Icons.insert_drive_file,
                'Documento',
                'file',
                Colors.white,
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Funcionalidad próximamente.')),
          );
        } else {
          _handleAttachment(type);
        }
      },
    );
  }

  Future<void> _initiateCall(
    Map<String, dynamic>? contactInfo, {
    bool isVideo = true,
  }) async {
    if (contactInfo == null) return;
    final receiverId = contactInfo['id'];
    if (receiverId == null) return;

    if (receiverId == _myClientId || receiverId == _myBusinessId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No puedes llamarte a ti mismo')),
      );
      return;
    }

    String myName = 'Usuario';
    String? myImage;
    int myId = _myClientId;

    try {
      if (_myClientId != 0) {
        final res = await _supabase
            .from('client')
            .select('first_name, last_name, profile_url, photo_id')
            .eq('id', _myClientId)
            .single();
        final fName = res['first_name'] ?? '';
        final lName = res['last_name'] ?? '';
        myName = '$fName $lName'.trim();
        if (myName.isEmpty) myName = 'Usuario';
        if (res['photo_id'] != null &&
            res['photo_id'].toString().startsWith('http')) {
          myImage = res['photo_id'];
        }
      }
    } catch (e) {
      print('Error fetching my profile for call: $e');
    }

    final callId = DateTime.now().millisecondsSinceEpoch.toString();

    if (mounted) {
      context.push('/call/$callId?isCaller=true&isVideo=$isVideo');
    }

    try {
      final callService = CallService(
        _supabase,
        onOffer: (_) {},
        onAnswer: (_) {},
        onIceCandidate: (_) {},
      );

      await callService.startCallNotification(
        receiverId,
        {'name': myName, 'image': myImage, 'id': myId},
        callId,
        isVideo: isVideo,
      );
    } catch (e) {
      print('Error notifying call: $e');
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Send helpers
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    try {
      final int conversationId = int.tryParse(widget.chatId) ?? 0;
      await ref.read(chatProvider.notifier).sendMessage(conversationId, text);
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error enviando mensaje: $e')));
    }
  }

  Future<void> _sendAudio(String path, int duration) async {
    final file = XFile(path);
    _uploadAndSend(file, 'audio');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final int conversationId = int.tryParse(widget.chatId) ?? 0;

    final chatsAsync = ref.watch(chatProvider);
    Map<String, dynamic>? contactInfo;

    final chats = chatsAsync.asData?.value ?? [];
    if (chats.isNotEmpty) {
      final chat = chats.firstWhere(
        (c) => c.id == conversationId,
        orElse: () =>
            ChatConversation(id: 0, contact: {}, createdAt: DateTime.now()),
      );
      if (chat.id != 0) {
        contactInfo = chat.contact;
      }
    }

    final contactName = contactInfo?['name'] ?? 'Cargando...';
    final contactImage = contactInfo?['image'];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        surfaceTintColor: bgColor,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        leading: widget.isEmbedded
            ? null
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () => context.pop(),
              ),
        title: GestureDetector(
          onTap: () async {
            if (contactInfo != null) {
              if (contactInfo['is_business'] == true) {
                // Navigate to Business Profile
                context.push('/client/business/${contactInfo['id']}');
              } else {
                // Navigate to Client Profile
                try {
                  final contactId = contactInfo['id'];
                  if (contactId != null) {
                    final res = await _supabase
                        .from('client')
                        .select()
                        .eq('id', contactId)
                        .maybeSingle();

                    if (res != null) {
                      final contact = ContactDetails.fromJson(res);
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserProfilePage(
                              contact: contact,
                              userId: contactId,
                            ),
                          ),
                        );
                      }
                    } else {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserProfilePage(userId: contactId),
                          ),
                        );
                      }
                    }
                  }
                } catch (e) {
                  print('Error navigating to profile: $e');
                }
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage:
                    contactImage != null &&
                        contactImage.isNotEmpty &&
                        (contactImage.startsWith('http') ||
                            contactImage.startsWith('https'))
                    ? CachedNetworkImageProvider(contactImage)
                    : null,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                child:
                    contactImage == null ||
                        contactImage.isEmpty ||
                        (!contactImage.startsWith('http') &&
                            !contactImage.startsWith('https'))
                    ? Icon(
                        Icons.person,
                        size: 16,
                        color: isDark ? Colors.white : Colors.black54,
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  contactName,
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.phone_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => _initiateCall(contactInfo, isVideo: false),
          ),
          IconButton(
            icon: Icon(
              Icons.videocam_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => _initiateCall(contactInfo, isVideo: true),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.white : Colors.black,
            ),
            color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
            onSelected: (value) {
              if (value == 'block') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Usuario bloqueado')),
                );
              } else if (value == 'view_profile') {
                // View Profile
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'view_profile',
                  child: Text(
                    'Ver perfil',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'block',
                  child: Text(
                    'Bloquear',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                PopupMenuItem(
                  value: 'report',
                  child: Text(
                    'Reportar',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ];
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: ref
                  .read(chatProvider.notifier)
                  .getMessagesStream(conversationId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error', style: TextStyle(color: Colors.red)),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data ?? [];
                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay mensajes',
                      style: TextStyle(
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final bool isMe =
                        (msg.sender == _myClientId ||
                        msg.sender == _myBusinessId);

                    return _buildMessage(
                      msg,
                      isMe,
                      context,
                      contactImage: contactImage,
                      contactName: contactName,
                      isDark: isDark, // Pass isDark
                    );
                  },
                );
              },
            ),
          ),
          // New Instagram-style Input
          _InstagramInputArea(
            onSendText: _sendMessage,
            onSendAudio: _sendAudio,
            onAttachmentPress: _showAttachmentMenu,
            onCameraPress: () => _handleAttachment('camera'),
            onGalleryPress: () => _handleAttachment('image'),
            isDark: isDark, // Pass Theme
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(
    ChatMessage msg,
    bool isMe,
    BuildContext context, {
    String? contactImage,
    String? contactName,
    required bool isDark,
  }) {
    final time = _formatMessageTime(msg.createdAt);

    // Initial logic
    String initials = '?';
    if (!isMe && contactName != null && contactName.isNotEmpty) {
      initials = contactName[0].toUpperCase();
    }

    final avatar = CircleAvatar(
      radius: 14,
      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
      backgroundImage:
          (!isMe && contactImage != null && contactImage.contains('http'))
          ? CachedNetworkImageProvider(contactImage)
          : null,
      child: (!isMe && (contactImage == null || !contactImage.contains('http')))
          ? Text(
              initials,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black54,
                fontSize: 10,
              ),
            )
          : null,
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 2),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end, // Avatar at bottom
          children: [
            if (!isMe) ...[avatar, const SizedBox(width: 8)],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? const LinearGradient(
                          colors: [
                            Color(0xFF8B5CF6),
                            Color(0xFF3B82F6),
                          ], // Purple to Blue
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isMe
                      ? null
                      : (isDark
                            ? const Color(0xFF262626)
                            : Colors.grey[200]), // Dynamic Cloud Color
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildMessageContent(msg, isMe, isDark)],
                ),
              ),
            ),
          ],
        ),
      ),
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

  String _formatMessageTime(DateTime createdAt) {
    try {
      return DateFormat('HH:mm').format(createdAt.toLocal());
    } catch (_) {
      return '';
    }
  }
}

class _InstagramInputArea extends StatefulWidget {
  final Function(String) onSendText;
  final Function(String path, int duration) onSendAudio;
  final VoidCallback onAttachmentPress;
  final VoidCallback onCameraPress;
  final VoidCallback onGalleryPress;
  final bool isDark;

  const _InstagramInputArea({
    required this.onSendText,
    required this.onSendAudio,
    required this.onAttachmentPress,
    required this.onCameraPress,
    required this.onGalleryPress,
    required this.isDark,
  });

  @override
  State<_InstagramInputArea> createState() => _InstagramInputAreaState();
}

class _InstagramInputAreaState extends State<_InstagramInputArea>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();

  // Recording State
  bool _isRecording = false;
  DateTime? _startTime;
  Timer? _timer;
  String _durationText = "0:00";

  @override
  void initState() {
    super.initState();
    _textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textController.dispose();
    _audioRecorder.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final dir = await getTemporaryDirectory();
        final path =
            '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(const RecordConfig(), path: path);

        setState(() {
          _isRecording = true;
          _startTime = DateTime.now();
        });

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final duration = DateTime.now().difference(_startTime!);
          final minutes = duration.inMinutes.toString().padLeft(1, '0');
          final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
          setState(() {
            _durationText = "$minutes:$seconds";
          });
        });
      }
    } catch (e) {
      debugPrint("Error recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    final path = await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
      _durationText = "0:00";
    });

    if (path != null) {
      final duration = DateTime.now().difference(_startTime!).inMilliseconds;
      if (duration > 500) {
        widget.onSendAudio(path, duration);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isRecording) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: widget.isDark ? Colors.black : Colors.white,
        child: Row(
          children: [
            const Icon(Icons.fiber_manual_record, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              _durationText,
              style: TextStyle(
                color: widget.isDark ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                _audioRecorder.stop();
                _timer?.cancel();
                setState(() {
                  _isRecording = false;
                  _durationText = "0:00";
                });
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _stopRecording,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4285F4),
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      );
    }

    final hasText = _textController.text.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: widget.isDark
          ? Colors
                .black // Dark BG
          : Colors.white, // Light BG
      child: Row(
        children: [
          // Camera Button (Blue Circle)
          GestureDetector(
            onTap: widget.onCameraPress,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0095F6), // Instagram Blue
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Pill Input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.isDark
                    ? const Color(0xFF262626)
                    : Colors.grey[200], // Dynamic Input BG
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: TextStyle(
                        color: widget.isDark ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(
                          color: widget.isDark ? Colors.grey : Colors.grey[600],
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (val) {
                        if (val.trim().isNotEmpty) {
                          widget.onSendText(val.trim());
                          _textController.clear();
                        }
                      },
                    ),
                  ),
                  if (hasText) ...[
                    TextButton(
                      onPressed: () {
                        widget.onSendText(_textController.text.trim());
                        _textController.clear();
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ] else ...[
                    IconButton(
                      icon: Icon(
                        Icons.mic_none,
                        color: widget.isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: _startRecording,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.image_outlined,
                        color: widget.isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: widget.onGalleryPress,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.mood,
                        color: widget.isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: widget.onAttachmentPress,
                    ),
                  ],
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
