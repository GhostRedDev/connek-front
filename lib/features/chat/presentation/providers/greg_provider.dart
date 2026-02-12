import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/greg_ai_service.dart';
import '../../../business/presentation/providers/business_provider.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for Greg AI Service
final gregAIServiceProvider = Provider<GregAIService>((ref) {
  return GregAIService();
});

/// Provider to get current Client ID
final currentClientIdProvider = FutureProvider.autoDispose<int?>((ref) async {
  try {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user != null) {
      final clientRes = await supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();

      if (clientRes != null) {
        return clientRes['id'] as int;
      }
    }
  } catch (e) {
    print('⚠️ Greg: Error getting client ID: $e');
  }
  return null;
});

/// Provider to get current business ID (NOT client ID)
final currentBusinessIdProvider = FutureProvider.autoDispose<int?>((ref) async {
  try {
    final clientId = await ref.watch(currentClientIdProvider.future);

    if (clientId != null) {
      // 2. Get business_id
      final businessRepo = ref.read(businessRepositoryProvider);
      final businessData = await businessRepo.getMyBusiness(clientId);

      if (businessData != null) {
        final businessId = businessData['id'] as int;
        print('✅ Greg Business ID Found: $businessId');
        return businessId;
      }
    }
  } catch (e) {
    print('⚠️ Greg: General Error getting business info: $e');
  }

  // Fallback for Demo Mode
  print('⚠️ Greg: Using Fallback Business ID = 1 (Demo Mode)');
  return 1;
});

/// Provider to check if current user has access to Greg
final gregAccessProvider = FutureProvider.autoDispose<bool>((ref) async {
  final businessId = await ref.watch(currentBusinessIdProvider.future);

  if (businessId == null) {
    print('⚠️ No business ID found - denying Greg access');
    return false;
  }

  return await GregAIService.checkUserHasAccess(businessId);
});

/// State for Greg conversation
class GregConversationState {
  final List<Map<String, dynamic>> messages;
  final bool isLoading;
  final String? error;
  final String? streamingMessage;
  final bool isStreaming;
  final int? businessId;
  final int? clientId; // Sender ID

  GregConversationState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.streamingMessage,
    this.isStreaming = false,
    this.businessId,
    this.clientId,
  });

  GregConversationState copyWith({
    List<Map<String, dynamic>>? messages,
    bool? isLoading,
    String? error,
    String? streamingMessage,
    bool? isStreaming,
    int? businessId,
    int? clientId,
    bool clearError = false,
    bool clearStreaming = false,
  }) {
    return GregConversationState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      streamingMessage: clearStreaming
          ? null
          : (streamingMessage ?? this.streamingMessage),
      isStreaming: isStreaming ?? this.isStreaming,
      businessId: businessId ?? this.businessId,
      clientId: clientId ?? this.clientId,
    );
  }
}

/// Notifier for managing Greg conversation
class GregConversationNotifier extends StateNotifier<GregConversationState> {
  final GregAIService _gregService;
  final Ref _ref;
  StreamSubscription? _streamSubscription;

