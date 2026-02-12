import '../models/ai_assistant_model.dart';

/// AI Assistants Service
/// Manages all AI assistants available in the system
class AIAssistantsService {
  /// Get all available AI assistants
  static List<AIAssistantModel> getAllAIAssistants() {
    return [
      // Greg AI - Main Operations Assistant (Real Greg)
      AIAssistantModel(
        id: '-1',
        name: 'Greg AI',
        description: '🤖 Tu Asistente de Operaciones y Soporte',
        image: 'assets/images/Greg_Card_M.png',
        type: 'greg',
        isActive: true,
        capabilities: [
          '📅 Gestión de agenda',
          '🔧 Soporte técnico',
          '💼 Operaciones de negocio',
          '📊 Reportes de estado',
          '👥 Gestión de equipo',
        ],
        subscriptionRequired: 'greg_subscription',
        metadata: {
          'color_primary': 0xFF0EA5E9,
          'color_secondary': 0xFF0284C7,
          'subtitle': 'Tu mano derecha en el negocio',
          'model': 'Greg Operating System',
          'features': [
            'Conexión directa con tu negocio',
            'Gestión de tareas',
            'Soporte 24/7',
          ],
        },
      ),

      // Marketing Advisor - The Expert Marketer
      AIAssistantModel(
        id: '-5',
        name: 'Marketing Advisor',
        description: '📈 Tu Experto en Estrategia y Ventas',
        image:
            'assets/images/Greg_Card_M.png', // Or different image if available
        type: 'marketing',
        isActive: true,
        capabilities: [
          '💬 Estrategias de marketing',
          '✍️ Creación de contenido',
          '🎯 Campañas publicitarias',
          '📊 Análisis de mercado',
          '💡 Ideas creativas',
        ],
        subscriptionRequired: 'marketing_subscription', // Or bundle it?
        metadata: {
          'color_primary': 0xFFF59E0B, // Orange/Gold for Marketing
          'color_secondary': 0xFFD97706,
          'subtitle': 'Potencia tu marca y ventas',
          'model': 'Gemini 1.5 Pro',
          'features': [
            'Copywriting experto',
            'Planificación de contenido',
            'Análisis de tendencias',
          ],
        },
      ),

      // Vision AI - Image Analysis Assistant
      AIAssistantModel(
        id: '-2',
        name: 'Vision AI',
        description: '👁️ Asistente de Análisis Visual',
        image: null,
        type: 'vision',
        isActive: false, // Coming soon
        capabilities: [
          '📸 Análisis de imágenes',
          '🔍 Detección de objetos',
          '📝 Extracción de texto (OCR)',
          '🎨 Análisis de diseño',
          '📊 Generación de reportes visuales',
        ],
        subscriptionRequired: 'vision_subscription',
        metadata: {
          'color_primary': 0xFF8B5CF6,
          'color_secondary': 0xFF7C3AED,
          'subtitle': 'Análisis visual inteligente',
          'model': 'GPT-4o-mini Vision',
          'status': 'coming_soon',
        },
      ),

      // Analyst AI - Data Analysis Assistant
      AIAssistantModel(
        id: '-3',
        name: 'Analyst AI',
        description: '📊 Asistente de Análisis de Datos',
        image: null,
        type: 'analyst',
        isActive: false, // Coming soon
        capabilities: [
          '📈 Análisis de tendencias',
          '💹 Predicciones de ventas',
          '📉 Identificación de patrones',
          '🎯 Recomendaciones estratégicas',
          '📋 Reportes automáticos',
        ],
        subscriptionRequired: 'analyst_subscription',
        metadata: {
          'color_primary': 0xFF10B981,
          'color_secondary': 0xFF059669,
          'subtitle': 'Inteligencia de negocios avanzada',
          'model': 'GPT-4o',
          'status': 'coming_soon',
        },
      ),

      // Content AI - Content Creation Assistant
      AIAssistantModel(
        id: '-4',
        name: 'Content AI',
        description: '✍️ Asistente de Creación de Contenido',
        image: null,
        type: 'custom',
        isActive: false, // Coming soon
        capabilities: [
          '📝 Generación de textos',
          '🎨 Ideas creativas',
          '📱 Posts para redes sociales',
          '📧 Emails de marketing',
          '🎯 Copywriting persuasivo',
        ],
        subscriptionRequired: 'content_subscription',
        metadata: {
          'color_primary': 0xFFEC4899, // Pink for content
          'color_secondary': 0xFFDB2777,
          'subtitle': 'Crea contenido impactante',
          'model': 'GPT-4o',
          'status': 'coming_soon',
        },
      ),
    ];
  }

  /// Get only active AI assistants
  static List<AIAssistantModel> getActiveAIAssistants() {
    return getAllAIAssistants().where((ai) => ai.isActive).toList();
  }

  /// Get AI assistant by ID
  static AIAssistantModel? getAIAssistantById(String id) {
    try {
      return getAllAIAssistants().firstWhere((ai) => ai.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get AI assistant by type
  static List<AIAssistantModel> getAIAssistantsByType(String type) {
    return getAllAIAssistants().where((ai) => ai.type == type).toList();
  }

  /// Get Greg AI specifically
  static AIAssistantModel getGregAI() {
    return getAllAIAssistants().firstWhere(
      (ai) => ai.type == 'greg',
      orElse: () => getAllAIAssistants().first,
    );
  }

  /// Check if user has access to AI (based on subscription)
  static bool hasAccessToAI(
    AIAssistantModel ai, {
    bool hasSubscription = false,
  }) {
    if (ai.subscriptionRequired == null) return true;
    return hasSubscription;
  }

  /// Get AI assistants available for user
  static List<AIAssistantModel> getAvailableAIAssistants({
    bool hasGregSubscription = false,
    bool hasVisionSubscription = false,
    bool hasAnalystSubscription = false,
    bool hasContentSubscription = false,
    bool hasMarketingSubscription = false,
  }) {
    return getAllAIAssistants().where((ai) {
      if (!ai.isActive) return false;

      switch (ai.subscriptionRequired) {
        case 'greg_subscription':
          return hasGregSubscription;
        case 'marketing_subscription':
          return hasMarketingSubscription;
        case 'vision_subscription':
          return hasVisionSubscription;
        case 'analyst_subscription':
          return hasAnalystSubscription;
        case 'content_subscription':
          return hasContentSubscription;
        default:
          return true;
      }
    }).toList();
  }
}
