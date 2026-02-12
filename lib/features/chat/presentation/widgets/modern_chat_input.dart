import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/providers/locale_provider.dart';

/// Modern Chat Input with shadcn-inspired design
/// Supports: Text, Voice, Images, Videos, Documents, Files, Emojis
class ModernChatInput extends ConsumerStatefulWidget {
  final Function(String text, {String? contentType}) onSendMessage;
  final Function(File file, String type) onSendFile;
  final VoidCallback? onTypingStart;
  final VoidCallback? onTypingStop;

  const ModernChatInput({
    super.key,
    required this.onSendMessage,
    required this.onSendFile,
    this.onTypingStart,
    this.onTypingStop,
  });

  @override
  ConsumerState<ModernChatInput> createState() => _ModernChatInputState();
}

class _ModernChatInputState extends ConsumerState<ModernChatInput>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  final FocusNode _focusNode = FocusNode();

  bool _isRecording = false;
  bool _isLocked = false;
  bool _showEmojiPicker = false;
  bool _showAttachmentMenu = false;
  DateTime? _startTime;
  Timer? _timer;
  Timer? _typingTimer;
  String _durationText = "0:00";
  double _dragOffsetY = 0.0;

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});

    // Typing indicator logic
    if (_textController.text.isNotEmpty) {
      widget.onTypingStart?.call();
      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(seconds: 2), () {
        widget.onTypingStop?.call();
      });
    } else {
      widget.onTypingStop?.call();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _typingTimer?.cancel();
    _textController.dispose();
    _audioRecorder.dispose();
    _animController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        String path = '';
        if (!kIsWeb) {
          final dir = await getTemporaryDirectory();
          path =
              '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
        }

        await _audioRecorder.start(const RecordConfig(), path: path);

        setState(() {
          _isRecording = true;
          _startTime = DateTime.now();
          _dragOffsetY = 0.0;
          _isLocked = false;
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
      debugPrint("Error starting record: $e");
    }
  }

  Future<void> _stopRecording({bool cancel = false}) async {
    _timer?.cancel();
    final path = await _audioRecorder.stop();

    if (_isRecording) {
      setState(() {
        _isRecording = false;
        _isLocked = false;
        _durationText = "0:00";
      });

      if (!cancel && path != null) {
        final duration = DateTime.now().difference(_startTime!).inMilliseconds;
        if (duration > 500) {
          final file = File(path);
          widget.onSendFile(file, 'audio');
        }
      }
    }
  }

  void _handleSendText() {
    if (_textController.text.trim().isNotEmpty) {
      widget.onSendMessage(_textController.text.trim());
      _textController.clear();
      widget.onTypingStop?.call();
    }
  }

  Future<void> _pickFile(String type) async {
    setState(() => _showAttachmentMenu = false);

    try {
      if (type == 'image') {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          widget.onSendFile(File(image.path), 'image');
        }
      } else if (type == 'camera') {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          widget.onSendFile(File(image.path), 'image');
        }
      } else if (type == 'video') {
        final picker = ImagePicker();
        final XFile? video = await picker.pickVideo(
          source: ImageSource.gallery,
        );
        if (video != null) {
          widget.onSendFile(File(video.path), 'video');
        }
      } else if (type == 'document') {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'pdf',
            'doc',
            'docx',
            'txt',
            'xlsx',
            'xls',
            'ppt',
            'pptx',
          ],
        );
        if (result != null && result.files.single.path != null) {
          widget.onSendFile(File(result.files.single.path!), 'document');
        }
      } else if (type == 'file') {
        final result = await FilePicker.platform.pickFiles();
        if (result != null && result.files.single.path != null) {
          widget.onSendFile(File(result.files.single.path!), 'file');
        }
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasText = _textController.text.trim().isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF09090B) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Attachment Menu
          if (_showAttachmentMenu) _buildAttachmentMenu(isDark),

          // Main Input Area
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: _isRecording
                ? _buildRecordingUI(isDark)
                : _buildInputUI(isDark, hasText),
          ),
        ],
      ),
    );
  }

  Widget _buildInputUI(bool isDark, bool hasText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Attachment Button
        _buildIconButton(
          icon: Icons.add_circle_outline,
          onTap: () =>
              setState(() => _showAttachmentMenu = !_showAttachmentMenu),
          isDark: isDark,
          tooltip: 'Adjuntar',
        ),
        const SizedBox(width: 8),

        // Text Input
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 120),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF18181B) : const Color(0xFFF4F4F5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF3F3F46)
                    : const Color(0xFFE4E4E7),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    maxLines: null,
                    style: GoogleFonts.inter(
                      color: isDark
                          ? const Color(0xFFFAFAFA)
                          : const Color(0xFF09090B),
                      fontSize: 15,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      hintStyle: GoogleFonts.inter(
                        color: isDark
                            ? const Color(0xFF71717A)
                            : const Color(0xFFA1A1AA),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                // Emoji Button
                IconButton(
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: isDark
                        ? const Color(0xFF71717A)
                        : const Color(0xFF52525B),
                    size: 22,
                  ),
                  onPressed: () {
                    // TODO: Show emoji picker
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Send/Mic Button
        GestureDetector(
          onTap: hasText ? _handleSendText : null,
          onLongPress: hasText ? null : _startRecording,
          onLongPressMoveUpdate: (details) {
            if (_isRecording && !_isLocked) {
              setState(() {
                _dragOffsetY = details.localOffsetFromOrigin.dy;
              });
              if (details.localOffsetFromOrigin.dy < -60) {
                setState(() => _isLocked = true);
              }
              if (details.localOffsetFromOrigin.dx < -100) {
                _stopRecording(cancel: true);
              }
            }
          },
          onLongPressEnd: (details) {
            if (_isRecording && !_isLocked) {
              _stopRecording();
            }
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: hasText
                      ? [const Color(0xFF3B82F6), const Color(0xFF2563EB)]
                      : [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color:
                        (hasText
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF8B5CF6))
                            .withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                hasText ? Icons.send_rounded : Icons.mic,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecordingUI(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF18181B) : const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEF4444), width: 2),
      ),
      child: Row(
        children: [
          if (_isLocked)
            TextButton.icon(
              onPressed: () => _stopRecording(cancel: true),
              icon: const Icon(Icons.close, color: Color(0xFFEF4444), size: 18),
              label: Text(
                'Cancelar',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(width: 8),
          // Recording indicator
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            _durationText,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFFAFAFA) : const Color(0xFF09090B),
            ),
          ),
          const Spacer(),
          if (!_isLocked)
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 12,
                  color: isDark
                      ? const Color(0xFF71717A)
                      : const Color(0xFFA1A1AA),
                ),
                Text(
                  'Desliza para cancelar',
                  style: GoogleFonts.inter(
                    color: isDark
                        ? const Color(0xFF71717A)
                        : const Color(0xFFA1A1AA),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          if (_isLocked)
            IconButton(
              onPressed: _stopRecording,
              icon: const Icon(Icons.send_rounded, color: Color(0xFF3B82F6)),
            ),
        ],
      ),
    );
  }

  Widget _buildAttachmentMenu(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF18181B) : const Color(0xFFF4F4F5),
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7),
          ),
        ),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildAttachmentOption(
            icon: Icons.image_outlined,
            label: 'Imagen',
            color: const Color(0xFF8B5CF6),
            onTap: () => _pickFile('image'),
          ),
          _buildAttachmentOption(
            icon: Icons.camera_alt_outlined,
            label: 'Cámara',
            color: const Color(0xFF3B82F6),
            onTap: () => _pickFile('camera'),
          ),
          _buildAttachmentOption(
            icon: Icons.videocam_outlined,
            label: 'Video',
            color: const Color(0xFFEC4899),
            onTap: () => _pickFile('video'),
          ),
          _buildAttachmentOption(
            icon: Icons.description_outlined,
            label: 'Documento',
            color: const Color(0xFFF59E0B),
            onTap: () => _pickFile('document'),
          ),
          _buildAttachmentOption(
            icon: Icons.insert_drive_file_outlined,
            label: 'Archivo',
            color: const Color(0xFF10B981),
            onTap: () => _pickFile('file'),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    String? tooltip,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        color: isDark ? const Color(0xFF71717A) : const Color(0xFF52525B),
        size: 24,
      ),
      onPressed: onTap,
      tooltip: tooltip,
    );
  }
}
