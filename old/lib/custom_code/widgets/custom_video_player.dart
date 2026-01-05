// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//v2
// other custom widgets
// custom actions

import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    super.key,
    this.width,
    this.height,
    required this.videoUrl,
    this.controlsOn,
  });

  final double? width;
  final double? height;
  final String videoUrl;
  final bool? controlsOn;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showOverlay = true;
  double _playbackSpeed = 1.0;
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..addListener(() => _isPlaying.value = _controller.value.isPlaying)
        ..initialize().then((_) async {
          setState(() => _isInitialized = true);
          if (kIsWeb) await _controller.setVolume(0); // mute solo Web
          await _controller.play(); // autoplay
        });
    } catch (e) {
      debugPrint('Video init error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _isPlaying.dispose();
    super.dispose();
  }

  /* ---------- helpers ---------- */

  void _togglePlay() =>
      _controller.value.isPlaying ? _controller.pause() : _controller.play();

  Future<void> _changeSpeed() async {
    final speeds = [0.25, 0.5, 1.0, 1.5, 2.0];
    final sel = await showModalBottomSheet<double>(
      context: context,
      builder: (_) => SafeArea(
        child: ListView(
          children: speeds
              .map((s) => ListTile(
                    title: Text('$s×'),
                    onTap: () => Navigator.pop(context, s),
                  ))
              .toList(),
        ),
      ),
    );
    if (sel != null) {
      await _controller.setPlaybackSpeed(sel);
      setState(() => _playbackSpeed = sel);
    }
  }

  Widget _overlay() => AnimatedOpacity(
        opacity: _showOverlay ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: IgnorePointer(
          ignoring: !_showOverlay,
          child: Container(
            color: Colors.black38,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: FlutterFlowTheme.of(context).primary,
                    bufferedColor: Colors.white54,
                    backgroundColor: Colors.white24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _isPlaying,
                        builder: (_, playing, __) => IconButton(
                          iconSize: 42,
                          color: Colors.white,
                          icon: Icon(
                            playing
                                ? Icons.pause_circle_filled
                                : Icons.play_circle,
                          ),
                          onPressed: _togglePlay,
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: _changeSpeed,
                        child: Text('$_playbackSpeed×'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _muteButton() => Positioned(
        top: 8,
        right: 8,
        child: IconButton(
          icon: Icon(
            _controller.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
            color: Colors.white,
          ),
          onPressed: () async {
            if (_controller.value.volume == 0) {
              await _controller.setVolume(1);
            } else {
              await _controller.setVolume(0);
            }
            setState(() {}); // refresca icono
          },
        ),
      );

  /* ---------- build ---------- */

  @override
  Widget build(BuildContext context) {
    final showCtrls = widget.controlsOn ?? true;

    Widget content = _isInitialized
        ? SizedBox.expand(
            // ocupa todo el espacio del padre
            child: FittedBox(
              fit: BoxFit.cover, // llena y recorta
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary),
            ),
          );

    // Zoom / pan (solo responde si el usuario pellizca)
    content = InteractiveViewer(maxScale: 3, child: content);

    // Stack con controles y botón volumen Web
    content = Stack(
      alignment: Alignment.center,
      children: [
        content,
        if (showCtrls) _overlay(),
        if (kIsWeb) _muteButton(),
      ],
    );

    // Tap para mostrar/ocultar overlay
    if (showCtrls) {
      content = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _showOverlay = !_showOverlay),
        child: content,
      );
    }

    return SizedBox(
      width: widget.width ?? double.infinity,
      child: content,
    );
  }
}
