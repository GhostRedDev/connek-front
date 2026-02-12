import 'dart:async';
import '../../../../core/services/api_service.dart';

/// Service for Marketing Advisor AI Bot using backend API
/// Simulates ChatGPT-style streaming effect
class MarketingAIService {
  final ApiService _apiService = ApiService();

  /// Send a message to Marketing Advisor and get AI response with streaming effect
  /// Returns a stream of partial responses to simulate typing
  Stream<String> sendMessageStream(
    String message,
    int businessId, {
    List<Map<String, String>>? conversationHistory,
  }) async* {
    try {
      print('🤖 Marketing AI: Sending message to backend...');

      // Send request to backend
      final messages = [
        ...?conversationHistory,
        {'role': 'user', 'content': message},
      ];

      final response = await _apiService.post(
        '/api/v1/marketing/chat',
        body: {'business_id': businessId, 'messages': messages},
      );

      print('RAW RESPONSE: $response');

      if (response != null &&
          response is Map &&
          response.containsKey('response')) {
        final fullResponse = response['response'] as String;
        print('✅ Marketing AI: Response received from backend');

        // 1. Stream text response
        final words = fullResponse.split(' ');
        String accumulated = '';

        for (int i = 0; i < words.length; i++) {
          accumulated += (i == 0 ? '' : ' ') + words[i];
          yield accumulated;
          final wordLength = words[i].length;
          final delay = wordLength < 4 ? 10 : (wordLength < 8 ? 20 : 30);
          await Future.delayed(Duration(milliseconds: delay));
        }

        // 2. Handle Video Job
        if (response.containsKey('video_job') &&
            response['video_job'] != null) {
          final jobInfo = response['video_job'];
          final jobId = jobInfo['job_id'];

          yield accumulated + '\n\n🎥 Iniciando generación de video...';

          final videoUrl = await _pollVideoStatus(jobId.toString());

          if (videoUrl != null) {
            yield accumulated +
                '\n\n✨ ¡Video Listo!\n[[VIDEO_RESULT:$videoUrl]]';
          } else {
            yield accumulated +
                '\n\n❌ Error al generar el video o tiempo de espera agotado.';
          }
        }
      } else {
        final errorMsg = response is Map
            ? (response['error'] ?? response['message'] ?? 'Error desconocido')
            : 'Error al procesar la solicitud';

        print('❌ Marketing AI Error: $errorMsg');
        yield 'Lo siento, tuve un problema: $errorMsg';
      }
    } catch (e) {
      print('❌ Marketing AI Exception: $e');
      print('⚠️ Activando Modo Demo por fallo de API');

      if (message.toLowerCase().contains('video')) {
        yield "Modo Demo: Generando video de prueba...";
        await Future.delayed(const Duration(seconds: 2));
        yield "Modo Demo: Generando video de prueba...\n\nAquí tienes un ejemplo:\n[[VIDEO_RESULT:https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4]]";
      } else {
        yield "Modo Demo: No puedo conectar con el cerebro creativo en este momento. Intenta más tarde.";
      }
    }
  }

  Future<String?> _pollVideoStatus(String jobId) async {
    int attempts = 0;
    // Poll for up to 5 minutes (60 * 5s)
    const baseUrl = 'https://connek-dev-aa5f5db19836.herokuapp.com'; // Dev env

    while (attempts < 60) {
      await Future.delayed(const Duration(seconds: 5));
      try {
        final res = await _apiService.get('/api/v1/marketing/status/$jobId');
        if (res != null) {
          final status = res['status'];
          if (status == 'completed') {
            final relUrl = res['url'];
            if (relUrl.toString().startsWith('http')) {
              return relUrl;
            }
            return '$baseUrl$relUrl';
          } else if (status == 'failed') {
            return null;
          }
        }
      } catch (e) {
        print('Polling error: $e');
      }
      attempts++;
    }
    return null;
  }

  /// Send a message and get complete response (non-streaming)
  Future<String> sendMessage(
    String message,
    int businessId, {
    List<Map<String, String>>? conversationHistory,
  }) async {
    try {
      print('🤖 Marketing AI: Sending message to backend...');

      // Build messages array: history + new message
      final messages = [
        ...?conversationHistory,
        {'role': 'user', 'content': message},
      ];

      final response = await _apiService.post(
        '/api/v1/marketing/chat',
        body: {'business_id': businessId, 'messages': messages},
      );

      print('RAW RESPONSE: $response');

      // The backend returns {"response": "..."} directly
      if (response != null &&
          response is Map &&
          response.containsKey('response')) {
        final reply = response['response'] as String;
        print('✅ Marketing AI: Response received');
        return reply.trim();
      } else {
        final errorMsg = response is Map
            ? (response['error'] ?? response['message'] ?? 'Error desconocido')
            : 'Error al procesar la solicitud';

        print('❌ Marketing AI Error: $errorMsg');
        return 'Lo siento, tuve un problema: $errorMsg';
      }
    } catch (e) {
      print('❌ Marketing AI Exception: $e');
      return 'Lo siento, no pude conectarme en este momento. Verifica tu conexión a internet.';
    }
  }

  /// Transcribe audio file using backend
  Future<String?> transcribeAudio(String audioPath, int businessId) async {
    try {
      print('🎤 Marketing AI: Transcribing audio via backend...');

      // TODO: Implement audio upload to backend
      // For now, return null to indicate not implemented
      print('⚠️ Audio transcription not yet implemented in backend');
      return null;
    } catch (e) {
      print('❌ Audio transcription error: $e');
      return null;
    }
  }

  /// Check if user has access to Marketing AI
  static Future<bool> checkUserHasAccess(int businessId) async {
    return true; // Force access for Demo Mode
  }

  /// Get Marketing Advisor's profile info for chat display
  static Map<String, dynamic> getMarketingProfile() {
    return {
      'id': -2, // Special ID for Marketing Bot
      'name': 'Tyrion',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GfcxvctQjTy0klx98J2PNlmPU5ftcV5cFg&s',
      'is_business': false,
      'is_ai_bot': true,
      'description': '🤖 Tu Asistente de Estrategia y Marketing',
      'subtitle': 'Potenciado por IA (Gemini) - Experto en Marketing',
      'capabilities': [
        '💬 Estrategias de mercado',
        '🎯 Ideas de contenido',
        '📊 Análisis de competencia',
        '✨ Copywriting',
        '📅 Planificación de campañas',
        '💡 Consejos de ventas',
      ],
    };
  }

  /// Get suggested prompts for users
  static List<Map<String, dynamic>> getSuggestedPrompts() {
    return [
      {
        'text': '¿Cómo puedo atraer más clientes?',
        'icon': 'campaign',
        'category': 'marketing',
      },
      {
        'text': 'Dame ideas para posts de Instagram',
        'icon': 'post_add',
        'category': 'content',
      },
      {
        'text': '¿Cómo mejorar mis ventas?',
        'icon': 'trending_up',
        'category': 'sales',
      },
      {
        'text': 'Escribe un email promocional',
        'icon': 'email',
        'category': 'copywriting',
      },
      {
        'text': 'Analiza mi competencia',
        'icon': 'analytics',
        'category': 'analysis',
      },
      {
        'text': 'Estrategias de retención',
        'icon': 'people',
        'category': 'retention',
      },
    ];
  }
}
