import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/marketing_provider.dart';
import '../../services/marketing_ai_service.dart';

/// Marketing AI Chat Page - ChatGPT-style UI with streaming
class MarketingChatPage extends ConsumerStatefulWidget {
  const MarketingChatPage({super.key});

  @override
  ConsumerState<MarketingChatPage> createState() => _MarketingChatPageState();
}

class _MarketingChatPageState extends ConsumerState<MarketingChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _showScrollToBottom = false;

  // Theme State
  ChatTheme? _forcedTheme;

  // Computed Theme
  ChatTheme get _currentTheme =>
      _forcedTheme ??
      (Theme.of(context).brightness == Brightness.dark
          ? kPredefinedThemes[0]
          : kPredefinedThemes[1]);

  @override
  void initState() {
    super.initState();
    // Default to system (null)
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final showButton =
          _scrollController.offset <
          _scrollController.position.maxScrollExtent - 100;
      if (showButton != _showScrollToBottom) {
        setState(() => _showScrollToBottom = showButton);
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Future<void> _sendMessage(String text, {String? contentType}) async {
    if (text.trim().isEmpty) return;

    await ref.read(marketingConversationProvider.notifier).sendMessage(text);
    _scrollToBottom();
  }

  void _sendQuickPrompt(String prompt) {
    _sendMessage(prompt);
  }

  @override
  Widget build(BuildContext context) {
    final marketingState = ref.watch(marketingConversationProvider);
    final marketingAccessAsync = ref.watch(marketingAccessProvider);

    // Auto-scroll when streaming
    if (marketingState.isStreaming) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }

    return Scaffold(
      backgroundColor: _currentTheme.backgroundColor,
      appBar: _buildAppBar(context, _currentTheme),
      body: marketingAccessAsync.when(
        data: (hasAccess) {
          if (!hasAccess) {
            return _buildNoAccessView(context, _currentTheme);
          }

          return Column(
            children: [
              // Messages
              Expanded(
                child:
                    marketingState.messages.isEmpty &&
                        !marketingState.isStreaming
                    ? _buildWelcomeScreen(context, _currentTheme)
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount:
                            marketingState.messages.length +
                            (marketingState.isStreaming ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Show streaming message
                          if (index == marketingState.messages.length) {
                            return _buildStreamingMessage(
                              marketingState.streamingMessage ?? '',
                              _currentTheme,
                            );
                          }

                          final msg = marketingState.messages[index];
                          final isUser = msg['role'] == 'user';
                          final isAudio = msg['type'] == 'audio';

                          return _buildWhatsAppMessage(
                            content: msg['content']!,
                            isUser: isUser,
                            isAudio: isAudio,
                            timestamp: msg['timestamp'] is String
                                ? DateTime.parse(msg['timestamp'])
                                : msg['timestamp'] as DateTime?,
                            theme: _currentTheme,
                            onRegenerate:
                                !isUser &&
                                    index ==
                                        marketingState.messages.length - 1 &&
                                    !marketingState.isStreaming
                                ? () => ref
                                      .read(
                                        marketingConversationProvider.notifier,
                                      )
                                      .regenerateLastResponse()
                                : null,
                            onCopy: !isUser
                                ? () => _copyToClipboard(msg['content']!)
                                : null,
                          );
                        },
                      ),
              ),

              // Error message banner
              if (marketingState.error != null)
                _buildErrorBanner(marketingState.error!, _currentTheme),

              // Input Area (Themed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                color: _currentTheme.inputBarColor,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      color: _currentTheme.iconColor,
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _currentTheme.inputFieldColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: _currentTheme.inputBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                style: TextStyle(
                                  color: _currentTheme.inputTextColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Mensaje',
                                  hintStyle: TextStyle(
                                    color: _currentTheme.hintColor,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                                onSubmitted: (val) {
                                  _sendMessage(val);
                                  _messageController.clear();
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              color: _currentTheme.hintColor,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Send Button (User Bubble Color)
                    GestureDetector(
                      onTap: () {
                        if (_messageController.text.isNotEmpty) {
                          _sendMessage(_messageController.text);
                          _messageController.clear();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentTheme.userBubbleColor,
                          gradient: _currentTheme.userBubbleGradient,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ChatTheme theme) {
    final marketingProfile = MarketingAIService.getMarketingProfile();

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      backgroundColor: theme.appBarColor,
      elevation: 0,
      iconTheme: IconThemeData(color: theme.textColor),
      leadingWidth: 70,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, color: theme.textColor),
            const SizedBox(width: 4),
            CircleAvatar(
              radius: 16,
              backgroundImage: marketingProfile['image'].startsWith('http')
                  ? NetworkImage(marketingProfile['image'])
                  : AssetImage(marketingProfile['image']) as ImageProvider,
              backgroundColor: theme.botBubbleColor,
            ),
          ],
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            marketingProfile['name'],
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textColor,
            ),
          ),
          Text(
            'En línea',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: theme.secondaryTextColor,
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: theme.textColor),
          color: theme.botBubbleColor,
          onSelected: (value) {
            if (value == 'theme') {
              // Show Theme Picker
              showModalBottomSheet(
                context: context,
                backgroundColor: theme.backgroundColor,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Seleccionar Tema',
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // System Default
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.settings_system_daydream,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          'Sistema (Automático)',
                          style: TextStyle(color: theme.textColor),
                        ),
                        trailing: _forcedTheme == null
                            ? Icon(Icons.check, color: theme.iconColor)
                            : null,
                        onTap: () {
                          setState(() => _forcedTheme = null);
                          Navigator.pop(context);
                        },
                      ),
                      ...kPredefinedThemes.map(
                        (t) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: t.userBubbleColor,
                          ),
                          title: Text(
                            t.name,
                            style: TextStyle(color: theme.textColor),
                          ),
                          onTap: () {
                            setState(() => _forcedTheme = t);
                            Navigator.pop(context);
                          },
                          trailing: _forcedTheme?.name == t.name
                              ? Icon(Icons.check, color: theme.iconColor)
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (value == 'clear') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: theme.botBubbleColor,
                  title: Text(
                    'Limpiar conversación',
                    style: TextStyle(color: theme.textColor),
                  ),
                  content: Text(
                    '¿Estás seguro de que quieres borrar toda la conversación?',
                    style: TextStyle(color: theme.secondaryTextColor),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(marketingConversationProvider.notifier)
                            .clearConversation();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Limpiar',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              );
            } else if (value == 'report') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Reporte enviado. Gracias por tu feedback.',
                  ),
                  backgroundColor: theme.userBubbleColor,
                ),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'theme',
              child: Text(
                'Cambiar Tema',
                style: TextStyle(color: theme.textColor),
              ),
            ),
            PopupMenuItem<String>(
              value: 'report',
              child: Text(
                'Notificar errores del bot',
                style: TextStyle(color: theme.textColor),
              ),
            ),
            PopupMenuItem<String>(
              value: 'clear',
              child: Text(
                'Borrar chat',
                style: TextStyle(color: theme.textColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeScreen(BuildContext context, ChatTheme theme) {
    final marketingProfile = MarketingAIService.getMarketingProfile();
    final prompts = MarketingAIService.getSuggestedPrompts();
    final isDark = theme.isDark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // Avatar
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0EA5E9), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0EA5E9).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: marketingProfile['image'].startsWith('http')
                    ? Image.network(
                        marketingProfile['image'],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF0EA5E9),
                                  const Color(0xFF0284C7),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.smart_toy,
                              color: Colors.white,
                              size: 50,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        marketingProfile['image'],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF0EA5E9),
                                  const Color(0xFF0284C7),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.smart_toy,
                              color: Colors.white,
                              size: 50,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Name
          Center(
            child: Text(
              '¡Hola! Soy ${marketingProfile['name']}',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: theme.textColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Center(
            child: Text(
              marketingProfile['description'],
              style: GoogleFonts.inter(
                fontSize: 16,
                color: theme.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          Text(
            'Ejemplos',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          // Prompts
          ...prompts
              .take(3)
              .map(
                (prompt) => _buildQuickPromptCard(
                  prompt['text'],
                  _getIcon(prompt['icon']),
                  isDark,
                ),
              ),
          const SizedBox(height: 32),
          Text(
            'Capacidades',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildCapabilityItem(
            Icons.chat_outlined,
            'Conversaciones naturales',
            'Responde en español de forma fluida',
            isDark,
          ),
          _buildCapabilityItem(
            Icons.campaign_outlined,
            'Estrategias de Marketing',
            'Ayuda con campañas y contenido',
            isDark,
          ),
          _buildCapabilityItem(
            Icons.lightbulb_outline,
            'Ideas Creativas',
            'Generación de ideas para tu negocio',
            isDark,
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'campaign':
        return Icons.campaign_outlined;
      case 'post_add':
        return Icons.post_add_outlined;
      case 'trending_up':
        return Icons.trending_up_outlined;
      case 'email':
        return Icons.email_outlined;
      case 'analytics':
        return Icons.analytics_outlined;
      case 'people':
        return Icons.people_outline;
      default:
        return Icons.chat_bubble_outline;
    }
  }

  Widget _buildQuickPromptCard(String prompt, IconData icon, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _sendQuickPrompt(prompt),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2F2F2F) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF3F3F3F)
                    : const Color(0xFFE5E5E5),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF10A37F), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    prompt,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: isDark
                      ? const Color(0xFF6B6B6B)
                      : const Color(0xFFB4B4B4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCapabilityItem(
    IconData icon,
    String title,
    String description,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF10A37F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF10A37F), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: isDark
                        ? const Color(0xFFB4B4B4)
                        : const Color(0xFF6B6B6B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamingMessage(String content, ChatTheme theme) {
    return _buildWhatsAppMessage(
      content: content,
      isUser: false,
      theme: theme,
      isStreaming: true,
    );
  }

  Widget _buildWhatsAppMessage({
    required String content,
    required bool isUser,
    required ChatTheme theme,
    bool isAudio = false,
    bool isStreaming = false,
    DateTime? timestamp,
    VoidCallback? onRegenerate,
    VoidCallback? onCopy,
  }) {
    final isDark = theme.isDark;
    // Parsing logic for video results (Robust)
    String? videoUrl;
    String displayContent = content;
    final videoMatch = RegExp(
      r'\[\[VIDEO_RESULT:\s*(.*?)\]\]', // Handle spaces
    ).firstMatch(content);
    if (videoMatch != null) {
      videoUrl = videoMatch.group(1)?.trim();
      displayContent = content.replaceAll(videoMatch.group(0)!, '').trim();
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
          gradient: isUser ? theme.userBubbleGradient : null,
          color: isUser
              ? (theme.userBubbleGradient == null
                    ? theme.userBubbleColor
                    : null)
              : theme.botBubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isUser)
                Text(
                  displayContent,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: isUser
                        ? Colors.white
                        : theme
                              .textColor, // User bubbles usually white text if colored
                    height: 1.5,
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarkdownBody(
                      data: displayContent,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.inter(
                          fontSize: 15,
                          height: 1.5,
                          color: theme.textColor,
                        ),
                        code: GoogleFonts.jetBrainsMono(
                          fontSize: 14,
                          backgroundColor: Colors.black26,
                          color: isDark ? const Color(0xFF0EA5E9) : Colors.blue,
                        ),
                        codeblockDecoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (isStreaming) ...[
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.secondaryTextColor,
                        ),
                      ),
                    ],
                  ],
                ),

              // Video
              if (videoUrl != null) ...[
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _VideoMessagePlayer(
                      videoUrl: videoUrl,
                      isDark: theme.isDark,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('HH:mm').format(timestamp ?? DateTime.now()),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: isUser ? Colors.white70 : theme.secondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBanner(String error, ChatTheme theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFFEF4444),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            color: const Color(0xFFEF4444),
            onPressed: () {
              ref.read(marketingConversationProvider.notifier).clearError();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoAccessView(BuildContext context, ChatTheme theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10A37F).withOpacity(0.1),
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 50,
                color: Color(0xFF10A37F),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Marketing Advisor Premium',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.textColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Desbloquea tu asesor de marketing personal',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: theme.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Función de compra próximamente'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                backgroundColor: const Color(0xFF10A37F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Obtener Marketing Advisor',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copiado al portapapeles', style: GoogleFonts.inter()),
        backgroundColor: const Color(0xFF10A37F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Video Player with Controls
class _VideoMessagePlayer extends StatefulWidget {
  final String videoUrl;
  final bool isDark;

  const _VideoMessagePlayer({required this.videoUrl, required this.isDark});

  @override
  State<_VideoMessagePlayer> createState() => _VideoMessagePlayerState();
}

class _VideoMessagePlayerState extends State<_VideoMessagePlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isPlaying = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      debugPrint('Video Player: Loading ${widget.videoUrl}');
      final uri = Uri.parse(widget.videoUrl);
      Map<String, String> headers = {};
      final session = Supabase.instance.client.auth.currentSession;
      if (session?.accessToken != null) {
        headers['Authorization'] = 'Bearer ${session!.accessToken}';
      }

      _controller = VideoPlayerController.networkUrl(uri, httpHeaders: headers);
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
      _controller.addListener(() {
        if (mounted) {
          final isPlaying = _controller.value.isPlaying;
          if (isPlaying != _isPlaying) {
            setState(() => _isPlaying = isPlaying);
          }
        }
      });
    } catch (e) {
      debugPrint('Video Init Error: $e');
      if (mounted) setState(() => _hasError = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _downloadVideo() async {
    final uri = Uri.parse(widget.videoUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openFullscreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenVideoPlayer(controller: _controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, color: Colors.red, size: 30),
            const SizedBox(height: 8),
            Text(
              'Error al cargar video',
              style: TextStyle(
                color: widget.isDark ? Colors.white : Colors.black,
              ),
            ),
            TextButton(
              onPressed: _downloadVideo,
              child: const Text('Abrir externamente'),
            ),
          ],
        ),
      );
    }

    if (!_initialized) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              // Play/Pause Overlay
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: _isPlaying
                      ? null
                      : Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                ),
              ),
              // Bottom Controls
              Positioned(
                bottom: 8,
                right: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download, color: Colors.white),
                      onPressed: _downloadVideo,
                      tooltip: 'Descargar / Abrir',
                    ),
                    IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.white),
                      onPressed: _openFullscreen,
                      tooltip: 'Pantalla completa',
                    ),
                  ],
                ),
              ),
              // Bottom Progress Bar (Simple)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Color(0xFF10A37F),
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.white10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatTheme {
  final String name;
  final Color backgroundColor;
  final Color appBarColor;
  final Color inputBarColor;
  final Color inputFieldColor;
  final Color inputTextColor;
  final Color hintColor;
  final Color botBubbleColor;
  final Color userBubbleColor;
  final Color userBubbleTextColor; // New
  final Color inputBorderColor; // New
  final LinearGradient? userBubbleGradient;
  final Color textColor;
  final Color secondaryTextColor;
  final Color iconColor;
  final bool isDark;

  const ChatTheme({
    required this.name,
    required this.backgroundColor,
    required this.appBarColor,
    required this.inputBarColor,
    required this.inputFieldColor,
    required this.inputTextColor,
    required this.hintColor,
    required this.botBubbleColor,
    required this.userBubbleColor,
    required this.userBubbleTextColor, // New
    required this.inputBorderColor, // New
    this.userBubbleGradient,
    required this.textColor,
    required this.secondaryTextColor,
    required this.iconColor,
    required this.isDark,
  });
}

final List<ChatTheme> kPredefinedThemes = [
  // 1. ShadCN Dark (System Dark Default)
  ChatTheme(
    name: 'ShadCN Dark',
    backgroundColor: const Color(0xFF09090B),
    appBarColor: const Color(0xFF09090B),
    inputBarColor: const Color(0xFF09090B),
    inputFieldColor: const Color(0xFF09090B), // Transparent/Bordered
    inputTextColor: const Color(0xFFFAFAFA),
    hintColor: const Color(0xFFA1A1AA),
    botBubbleColor: const Color(0xFF27272A),
    userBubbleColor: const Color(0xFFFAFAFA), // White for user in Dark
    userBubbleTextColor: Colors.black, // Black text on White bubble
    inputBorderColor: const Color(0xFF27272A),
    userBubbleGradient: null,
    textColor: const Color(0xFFFAFAFA),
    secondaryTextColor: const Color(0xFFA1A1AA),
    iconColor: const Color(0xFFFAFAFA),
    isDark: true,
  ),
  // 2. ShadCN Light (System Light Default)
  ChatTheme(
    name: 'ShadCN Light',
    backgroundColor: const Color(0xFFFFFFFF),
    appBarColor: const Color(0xFFFFFFFF),
    inputBarColor: const Color(0xFFFFFFFF),
    inputFieldColor: const Color(0xFFFFFFFF), // Transparent/Bordered
    inputTextColor: const Color(0xFF09090B),
    hintColor: const Color(0xFF71717A),
    botBubbleColor: const Color(0xFFF4F4F5),
    userBubbleColor: const Color(0xFF18181B), // Black for user in Light
    userBubbleTextColor: Colors.white, // White text on Black bubble
    inputBorderColor: const Color(0xFFE4E4E7),
    userBubbleGradient: null,
    textColor: const Color(0xFF09090B),
    secondaryTextColor: const Color(0xFF52525B),
    iconColor: const Color(0xFF18181B),
    isDark: false,
  ),
  // 3. Cyberpunk
  ChatTheme(
    name: 'Cyberpunk',
    backgroundColor: const Color(0xFF050510),
    appBarColor: const Color(0xFF0F0F2D),
    inputBarColor: const Color(0xFF0F0F2D),
    inputFieldColor: const Color(0xFF1A1A3A),
    inputTextColor: const Color(0xFF00FFCC),
    hintColor: const Color(0xFF008888),
    botBubbleColor: const Color(0xFF1A1A3A),
    userBubbleColor: const Color(0xFF00FFCC),
    userBubbleTextColor: Colors.black,
    inputBorderColor: const Color(0xFF00FFCC),
    userBubbleGradient: const LinearGradient(
      colors: [Color(0xFF00FFCC), Color(0xFF0099FF)],
    ),
    textColor: const Color(0xFFE0E0FF),
    secondaryTextColor: const Color(0xFF8080A0),
    iconColor: const Color(0xFF00FFCC),
    isDark: true,
  ),
  // 4. Sunset
  ChatTheme(
    name: 'Sunset',
    backgroundColor: const Color(0xFF2D1B2E),
    appBarColor: const Color(0xFF4A2C40),
    inputBarColor: const Color(0xFF2D1B2E),
    inputFieldColor: const Color(0xFF4A2C40),
    inputTextColor: const Color(0xFFFFD700),
    hintColor: const Color(0xFFB08C9E),
    botBubbleColor: const Color(0xFF4A2C40),
    userBubbleColor: const Color(0xFFFF5E62),
    userBubbleTextColor: Colors.white,
    inputBorderColor: const Color(0xFFFF9966),
    userBubbleGradient: const LinearGradient(
      colors: [Color(0xFFFF9966), Color(0xFFFF5E62)],
    ),
    textColor: const Color(0xFFFFE0E0),
    secondaryTextColor: const Color(0xFFFFAAAA),
    iconColor: const Color(0xFFFF9966),
    isDark: true,
  ),
];

class _FullScreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;

  const _FullScreenVideoPlayer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: () {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        },
        child: Icon(
          controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