  GregConversationNotifier(this._gregService, this._ref)
    : super(GregConversationState()) {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMessages = prefs.getString('greg_chat_history');

      if (savedMessages != null) {
        final List<dynamic> decoded = jsonDecode(savedMessages);
        final messages = decoded.map((m) {
          final map = Map<String, dynamic>.from(m);
          // Ensure timestamp is DateTime
          if (map['timestamp'] is String) {
            map['timestamp'] = DateTime.tryParse(map['timestamp'] as String);
          }
          return map;
        }).toList();
        state = state.copyWith(messages: messages);
        print('✅ Greg: Load ${messages.length} messages from history');
      }
    } catch (e) {
      print('❌ Greg: Error loading history: $e');
    }
  }

  Future<void> _saveMessages(List<Map<String, dynamic>> messages) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final messagesToSave = messages.map((m) {
        final newMap = Map<String, dynamic>.from(m);
        if (newMap['timestamp'] is DateTime) {
          newMap['timestamp'] = (newMap['timestamp'] as DateTime)
              .toIso8601String();
        }
        return newMap;
      }).toList();

      await prefs.setString('greg_chat_history', jsonEncode(messagesToSave));
    } catch (e) {
      print('❌ Greg: Error saving history: $e');
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _ensureIds() async {
    try {
      final businessId = await _ref.read(currentBusinessIdProvider.future);
      final clientId = await _ref.read(currentClientIdProvider.future);

      state = state.copyWith(businessId: businessId, clientId: clientId);
    } catch (e) {
      print('Error getting IDs: $e');
    }
  }

  /// Send a text message to Greg
  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    await _ensureIds();

    // We need at least clientId (sender)
    // BusinessId is less critical if we assume self-chat
    if (state.clientId == null) {
      state = state.copyWith(error: "No se pudo identificar tu usuario.");
      return;
    }

    // Cancel any ongoing stream
    await _streamSubscription?.cancel();

    // Add user message to conversation
    final updatedMessages = [
      ...state.messages,
      {
        'role': 'user',
        'content': userMessage,
        'type': 'text',
        'timestamp': DateTime.now(),
      },
    ];

    state = state.copyWith(
      messages: updatedMessages,
      isLoading: true,
      isStreaming: true, // We simulate streaming
      clearError: true,
      clearStreaming: true,
    );

    try {
      print('💬 Greg: Sending message. Sender=${state.clientId}');

      // Stream the response (Fake stream from poller)
      final stream = _gregService.sendMessageStream(
        userMessage,
        state.clientId!, // Sender
        state.clientId!, // Receiver (Self-chat for assistant)
        businessId: state.businessId ?? 1,
      );

      String fullResponse = '';

      _streamSubscription = stream.listen(
        (partialResponse) {
          fullResponse = partialResponse;

          // Update streaming message
          state = state.copyWith(
            streamingMessage: partialResponse,
            isLoading: false,
          );
        },
        onDone: () {
          // Streaming complete - add final message
          state = state.copyWith(
            messages: [
              ...updatedMessages,
              {
                'role': 'assistant',
                'content': fullResponse,
                'type': 'text',
                'timestamp': DateTime.now(),
              },
            ],
            isLoading: false,
            isStreaming: false,
            clearStreaming: true,
          );
          _saveMessages(state.messages);
          print('✅ Greg: Message sent successfully');
        },
        onError: (error) {
          print('❌ Greg: Stream error: $error');
          state = state.copyWith(
            isLoading: false,
            isStreaming: false,
            error: 'Error al enviar mensaje: ${error.toString()}',
            clearStreaming: true,
          );
        },
      );
    } catch (e) {
      print('❌ Greg: Exception: $e');
      state = state.copyWith(
        isLoading: false,
        isStreaming: false,
        error: 'Error al enviar mensaje: ${e.toString()}',
        clearStreaming: true,
      );
    }
  }

  /// Send audio file
  Future<void> sendAudio(File audioFile) async {
    await _ensureIds();
    if (state.clientId == null) return;

    final audioMessage = {
      'role': 'user',
      'content': '🎤 Mensaje de audio...',
      'type': 'audio',
      'timestamp': DateTime.now(),
    };

    state = state.copyWith(
      messages: [...state.messages, audioMessage],
      isLoading: true,
      clearError: true,
    );

    try {
      // Transcribe audio
      final transcription = await _gregService.transcribeAudio(
        audioFile.path,
        state.businessId ?? 1,
      );

      if (transcription == null || transcription.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'Transcripción no disponible.',
        );
        return;
      }

      // Update audio message
      final updatedMessages = state.messages.map((m) {
        if (m == audioMessage) {
          return {...m, 'content': transcription, 'transcribed': true};
        }
        return m;
      }).toList();

      state = state.copyWith(messages: updatedMessages);

      // Send to Greg
      final stream = _gregService.sendMessageStream(
        transcription,
        state.clientId!,
        state.clientId!,
        businessId: state.businessId ?? 1,
      );

      // ... reuse listener logic ...
      String fullResponse = '';

      _streamSubscription = stream.listen(
        (partialResponse) {
          fullResponse = partialResponse;
          state = state.copyWith(
            streamingMessage: partialResponse,
            isLoading: false,
            isStreaming: true,
          );
        },
        onDone: () {
          state = state.copyWith(
            messages: [
              ...updatedMessages,
              {
                'role': 'assistant',
                'content': fullResponse,
                'type': 'text',
                'timestamp': DateTime.now(),
              },
            ],
            isLoading: false,
            isStreaming: false,
            clearStreaming: true,
          );
          _saveMessages(state.messages);
        },
        onError: (error) {
          state = state.copyWith(
            isLoading: false,
            isStreaming: false,
            error: error.toString(),
            clearStreaming: true,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> regenerateLastResponse() async {
    // TODO: Implement regenerate for Greg if possible (complicated with async messages)
  }

  void clearConversation() {
    _streamSubscription?.cancel();
    state = GregConversationState(
      businessId: state.businessId,
      clientId: state.clientId,
    );
    _saveMessages([]);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void stopStreaming() {
    _streamSubscription?.cancel();
    if (state.streamingMessage != null && state.streamingMessage!.isNotEmpty) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          {
            'role': 'assistant',
            'content': state.streamingMessage!,
            'type': 'text',
            'timestamp': DateTime.now(),
          },
        ],
        isLoading: false,
        isStreaming: false,
        clearStreaming: true,
      );
      _saveMessages(state.messages);
    } else {
      state = state.copyWith(
        isLoading: false,
        isStreaming: false,
        clearStreaming: true,
      );
    }
  }
}

final gregConversationProvider =
    StateNotifierProvider<GregConversationNotifier, GregConversationState>((
      ref,
    ) {
      final gregService = ref.watch(gregAIServiceProvider);
      return GregConversationNotifier(gregService, ref);
    });
