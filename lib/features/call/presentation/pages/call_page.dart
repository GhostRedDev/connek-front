import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/call_service.dart';

class CallPage extends ConsumerStatefulWidget {
  final String callId;
  final bool isCaller; // True if starting call, False if answering
  final bool isVideo;

  const CallPage({
    super.key,
    required this.callId,
    required this.isCaller,
    this.isVideo = true,
  });

  @override
  ConsumerState<CallPage> createState() => _CallPageState();
}

class _CallPageState extends ConsumerState<CallPage> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  late CallService _callService;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  bool _micMuted = false;
  bool _cameraOff = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    // Initialize Call Service explicitly here for simplicity
    _callService = CallService(
      Supabase.instance.client,
      onOffer: _handleOffer,
      onAnswer: _handleAnswer,
      onIceCandidate: _handleIceCandidate,
      onHangUp: _handleRemoteHangUp, // Handle remote hangup
    );

    _callService.connect(widget.callId);

    await _setupPeerConnection();
  }

  Future<void> _setupPeerConnection() async {
    // STUN Servers (Google's public ones)
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _peerConnection = await createPeerConnection(configuration);

    _peerConnection!.onIceCandidate = (candidate) {
      // Send candidate via signaling
      _callService.sendIceCandidate(widget.callId, {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    _peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };

    // Get User Media
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'},
    };

    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = _localStream;

    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    if (widget.isCaller) {
      await _createOffer();
    }
  }

  Timer? _offerRetryTimer;

  Future<void> _createOffer() async {
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    _sendOfferSignal(offer);

    // Retry Offer every 1s until answered
    _offerRetryTimer?.cancel();
    _offerRetryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_peerConnection == null ||
          _peerConnection!.signalingState ==
              RTCSignalingState.RTCSignalingStateStable) {
        timer.cancel();
      } else {
        print("Retrying Offer...");
        _sendOfferSignal(offer);
      }
    });
  }

  void _sendOfferSignal(RTCSessionDescription offer) {
    _callService.sendOffer(widget.callId, {
      'sdp': offer.sdp,
      'type': offer.type,
    });
  }

  Future<void> _handleOffer(dynamic offerData) async {
    if (widget.isCaller) {
      return; // Caller ignores offers? Or race condition handling needed.
    }

    await _peerConnection!.setRemoteDescription(
      RTCSessionDescription(offerData['sdp'], offerData['type']),
    );

    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _callService.sendAnswer(widget.callId, {
      'sdp': answer.sdp,
      'type': answer.type,
    });
  }

  Future<void> _handleAnswer(dynamic answerData) async {
    await _peerConnection!.setRemoteDescription(
      RTCSessionDescription(answerData['sdp'], answerData['type']),
    );
  }

  Future<void> _handleIceCandidate(dynamic candidateData) async {
    await _peerConnection!.addCandidate(
      RTCIceCandidate(
        candidateData['candidate'],
        candidateData['sdpMid'],
        candidateData['sdpMLineIndex'],
      ),
    );
  }

  void _handleRemoteHangUp() {
    print("Remote user hung up");
    if (mounted) {
      // Cleanup and pop
      _localStream?.dispose();
      _localRenderer.dispose();
      _remoteRenderer.dispose();
      _peerConnection?.dispose();
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Llamada finalizada')));
    }
  }

  void _toggleMic() {
    setState(() {
      _micMuted = !_micMuted;
    });
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = !_micMuted;
    });
  }

  void _toggleCamera() {
    setState(() {
      _cameraOff = !_cameraOff;
    });
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = !_cameraOff;
    });
  }

  void _hangUp() {
    _callService.hangUp(widget.callId);
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _offerRetryTimer?.cancel();

    // Dispose resources strictly here to avoid double-dispose race conditions
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _localStream?.dispose();
    _peerConnection?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote Video (Full Screen)
          Positioned.fill(
            child: RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),

          // Local Video (Small Overlay)
          Positioned(
            right: 20,
            bottom: 140, // Above controls
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 2,
                ), // Azul chiquito
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Inner radius
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: RTCVideoView(
                    _localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ),
          ),

          // Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'mic',
                  backgroundColor: _micMuted ? Colors.white : Colors.white24,
                  onPressed: _toggleMic,
                  child: Icon(
                    _micMuted ? Icons.mic_off : Icons.mic,
                    color: _micMuted ? Colors.black : Colors.white,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'hangup',
                  backgroundColor: Colors.red,
                  onPressed: _hangUp,
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'camera',
                  backgroundColor: _cameraOff ? Colors.white : Colors.white24,
                  onPressed: _toggleCamera,
                  child: Icon(
                    _cameraOff ? Icons.videocam_off : Icons.videocam,
                    color: _cameraOff ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
