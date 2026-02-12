import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/marketing_ai_service.dart';
import '../../../business/presentation/providers/business_provider.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for Marketing AI Service
final marketingAIServiceProvider = Provider<MarketingAIService>((ref) {
  return MarketingAIService();
});

/// Provider to get current business ID for Marketing
final marketingBusinessIdProvider = FutureProvider.autoDispose<int?>((
  ref,
) async {
  try {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user != null) {
      // 1. Get client_id
      try {
        final clientRes = await supabase
            .from('client')
            .select('id')
            .eq('user_id', user.id)
            .maybeSingle();

        if (clientRes != null) {
          final clientId = clientRes['id'] as int;

          // 2. Get business_id
          final businessRepo = ref.read(businessRepositoryProvider);
          final businessData = await businessRepo.getMyBusiness(clientId);

          if (businessData != null) {
            final businessId = businessData['id'] as int;
            print('✅ Marketing Business ID Found: $businessId');
            return businessId;
          }
        }
      } catch (dbError) {
        print('⚠️ Marketing DB Error (ignorable): $dbError');
      }
    }
  } catch (e) {
    print('⚠️ Marketing: General Error getting business info: $e');
  }

  // Fallback for Demo Mode (if no business found or error)
  print('⚠️ Marketing: Using Fallback Business ID = 1 (Demo Mode)');
  return 1;
});

/// Provider to check if current user has access to Marketing AI
final marketingAccessProvider = FutureProvider.autoDispose<bool>((ref) async {
  final businessId = await ref.watch(marketingBusinessIdProvider.future);

  if (businessId == null) {
    print('⚠️ No business ID found - denying Marketing access');
    return false;
  }

  return await MarketingAIService.checkUserHasAccess(businessId);
});

/// State for Marketing conversation
class MarketingConversationState {
  final List<Map<String, dynamic>> messages;
  final bool isLoading;
  final String? error;
  final String? streamingMessage; // Current message being streamed
  final bool isStreaming; // Whether currently streaming a response
  final int? businessId; // Current business ID being used

  MarketingConversationState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.streamingMessage,
    this.isStreaming = false,
    this.businessId,
  });

  MarketingConversationState copyWith({
    List<Map<String, dynamic>>? messages,
    bool? isLoading,
    String? error,
    String? streamingMessage,
    bool? isStreaming,
    int? businessId,
    bool clearError = false,
    bool clearStreaming = false,
  }) {
    return MarketingConversationState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      streamingMessage: clearStreaming
          ? null
          : (streamingMessage ?? this.streamingMessage),
      isStreaming: isStreaming ?? this.isStreaming,
      businessId: businessId ?? this.businessId,
    );
  }
}

