import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// Modern Message Bubble with shadcn-inspired design
/// Supports: Text, Images, Videos, Audio, Documents, Files
class ModernMessageBubble extends StatefulWidget {
  final String content;
  final String contentType;
  final bool isMe;
  final DateTime timestamp;
  final String? senderName;
  final String? senderAvatar;
  final bool showAvatar;
  final bool isRead;
  final List<String>? reactions;
  final VoidCallback? onReact;
  final VoidCallback? onReply;
  final VoidCallback? onForward;
  final VoidCallback? onDelete;

  const ModernMessageBubble({
    super.key,
    required this.content,
    this.contentType = 'text',
    required this.isMe,
    required this.timestamp,
    this.senderName,
    this.senderAvatar,
    this.showAvatar = true,
    this.isRead = false,
    this.reactions,
    this.onReact,
    this.onReply,
    this.onForward,
    this.onDelete,
  });

  @override
  State<ModernMessageBubble> createState() => _ModernMessageBubbleState();
}

class _ModernMessageBubbleState extends State<ModernMessageBubble> {
  bool _showActions = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onLongPress: () => setState(() => _showActions = !_showActions),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: widget.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: widget.isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Avatar for other users
                if (!widget.isMe && widget.showAvatar) ...[
                  _buildAvatar(),
                  const SizedBox(width: 8),
                ],

                // Message content
                Flexible(
                  child: Column(
                    crossAxisAlignment: widget.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      // Sender name (for group chats)
                      if (!widget.isMe && widget.senderName != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 4),
                          child: Text(
                            widget.senderName!,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? const Color(0xFFA1A1AA)
                                  : const Color(0xFF71717A),
                            ),
                          ),
                        ),

