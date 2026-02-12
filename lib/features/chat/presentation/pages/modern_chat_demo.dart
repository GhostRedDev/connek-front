import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_chat_input.dart';
import '../widgets/modern_message_bubble.dart';

/// Demo page showing the modern chat components
/// This demonstrates how to use ModernChatInput and ModernMessageBubble
class ModernChatDemo extends ConsumerStatefulWidget {
  const ModernChatDemo({super.key});

  @override
  ConsumerState<ModernChatDemo> createState() => _ModernChatDemoState();
}

class _ModernChatDemoState extends ConsumerState<ModernChatDemo> {
  final List<DemoMessage> _messages = [
    DemoMessage(
      content: '¡Hola! 👋 Bienvenido al nuevo chat moderno',
      contentType: 'text',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      senderName: 'Ana García',
      senderAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Ana',
    ),
    DemoMessage(
      content: '¡Wow! Se ve increíble 🎨',
      contentType: 'text',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    DemoMessage(
      content: 'Sí, ahora puedes enviar **markdown**, `código`, y mucho más!',
      contentType: 'text',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      senderName: 'Ana García',
      senderAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Ana',
    ),
    DemoMessage(
      content: 'También puedes enviar imágenes, videos, documentos y audios',
      contentType: 'text',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      senderName: 'Ana García',
      senderAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Ana',
      reactions: ['❤️', '👍'],
    ),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSendMessage(String text, {String? contentType}) {
    setState(() {
      _messages.add(
        DemoMessage(
          content: text,
          contentType: contentType ?? 'text',
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    // Simulate response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(
            DemoMessage(
              content: '¡Mensaje recibido! 📨',
              contentType: 'text',
              isMe: false,
              timestamp: DateTime.now(),
              senderName: 'Ana García',
              senderAvatar:
                  'https://api.dicebear.com/7.x/avataaars/svg?seed=Ana',
            ),
          );
        });
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });
  }

  void _handleSendFile(File file, String type) {
    final fileName = file.path.split('/').last;

    setState(() {
      _messages.add(
        DemoMessage(
          content: file.path,
          contentType: type,
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Archivo enviado: $fileName'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF09090B) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF09090B) : Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
                ),
              ),
              child: Center(
                child: Text(
                  'AG',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ana García',
                  style: GoogleFonts.inter(
                    color: isDark
                        ? const Color(0xFFFAFAFA)
                        : const Color(0xFF09090B),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'En línea',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call_outlined,
              color: isDark ? const Color(0xFF71717A) : const Color(0xFF52525B),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.videocam_outlined,
              color: isDark ? const Color(0xFF71717A) : const Color(0xFF52525B),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? const Color(0xFF71717A) : const Color(0xFF52525B),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ModernMessageBubble(
                  content: message.content,
                  contentType: message.contentType,
                  isMe: message.isMe,
                  timestamp: message.timestamp,
                  senderName: message.senderName,
                  senderAvatar: message.senderAvatar,
                  showAvatar: true,
                  isRead: true,
                  reactions: message.reactions,
                  onReact: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reaccionar - Próximamente'),
                      ),
                    );
                  },
                  onReply: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Responder - Próximamente')),
                    );
                  },
                  onForward: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reenviar - Próximamente')),
                    );
                  },
                  onDelete: message.isMe
                      ? () {
                          setState(() {
                            _messages.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mensaje eliminado')),
                          );
                        }
                      : null,
                );
              },
            ),
          ),

          // Input
          ModernChatInput(
            onSendMessage: _handleSendMessage,
            onSendFile: _handleSendFile,
            onTypingStart: () {
              debugPrint('Usuario está escribiendo...');
            },
            onTypingStop: () {
              debugPrint('Usuario dejó de escribir');
            },
          ),
        ],
      ),
    );
  }
}

class DemoMessage {
  final String content;
  final String contentType;
  final bool isMe;
  final DateTime timestamp;
  final String? senderName;
  final String? senderAvatar;
  final List<String>? reactions;

  DemoMessage({
    required this.content,
    required this.contentType,
    required this.isMe,
    required this.timestamp,
    this.senderName,
    this.senderAvatar,
    this.reactions,
  });
}
