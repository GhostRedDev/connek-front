import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/api_service.dart';

/// Real Greg AI Service connecting to backend messaging system
/// Uses /messages/send and polling to simulate streaming
class GregAIService {
  final ApiService _apiService = ApiService();
  final SupabaseClient _supabase = Supabase.instance.client;
  int? _cachedConversationId;

  /// Send a message to Greg (Real Bot) via messaging system
  /// Returns a stream of the response (fake streaming)
  Stream<String> sendMessageStream(
    String message,
    int senderId,
    int receiverId, {
    int? businessId,
    List<Map<String, String>>? conversationHistory,
  }) async* {
    try {
      print('🤖 Greg Real: Sending message via Messaging System...');
      print('Sender: $senderId, Receiver: $receiverId, Business: $businessId');

      // 1. Identify Conversation ID if not cached
      // Note: We use Supabase directly because Backend fallback logic might fail if ID is 0
      if (_cachedConversationId == null) {
        _cachedConversationId = await _getOrCreateConversation(
          senderId,
          receiverId,
        );
        print(
          '🆔 Greg Real: Resolved Initial Conversation ID: $_cachedConversationId',
        );
      }

      final sentTime = DateTime.now();

      // 2. Send Message with Valid ID
      final body = {
        'conversation_id':
            _cachedConversationId ??
            0, // Should be valid now, but 0 as fallback
        'sender': senderId,
        'receiver': receiverId,
        'content': message,
        'content_type': 'text',
        'is_test': false,
      };

      final response = await _apiService.post('/messages/send', body: body);

      // Check success
      if (response != null && response['success'] == true) {
        print('✅ Greg Real: Message delivered.');

        if (_cachedConversationId == null || _cachedConversationId == 0) {
          yield 'Error: No se pudo establecer la conversación con el servidor.';
          return;
        }

        // 3. Poll for Response
        // Poll for 30 seconds max
        final botResponse = await _pollForResponse(
          _cachedConversationId!,
          sentTime,
        );

        if (botResponse != null) {
          // 4. Fake Stream the response
          final words = botResponse.split(' ');
          String accumulated = '';
          for (int i = 0; i < words.length; i++) {
            accumulated += (i == 0 ? '' : ' ') + words[i];
            yield accumulated;
            final delay = words[i].length < 4
                ? 10
                : (words[i].length < 8 ? 20 : 30);
            await Future.delayed(Duration(milliseconds: delay));
          }
        } else {
          yield 'Greg está procesando tu solicitud... ';
        }
      } else {
        final error = response != null ? response['error'] : 'Unknown error';
        print('❌ Greg Real API Error: $error');
        yield 'Error al enviar mensaje al servidor: $error';
      }
    } catch (e) {
      print('❌ Greg Real Check Error: $e');
      yield 'Error de conexión: $e';
    }
  }

  /// Get OR Create Conversation directly via Supabase
  /// This bypasses potential backend Fallback bugs when conversation_id is 0
  Future<int?> _getOrCreateConversation(int senderId, int receiverId) async {
    try {
      // 1. Try to find existing conversation
      // If Self-Chat (Greg Assistant)
      if (senderId == receiverId) {
        final res = await _supabase
            .from('conversations')
            .select('id')
            .eq('client1', senderId)
            .eq('client2', senderId)
            .limit(1) // Ensure we only get one if duplicates exist
            .maybeSingle();

        if (res != null) {
          return res['id'] as int;
        }
      } else {
        // Generic logic (Future proof)
        // Check for (client1=s AND client2=r) OR (client1=r AND client2=s)
        final res = await _supabase
            .from('conversations')
            .select('id')
            .or(
              'and(client1.eq.$senderId,client2.eq.$receiverId),and(client1.eq.$receiverId,client2.eq.$senderId)',
            )
            .limit(1) // Ensure we only get one
            .maybeSingle();
        if (res != null) {
          return res['id'] as int;
        }
      }

      // 2. If not found, create it
      print(
        '🤖 Greg: Creating new conversation (Sender $senderId -> Receiver $receiverId)...',
      );
      final newConvo = await _supabase
          .from('conversations')
          .insert({
            'client1': senderId,
            'client2': receiverId,
            'bot_active': true, // Always active for Greg interactions
            'client1_business': false,
            'client2_business': false,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select('id')
          .single();

      return newConvo['id'] as int;
    } catch (e) {
      print('❌ Greg: Error finding/creating conversation: $e');
      return null;
    }
  }

  /// Poll for a message from the bot after `sentTime`
  Future<String?> _pollForResponse(
    int conversationId,
    DateTime sentTime,
  ) async {
    for (int i = 0; i < 15; i++) {
      // Wait 2 seconds between polls
      await Future.delayed(const Duration(seconds: 2));

      try {
        final response = await _apiService.get(
          '/messages/conversation/$conversationId/messages',
        );
        if (response != null &&
            response['success'] == true &&
            response['data'] != null) {
          final messages = response['data'] as List;
          if (messages.isEmpty) continue;

          // Check last message
          final lastMsg = messages.last;

          // Check if it's from bot
          final isBot = lastMsg['sender_bot'] == true;
          final content = lastMsg['content'] as String;
          final timestampStr = lastMsg['created_at'] as String?;
          DateTime? msgTime;
          if (timestampStr != null) {
            msgTime = DateTime.tryParse(timestampStr);
          }

          // Conditions:
          // 1. Must be from Bot
          // 2. Must be newer than our sent time (approx, allowing for clock skew)
          if (isBot) {
            if (msgTime != null) {
              if (msgTime.isAfter(
                sentTime.subtract(const Duration(seconds: 5)),
              )) {
                return content;
              }
            } else {
              // If no timestamp, return it if it's bot (heuristic)
              return content;
            }
          }
        }
      } catch (e) {
        print('Polling error: $e');
      }
    }
    return null;
  }

  /// Transcribe audio (Stub)
  Future<String?> transcribeAudio(String audioPath, int businessId) async {
    return null;
  }

  static Future<bool> checkUserHasAccess(int businessId) async {
    return true;
  }

  /// Greg Profile (Real)
  static Map<String, dynamic> getGregProfile() {
    return {
      'id': -1,
      'name': 'Greg AI',
      'image': 'assets/images/Greg_Card_M.png',
      'is_business': true,
      'is_ai_bot': true,
      'description': '🤖 Tu Asistente de Negocio Personal',
      'subtitle': 'Gestión, Soporte y Operaciones',
      'capabilities': [
        '📅 Gestión de agenda',
        '💼 Operaciones de negocio',
        '🔧 Soporte técnico',
      ],
    };
  }

  /// Get suggested prompts for users
  static List<Map<String, dynamic>> getSuggestedPrompts() {
    return [
      {
        'text': '¿Cómo va mi negocio hoy?',
        'icon': 'trending_up',
        'category': 'business',
      },
      {
        'text': 'Ayuda con SOPORTE',
        'icon': 'support_agent',
        'category': 'support',
      },
    ];
  }
}
