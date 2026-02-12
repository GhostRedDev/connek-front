/// AI Assistant Model
/// Represents an AI assistant available in the system
class AIAssistantModel {
  final String id;
  final String name;
  final String description;
  final String? image;
  final String type; // 'greg', 'custom', 'vision', 'analyst'
  final bool isActive;
  final List<String> capabilities;
  final String? subscriptionRequired;
  final Map<String, dynamic>? metadata;

  AIAssistantModel({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.type,
    this.isActive = true,
    this.capabilities = const [],
    this.subscriptionRequired,
    this.metadata,
  });

  factory AIAssistantModel.fromJson(Map<String, dynamic> json) {
    return AIAssistantModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      type: json['type'] ?? 'custom',
      isActive: json['is_active'] ?? true,
      capabilities: json['capabilities'] != null
          ? List<String>.from(json['capabilities'])
          : [],
      subscriptionRequired: json['subscription_required'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'type': type,
      'is_active': isActive,
      'capabilities': capabilities,
      'subscription_required': subscriptionRequired,
      'metadata': metadata,
    };
  }

  // Check if this is Greg
  bool get isGreg => type == 'greg' || id == '-1';

  // Get display color based on type
  int get primaryColor {
    switch (type) {
      case 'greg':
        return 0xFF0EA5E9; // Blue
      case 'vision':
        return 0xFF8B5CF6; // Purple
      case 'analyst':
        return 0xFF10B981; // Green
      case 'custom':
        return 0xFFF59E0B; // Orange
      default:
        return 0xFF6B7280; // Gray
    }
  }

  // Get icon based on type
  String get iconName {
    switch (type) {
      case 'greg':
        return 'smart_toy';
      case 'vision':
        return 'visibility';
      case 'analyst':
        return 'analytics';
      case 'custom':
        return 'psychology';
      default:
        return 'assistant';
    }
  }
}
