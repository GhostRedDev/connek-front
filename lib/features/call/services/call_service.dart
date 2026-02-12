import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';

class CallService {
  final SupabaseClient _supabase;
  RealtimeChannel? _signalingChannel;
  RealtimeChannel? _userChannel;

  // Callbacks
  final Function(dynamic) onOffer;
  final Function(dynamic) onAnswer;
  final Function(dynamic) onIceCandidate;
  final Function(Map<String, dynamic>)? onIncomingCall;
  final VoidCallback? onHangUp; // New callback

  CallService(
    this._supabase, {
    required this.onOffer,
    required this.onAnswer,
    required this.onIceCandidate,
    this.onIncomingCall,
    this.onHangUp,
  });

  // 1. Listen for Incoming Calls on my private channel
  void listenToIncomingCalls(int myUserId) {
    if (_userChannel != null) return;

    _userChannel = _supabase.channel('user:$myUserId');
    _userChannel!
        .onBroadcast(
          event: 'incoming_call',
          callback: (payload) {
            if (onIncomingCall != null) {
              onIncomingCall!(payload);
            }
          },
        )
        .subscribe();
  }

  // 2. Start a Call (Notify Receiver first)
  Future<void> startCallNotification(
    int receiverId,
    Map<String, dynamic> callerProfile,
    String callId, {
    bool isVideo = true,
  }) async {
    // We broadcast to the RECEIVER'S channel
    final receiverChannel = _supabase.channel('user:$receiverId');
    receiverChannel.subscribe();

    // Tiny delay to ensure connection?
    await Future.delayed(const Duration(milliseconds: 100));

    // Broadcast to Receiver
    await receiverChannel.sendBroadcastMessage(
      event: 'incoming_call',
      payload: {
        'call_id': callId,
        'caller': {
          ...callerProfile,
          'isVideo': isVideo, // Pass the video state
        },
      },
    );

    // 2b. Log Call in Database (Backend)
    try {
      await ApiService().post(
        '/calls/start',
        body: {
          'id': callId, // Send the ID we generated
          'caller_id': callerProfile['id'],
          'receiver_id': receiverId,
          'caller_type': 'client', // Assuming client-client for now
          'receiver_type': 'client', // Logic might need refinement for Business
        },
      );
    } catch (e) {
      print('Error logging call to DB: $e');
    }

    await _supabase.removeChannel(receiverChannel);
  }

  // 3. Connect to Call Room (Signaling)
  Future<void> connect(String callId) async {
    _signalingChannel = _supabase.channel('call:$callId');
    _signalingChannel!
        .onBroadcast(
          event: 'offer',
          callback: (payload) {
            onOffer(payload);
          },
        )
        .onBroadcast(
          event: 'answer',
          callback: (payload) {
            onAnswer(payload);
          },
        )
        .onBroadcast(
          event: 'candidate',
          callback: (payload) {
            onIceCandidate(payload);
          },
        )
        .onBroadcast(
          event: 'hangup', // Listener for hangup
          callback: (_) {
            if (onHangUp != null) onHangUp!();
          },
        );

    _signalingChannel!.subscribe();
  }

  void sendOffer(String callId, Map<String, dynamic> offer) {
    _signalingChannel?.sendBroadcastMessage(event: 'offer', payload: offer);
  }

  void sendAnswer(String callId, Map<String, dynamic> answer) {
    _signalingChannel?.sendBroadcastMessage(event: 'answer', payload: answer);
  }

  void sendIceCandidate(String callId, Map<String, dynamic> candidate) {
    _signalingChannel?.sendBroadcastMessage(
      event: 'candidate',
      payload: candidate,
    );
  }

  void sendHangUp(String callId) {
    _signalingChannel?.sendBroadcastMessage(event: 'hangup', payload: {});
  }

  void hangUp(String callId) {
    // Broadcast hangup before closing channel
    sendHangUp(callId);

    // Give it a split second to send
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_signalingChannel != null) {
        _supabase.removeChannel(_signalingChannel!);
        _signalingChannel = null;
      }
    });
  }

  void dispose() {
    if (_userChannel != null) _supabase.removeChannel(_userChannel!);
    if (_signalingChannel != null) {
      _supabase.removeChannel(_signalingChannel!);
    }
  }
}
