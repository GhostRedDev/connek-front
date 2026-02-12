import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/skill_model.dart';
import '../../../../core/config/api_config.dart';

class SkillsProvider with ChangeNotifier {
  List<Skill> _allSkills = [];
  List<EmployeeSkill> _employeeSkills = [];
  bool _isLoading = false;
  String? _error;

  List<Skill> get allSkills => _allSkills;
  List<EmployeeSkill> get employeeSkills => _employeeSkills;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAllSkills({String? category}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      var url = '${ApiConfig.baseUrl}/skills';
      if (category != null) url += '?category=$category';

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _allSkills = (data['data'] as List)
              .map((skill) => Skill.fromJson(skill))
              .toList();
        } else {
          _error = data['error'] ?? 'Error desconocido';
        }
      } else {
        _error = 'Error al cargar skills: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEmployeeSkills(int employeeId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/skills/employee/$employeeId/skills'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _employeeSkills = (data['data'] as List)
              .map((empSkill) => EmployeeSkill.fromJson(empSkill))
              .toList();
        } else {
          _error = data['error'] ?? 'Error desconocido';
        }
      } else {
        _error = 'Error al cargar skills del empleado: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> assignSkillToEmployee(
    int employeeId,
    int skillId,
    int proficiencyLevel,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/skills/employee/$employeeId/skills'),
        headers: ApiConfig.headers,
        body: {
          'skill_id': skillId.toString(),
          'proficiency_level': proficiencyLevel.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          await fetchEmployeeSkills(employeeId);
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al asignar skill: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProficiency(
    int employeeId,
    int skillId,
    int proficiencyLevel,
  ) async {
    try {
      final response = await http.put(
        Uri.parse(
          '${ApiConfig.baseUrl}/skills/employee/$employeeId/skills/$skillId/proficiency',
        ),
        headers: ApiConfig.headers,
        body: {'proficiency_level': proficiencyLevel.toString()},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          await fetchEmployeeSkills(employeeId);
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar proficiencia: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeSkillFromEmployee(int employeeId, int skillId) async {
    try {
      final response = await http.delete(
        Uri.parse(
          '${ApiConfig.baseUrl}/skills/employee/$employeeId/skills/$skillId',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _employeeSkills.removeWhere((es) => es.skillId == skillId);
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al remover skill: $e';
      notifyListeners();
      return false;
    }
  }
}