/// Notifier for managing Marketing conversation
class MarketingConversationNotifier
    extends StateNotifier<MarketingConversationState> {
  final MarketingAIService _marketingService;
  final Ref _ref;
  StreamSubscription? _streamSubscription;

  MarketingConversationNotifier(this._marketingService, this._ref)
    : super(MarketingConversationState()) {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMessages = prefs.getString('marketing_chat_history');

      if (savedMessages != null) {
        final List<dynamic> decoded = jsonDecode(savedMessages);
        final messages = decoded
            .map((m) => Map<String, dynamic>.from(m))
            .toList();
        state = state.copyWith(messages: messages);
        print('✅ Marketing: Load ${messages.length} messages from history');
      }
    } catch (e) {
      print('❌ Marketing: Error loading history: $e');
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

      await prefs.setString(
        'marketing_chat_history',
        jsonEncode(messagesToSave),
      );
    } catch (e) {
      print('❌ Marketing: Error saving history: $e');
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  /// Get current business ID
  Future<int?> _getBusinessId() async {
    try {
      // Get business ID from provider
      final businessId = await _ref.read(marketingBusinessIdProvider.future);

      if (businessId == null) {
        print('❌ Marketing: No business ID available');
        state = state.copyWith(
          error: 'No se encontró un negocio asociado a tu cuenta',
        );
        return null;
      }

      // Update state with business ID
      if (state.businessId != businessId) {
        state = state.copyWith(businessId: businessId);
        print('✅ Marketing: Using business_id=$businessId');
      }

      return businessId;
    } catch (e) {
      print('❌ Error getting business ID: $e');
      state = state.copyWith(error: 'Error al obtener información del negocio');
      return null;
    }
  }

  /// Send a text message to Marketing with streaming effect
  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    // Get business ID first
    final businessId = await _getBusinessId();
    if (businessId == null) return;

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
      isStreaming: true,
      clearError: true,
      clearStreaming: true,
    );

    try {
      // Get conversation history for context (last 10 messages)
      final history = state.messages
          .where((m) => m['type'] == 'text')
          .map(
            (m) => {
              'role': m['role'] as String,
              'content': m['content'] as String,
            },
          )
          .toList();

      print('💬 Marketing: Sending message to business_id=$businessId');

      // Stream the response word by word
      final stream = _marketingService.sendMessageStream(
        userMessage,
        businessId,
        conversationHistory: history.length > 10
            ? history.sublist(history.length - 10)
            : history,
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
          print('✅ Marketing: Message sent successfully');
        },
        onError: (error) {
          print('❌ Marketing: Stream error: $error');
          state = state.copyWith(
            isLoading: false,
            isStreaming: false,
            error: 'Error al enviar mensaje: ${error.toString()}',
            clearStreaming: true,
          );
        },
      );
    } catch (e) {
      print('❌ Marketing: Exception: $e');
      state = state.copyWith(
        isLoading: false,
        isStreaming: false,
        error: 'Error al enviar mensaje: ${e.toString()}',
        clearStreaming: true,
      );
    }
  }

  /// Send audio file (transcribe + respond)
  Future<void> sendAudio(File audioFile) async {
    // Get business ID first
    final businessId = await _getBusinessId();
    if (businessId == null) return;

    // Add placeholder for audio message
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
      print('🎤 Marketing: Transcribing audio for business_id=$businessId');

      // Transcribe audio
      final transcription = await _marketingService.transcribeAudio(
        audioFile.path,
        businessId,
      );

      if (transcription == null || transcription.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error:
              'La transcripción de audio aún no está disponible. Por favor usa mensajes de texto.',
        );
        return;
      }

      // Update audio message with transcription
      final updatedMessages = state.messages.map((m) {
        if (m == audioMessage) {
          return {...m, 'content': transcription, 'transcribed': true};
        }
        return m;
      }).toList();

      state = state.copyWith(messages: updatedMessages);

      // Get conversation history
      final history = state.messages
          .where((m) => m['type'] == 'text' || m['type'] == 'audio')
          .map(
            (m) => {
              'role': m['role'] as String,
              'content': m['content'] as String,
            },
          )
          .toList();

      // Get AI response with streaming
      final stream = _marketingService.sendMessageStream(
        transcription,
        businessId,
        conversationHistory: history.length > 10
            ? history.sublist(history.length - 10)
            : history,
      );

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
            error: 'Error al procesar audio: ${error.toString()}',
            clearStreaming: true,
          );
        },
      );
    } catch (e) {
      print('❌ Marketing: Audio error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Error al procesar audio: ${e.toString()}',
      );
    }
  }

  /// Regenerate the last AI response with streaming
  Future<void> regenerateLastResponse() async {
    if (state.messages.isEmpty) return;

    // Get business ID first
    final businessId = await _getBusinessId();
    if (businessId == null) return;

    // Cancel any ongoing stream
    await _streamSubscription?.cancel();

    // Find the last user message
    final lastUserMessageIndex = state.messages.lastIndexWhere(
      (m) => m['role'] == 'user',
    );

    if (lastUserMessageIndex == -1) return;

    final lastUserMessage = state.messages[lastUserMessageIndex];
    final userContent = lastUserMessage['content'] as String;

    // Remove messages after the last user message
    final messagesUpToUser = state.messages.sublist(
      0,
      lastUserMessageIndex + 1,
    );

    state = state.copyWith(
      messages: messagesUpToUser,
      isLoading: true,
      isStreaming: true,
      clearError: true,
      clearStreaming: true,
    );

    try {
      // Get conversation history
      final history = messagesUpToUser
          .where((m) => m['type'] == 'text' || m['type'] == 'audio')
          .map(
            (m) => {
              'role': m['role'] as String,
              'content': m['content'] as String,
            },
          )
          .toList();

      print('🔄 Marketing: Regenerating response for business_id=$businessId');

      // Stream new response
      final stream = _marketingService.sendMessageStream(
        userContent,
        businessId,
        conversationHistory: history.length > 10
            ? history.sublist(history.length - 10)
            : history,
      );

      String fullResponse = '';

      _streamSubscription = stream.listen(
        (partialResponse) {
          fullResponse = partialResponse;
          state = state.copyWith(
            streamingMessage: partialResponse,
            isLoading: false,
          );
        },
        onDone: () {
          state = state.copyWith(
            messages: [
              ...messagesUpToUser,
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
            error: 'Error al regenerar respuesta: ${error.toString()}',
            clearStreaming: true,
          );
        },
      );
    } catch (e) {
      print('❌ Marketing: Regenerate error: $e');
      state = state.copyWith(
        isLoading: false,
        isStreaming: false,
        error: 'Error al regenerar respuesta: ${e.toString()}',
        clearStreaming: true,
      );
    }
  }

  /// Clear conversation history
  void clearConversation() {
    _streamSubscription?.cancel();
    state = MarketingConversationState(businessId: state.businessId);
    _saveMessages([]);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Stop current streaming
  void stopStreaming() {
    _streamSubscription?.cancel();

    // If there's a streaming message, add it as final message
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

/// Provider for Marketing conversation
final marketingConversationProvider =
    StateNotifierProvider<
      MarketingConversationNotifier,
      MarketingConversationState
    >((ref) {
      final marketingService = ref.watch(marketingAIServiceProvider);
      return MarketingConversationNotifier(marketingService, ref);
    });
