class BusinessCategory {
  final String id;
  final String name;
  final String icon;
  final String group;

  const BusinessCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.group,
  });
}

class BusinessCategories {
  static const List<BusinessCategory> all = [
    // Belleza y Cuidado Personal
    BusinessCategory(
      id: 'beauty_salon',
      name: 'Salón de Belleza',
      icon: '💇',
      group: 'Belleza',
    ),
    BusinessCategory(
      id: 'barbershop',
      name: 'Barbería',
      icon: '✂️',
      group: 'Belleza',
    ),
    BusinessCategory(
      id: 'spa',
      name: 'Spa & Masajes',
      icon: '🧖',
      group: 'Belleza',
    ),
    BusinessCategory(
      id: 'nails',
      name: 'Manicure & Pedicure',
      icon: '💅',
      group: 'Belleza',
    ),

    // Salud y Fitness
    BusinessCategory(id: 'gym', name: 'Gimnasio', icon: '🏋️', group: 'Salud'),
    BusinessCategory(
      id: 'yoga',
      name: 'Yoga & Pilates',
      icon: '🧘',
      group: 'Salud',
    ),
    BusinessCategory(
      id: 'personal_trainer',
      name: 'Entrenador Personal',
      icon: '💪',
      group: 'Salud',
    ),

    // Servicios Profesionales
    BusinessCategory(
      id: 'photography',
      name: 'Fotografía',
      icon: '📸',
      group: 'Profesional',
    ),
    BusinessCategory(
      id: 'consulting',
      name: 'Consultoría',
      icon: '💼',
      group: 'Profesional',
    ),
    BusinessCategory(
      id: 'design',
      name: 'Diseño Gráfico',
      icon: '🎨',
      group: 'Profesional',
    ),
    BusinessCategory(
      id: 'marketing',
      name: 'Marketing Digital',
      icon: '📱',
      group: 'Profesional',
    ),

    // Educación
    BusinessCategory(
      id: 'tutoring',
      name: 'Clases Particulares',
      icon: '📚',
      group: 'Educación',
    ),
    BusinessCategory(
      id: 'music',
      name: 'Clases de Música',
      icon: '🎵',
      group: 'Educación',
    ),
    BusinessCategory(
      id: 'languages',
      name: 'Idiomas',
      icon: '🗣️',
      group: 'Educación',
    ),

    // Hogar y Mantenimiento
    BusinessCategory(
      id: 'cleaning',
      name: 'Limpieza',
      icon: '🧹',
      group: 'Hogar',
    ),
    BusinessCategory(
      id: 'plumbing',
      name: 'Plomería',
      icon: '🔧',
      group: 'Hogar',
    ),
    BusinessCategory(
      id: 'electrician',
      name: 'Electricista',
      icon: '💡',
      group: 'Hogar',
    ),

    // Eventos
    BusinessCategory(
      id: 'catering',
      name: 'Catering',
      icon: '🍽️',
      group: 'Eventos',
    ),
    BusinessCategory(
      id: 'event_planning',
      name: 'Organización de Eventos',
      icon: '🎉',
      group: 'Eventos',
    ),

    // Mascotas
    BusinessCategory(
      id: 'pet_grooming',
      name: 'Peluquería de Mascotas',
      icon: '🐕',
      group: 'Mascotas',
    ),
    BusinessCategory(
      id: 'veterinary',
      name: 'Veterinaria',
      icon: '🏥',
      group: 'Mascotas',
    ),

    // Otros
    BusinessCategory(id: 'other', name: 'Otro', icon: '🏢', group: 'Otros'),
  ];

  static BusinessCategory? findById(String id) {
    try {
      return all.firstWhere((cat) => cat.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<String> get allGroups {
    return all.map((cat) => cat.group).toSet().toList();
  }

  static List<BusinessCategory> getByGroup(String group) {
    return all.where((cat) => cat.group == group).toList();
  }

  /// Map of groups to their categories for dropdown usage
  static Map<String, List<String>> get categories {
    final Map<String, List<String>> result = {};
    for (final group in allGroups) {
      result[group] = getByGroup(group).map((cat) => cat.name).toList();
    }
    return result;
  }
}