                      // Message bubble
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          gradient: widget.isMe
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF3B82F6),
                                    Color(0xFF2563EB),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                          color: widget.isMe
                              ? null
                              : (isDark
                                    ? const Color(0xFF18181B)
                                    : const Color(0xFFF4F4F5)),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: widget.isMe
                                ? const Radius.circular(16)
                                : const Radius.circular(4),
                            bottomRight: widget.isMe
                                ? const Radius.circular(4)
                                : const Radius.circular(16),
                          ),
                          border: widget.isMe
                              ? null
                              : Border.all(
                                  color: isDark
                                      ? const Color(0xFF27272A)
                                      : const Color(0xFFE4E4E7),
                                  width: 1,
                                ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (widget.isMe
                                          ? const Color(0xFF3B82F6)
                                          : Colors.black)
                                      .withOpacity(widget.isMe ? 0.15 : 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: widget.isMe
                                ? const Radius.circular(16)
                                : const Radius.circular(4),
                            bottomRight: widget.isMe
                                ? const Radius.circular(4)
                                : const Radius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildMessageContent(isDark),
                              _buildMessageFooter(isDark),
                            ],
                          ),
                        ),
                      ),

                      // Reactions
                      if (widget.reactions != null &&
                          widget.reactions!.isNotEmpty)
                        _buildReactions(),
                    ],
                  ),
                ),

                // Avatar for current user (optional)
                if (widget.isMe && widget.showAvatar) ...[
                  const SizedBox(width: 8),
                  _buildAvatar(),
                ],
              ],
            ),

            // Action buttons
            if (_showActions) _buildActionButtons(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final initials = widget.senderName != null && widget.senderName!.isNotEmpty
        ? widget.senderName![0].toUpperCase()
        : '?';

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: widget.isMe
              ? [const Color(0xFF3B82F6), const Color(0xFF2563EB)]
              : [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
        ),
      ),
      child: widget.senderAvatar != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.senderAvatar!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                initials,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }

  Widget _buildMessageContent(bool isDark) {
    switch (widget.contentType) {
      case 'image':
        return _buildImageContent();
      case 'video':
        return _buildVideoContent();
      case 'audio':
        return _buildAudioContent(isDark);
      case 'document':
      case 'file':
        return _buildFileContent(isDark);
      default:
        return _buildTextContent(isDark);
    }
  }

  Widget _buildTextContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      child: MarkdownBody(
        data: widget.content,
        styleSheet: MarkdownStyleSheet(
          p: GoogleFonts.inter(
            fontSize: 15,
            height: 1.5,
            color: widget.isMe
                ? Colors.white
                : (isDark ? const Color(0xFFFAFAFA) : const Color(0xFF09090B)),
          ),
          code: GoogleFonts.jetBrainsMono(
            fontSize: 14,
            backgroundColor: widget.isMe
                ? Colors.white.withOpacity(0.1)
                : (isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7)),
          ),
        ),
      ),
    );
  }

  Widget _buildImageContent() {
    return CachedNetworkImage(
      imageUrl: widget.content,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 200,
        color: Colors.grey[800],
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        height: 200,
        color: Colors.grey[800],
        child: const Icon(Icons.broken_image, size: 48, color: Colors.white54),
      ),
    );
  }

  Widget _buildVideoContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          color: Colors.black,
          child: const Center(
            child: Icon(
              Icons.play_circle_outline,
              size: 64,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Video',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.isMe
                  ? Colors.white.withOpacity(0.2)
                  : (isDark
                        ? const Color(0xFF27272A)
                        : const Color(0xFFE4E4E7)),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow,
              color: widget.isMe
                  ? Colors.white
                  : (isDark
                        ? const Color(0xFFFAFAFA)
                        : const Color(0xFF09090B)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Audio waveform placeholder
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: widget.isMe
                        ? Colors.white.withOpacity(0.2)
                        : (isDark
                              ? const Color(0xFF27272A)
                              : const Color(0xFFE4E4E7)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(
                        widget.isMe ? Colors.white : const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '0:45',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: widget.isMe
                        ? Colors.white70
                        : (isDark
                              ? const Color(0xFFA1A1AA)
                              : const Color(0xFF71717A)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileContent(bool isDark) {
    final fileName = widget.content.split('/').last;
    final extension = fileName.split('.').last.toUpperCase();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: widget.isMe
                  ? Colors.white.withOpacity(0.2)
                  : (isDark
                        ? const Color(0xFF27272A)
                        : const Color(0xFFE4E4E7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                extension,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: widget.isMe ? Colors.white : const Color(0xFF3B82F6),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.isMe
                        ? Colors.white
                        : (isDark
                              ? const Color(0xFFFAFAFA)
                              : const Color(0xFF09090B)),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Documento',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: widget.isMe
                        ? Colors.white70
                        : (isDark
                              ? const Color(0xFFA1A1AA)
                              : const Color(0xFF71717A)),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.download_outlined,
            color: widget.isMe
                ? Colors.white
                : (isDark ? const Color(0xFFFAFAFA) : const Color(0xFF09090B)),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageFooter(bool isDark) {
    final timeStr = DateFormat('HH:mm').format(widget.timestamp);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            timeStr,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: widget.isMe
                  ? Colors.white70
                  : (isDark
                        ? const Color(0xFFA1A1AA)
                        : const Color(0xFF71717A)),
            ),
          ),
          if (widget.isMe) ...[
            const SizedBox(width: 4),
            Icon(
              widget.isRead ? Icons.done_all : Icons.done,
              size: 14,
              color: widget.isRead ? const Color(0xFF3B82F6) : Colors.white70,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReactions() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF18181B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF27272A)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.reactions!
              .map(
                (reaction) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(reaction, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            icon: Icons.add_reaction_outlined,
            label: 'Reaccionar',
            onTap: widget.onReact,
            isDark: isDark,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: Icons.reply_outlined,
            label: 'Responder',
            onTap: widget.onReply,
            isDark: isDark,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: Icons.forward_outlined,
            label: 'Reenviar',
            onTap: widget.onForward,
            isDark: isDark,
          ),
          if (widget.isMe) ...[
            const SizedBox(width: 8),
            _buildActionButton(
              icon: Icons.delete_outline,
              label: 'Eliminar',
              onTap: widget.onDelete,
              isDark: isDark,
              color: const Color(0xFFEF4444),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    required bool isDark,
    Color? color,
  }) {
    final buttonColor =
        color ?? (isDark ? const Color(0xFF71717A) : const Color(0xFF52525B));

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF18181B) : const Color(0xFFF4F4F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: buttonColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
