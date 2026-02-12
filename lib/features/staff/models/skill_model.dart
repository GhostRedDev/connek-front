class Skill {
  final int id;
  final String name;
  final String? category; // 'technical', 'soft', 'language'
  final DateTime createdAt;

  Skill({
    required this.id,
    required this.name,
    this.category,
    required this.createdAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get categoryEmoji {
    switch (category) {
      case 'technical':
        return '⚙️';
      case 'soft':
        return '🤝';
      case 'language':
        return '🌐';
      default:
        return '📚';
    }
  }
}

class EmployeeSkill {
  final int id;
  final int employeeId;
  final int skillId;
  final int proficiencyLevel; // 1-5
  final DateTime createdAt;
  final Skill? skill;

  EmployeeSkill({
    required this.id,
    required this.employeeId,
    required this.skillId,
    required this.proficiencyLevel,
    required this.createdAt,
    this.skill,
  });

  factory EmployeeSkill.fromJson(Map<String, dynamic> json) {
    return EmployeeSkill(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      skillId: json['skill_id'] as int,
      proficiencyLevel: json['proficiency_level'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      skill: json['skills'] != null
          ? Skill.fromJson(json['skills'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'skill_id': skillId,
      'proficiency_level': proficiencyLevel,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get proficiencyLabel {
    switch (proficiencyLevel) {
      case 1:
        return 'Básico';
      case 2:
        return 'Principiante';
      case 3:
        return 'Intermedio';
      case 4:
        return 'Avanzado';
      case 5:
        return 'Experto';
      default:
        return 'Sin nivel';
    }
  }

  String get starsDisplay => '⭐' * proficiencyLevel;
}
