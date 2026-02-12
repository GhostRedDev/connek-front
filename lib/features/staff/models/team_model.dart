DateTime _parseDate(dynamic value) {
  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }
  return DateTime.fromMillisecondsSinceEpoch(0);
}

int _parseInt(dynamic value, {int fallback = 0}) {
  if (value is int) {
    return value;
  }
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }
  return fallback;
}

class TeamMember {
  final int id;
  final int teamId;
  final int employeeId;
  final String role; // 'leader' or 'member'
  final DateTime joinedAt;
  final EmployeeInfo? employee;

  TeamMember({
    required this.id,
    required this.teamId,
    required this.employeeId,
    required this.role,
    required this.joinedAt,
    this.employee,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: _parseInt(json['id']),
      teamId: _parseInt(json['team_id']),
      employeeId: _parseInt(json['employee_id']),
      role: json['role'] as String,
      joinedAt: _parseDate(json['joined_at']),
      employee: json['employees'] != null
          ? EmployeeInfo.fromJson(json['employees'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_id': teamId,
      'employee_id': employeeId,
      'role': role,
      'joined_at': joinedAt.toIso8601String(),
    };
  }
}

class EmployeeInfo {
  final int id;
  final String name;
  final String? profileImage;
  final String? email;

  EmployeeInfo({
    required this.id,
    required this.name,
    this.profileImage,
    this.email,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
    return EmployeeInfo(
      id: _parseInt(json['id']),
      name: (json['name'] as String?) ?? '',
      profileImage:
          (json['profile_image'] as String?) ?? (json['image'] as String?),
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_image': profileImage,
      'email': email,
    };
  }
}

class Team {
  final int id;
  final int businessId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TeamMember> members;

  Team({
    required this.id,
    required this.businessId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.members = const [],
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: _parseInt(json['id']),
      businessId: _parseInt(json['business_id']),
      name: (json['name'] as String?) ?? '',
      description: json['description'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
      members: json['team_members'] != null
          ? (json['team_members'] as List)
                .map((m) => TeamMember.fromJson(m as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'name': name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper getters
  int get memberCount => members.length;
  List<TeamMember> get leaders =>
      members.where((m) => m.role == 'leader').toList();
  bool isLeader(int employeeId) =>
      members.any((m) => m.employeeId == employeeId && m.role == 'leader');
}
