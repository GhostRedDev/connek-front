import 'dart:async';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/providers/locale_provider.dart';

class ChatInputArea extends ConsumerStatefulWidget {
  final Function(String) onSendText;
  final Function(String path, int duration) onSendAudio;
  final VoidCallback onAttachmentPress;
  final VoidCallback onCameraPress;

  const ChatInputArea({
    super.key,
    required this.onSendText,
    required this.onSendAudio,
    required this.onAttachmentPress,
    required this.onCameraPress,
  });

  @override
  ConsumerState<ChatInputArea> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends ConsumerState<ChatInputArea>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isRecording = false;
  bool _isLocked = false;
  DateTime? _startTime;
  Timer? _timer;
  String _durationText = "0:00";
  double _dragOffset = 0.0;
  double _dragOffsetY = 0.0;

  // Animation controller for mic pulsing
  late AnimationController _micAnimController;

  @override
  void initState() {
    super.initState();
    _micAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textController.dispose();
    _audioRecorder.dispose();
    _micAnimController.dispose();
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
          _dragOffset = 0.0;
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
      print("Error starting record: $e");
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
        // Don't send if too short (< 500ms)
        if (duration > 500) {
          widget.onSendAudio(path, duration);
        }
      }
    }
  }

  void _handleSendText() {
    if (_textController.text.trim().isNotEmpty) {
      widget.onSendText(_textController.text.trim());
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasText = _textController.text.trim().isNotEmpty;
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: isDark ? const Color(0xFF131619) : Colors.white,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Normal Input View
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isRecording ? 0.0 : 1.0,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                  onPressed: widget.onAttachmentPress,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1E1E)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black12,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            maxLines: 5,
                            minLines: 1,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: t['chat_input_hint'] ?? 'Message',
                              hintStyle: TextStyle(
                                color: isDark ? Colors.white38 : Colors.black38,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                        if (!hasText)
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                            onPressed: widget.onCameraPress,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Mic / Send Button
                GestureDetector(
                  onTap: () {
                    if (_isLocked) {
                      _stopRecording();
                    } else if (hasText) {
                      _handleSendText();
                    }
                  },
                  onLongPress: hasText ? null : _startRecording,
                  onLongPressMoveUpdate: (details) {
                    if (_isRecording && !_isLocked) {
                      setState(() {
                        _dragOffset += details.localOffsetFromOrigin.dx;
                        _dragOffsetY = details.localOffsetFromOrigin.dy;
                      });
                      // Unlock slide left
                      if (details.localOffsetFromOrigin.dx < -100) {
                        _stopRecording(cancel: true);
                      }
                      // Lock slide up
                      if (details.localOffsetFromOrigin.dy < -60) {
                        setState(() {
                          _isLocked = true;
                          _dragOffsetY = 0; // Reset position
                        });
                      }
                    }
                  },
                  onLongPressEnd: (details) {
                    if (_isRecording && !_isLocked) {
                      _stopRecording();
                    }
                  },
                  onLongPressCancel: () {
                    if (_isRecording && !_isLocked) {
                      _stopRecording(cancel: true);
                    }
                  },
                  child: Transform.translate(
                    offset: Offset(0, _isLocked ? 0 : _dragOffsetY),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _isLocked ? Colors.red : const Color(0xFF4285F4),
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (_isRecording)
                            BoxShadow(
                              color:
                                  (_isLocked
                                          ? Colors.red
                                          : const Color(0xFF4285F4))
                                      .withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: Icon(
                        _isLocked
                            ? Icons.send
                            : (hasText ? Icons.send : Icons.mic),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recording View Overlay
          if (_isRecording)
            Positioned.fill(
              child: Container(
                color: isDark ? const Color(0xFF131619) : Colors.white,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    // Cancel Button (Locked Mode)
                    if (_isLocked)
                      TextButton(
                        onPressed: () => _stopRecording(cancel: true),
                        child: Text(
                          t['cancel'] ?? 'Cancel',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    // Blinking Red Dot
                    FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: const Icon(
                        Icons.fiber_manual_record,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Timer
                    Text(
                      _durationText,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),

                    // Slide to Cancel Text
                    FadeInRight(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 12,
                            color: Colors.grey,
                          ),
                          Text(
                            (t['chat_slide_cancel'] ?? 'Desliza para cancelar'),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // The Mic Button (Visual Anchor) - Hidden during overlay but tracked by gesture
                    // We can add a "Lock" icon hint if not locked
                    if (!_isLocked)
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 60),
                        child: FadeInUp(
                          child: const Icon(
                            Icons.lock_open,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
