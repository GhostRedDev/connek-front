import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/team_model.dart';
import '../../../../core/config/api_config.dart';

class TeamsProvider with ChangeNotifier {
  List<Team> _teams = [];
  bool _isLoading = false;
  String? _error;

  List<Team> get teams => _teams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTeams(int businessId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/teams?business_id=$businessId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _teams = (data['data'] as List)
              .map((team) => Team.fromJson(team))
              .toList();
        } else {
          _error = data['error'] ?? 'Error desconocido';
        }
      } else {
        _error = 'Error al cargar equipos: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTeam(
    int businessId,
    String name,
    String? description,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/teams'),
        headers: ApiConfig.headers,
        body: {
          'business_id': businessId.toString(),
          'name': name,
          if (description != null) 'description': description,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final newTeam = Team.fromJson(data['data']);
          _teams.add(newTeam);
          notifyListeners();
          return true;
        } else {
          _error = data['error'] ?? 'Error al crear equipo';
          notifyListeners();
        }
      } else {
        _error = 'Error al crear equipo: ${response.statusCode}';
        notifyListeners();
      }
      return false;
    } catch (e) {
      _error = 'Error al crear equipo: $e';
      notifyListeners();
      return false;
    }
  }

  // Alias for fetchTeams
  Future<void> loadTeams(int businessId) => fetchTeams(businessId);

  Future<bool> updateTeam(int teamId, String name, String? description) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/teams/$teamId'),
        headers: ApiConfig.headers,
        body: {
          'name': name,
          if (description != null) 'description': description,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final updatedTeam = Team.fromJson(data['data']);
          final index = _teams.indexWhere((t) => t.id == teamId);
          if (index != -1) {
            _teams[index] = updatedTeam;
            notifyListeners();
          }
          return true;
        } else {
          _error = data['error'] ?? 'Error al actualizar equipo';
          notifyListeners();
        }
      } else {
        _error = 'Error al actualizar equipo: ${response.statusCode}';
        notifyListeners();
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar equipo: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTeam(int teamId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/teams/$teamId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _teams.removeWhere((t) => t.id == teamId);
          notifyListeners();
          return true;
        } else {
          _error = data['error'] ?? 'Error al eliminar equipo';
          notifyListeners();
        }
      } else {
        _error = 'Error al eliminar equipo: ${response.statusCode}';
        notifyListeners();
      }
      return false;
    } catch (e) {
      _error = 'Error al eliminar equipo: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> addMember(int teamId, int employeeId, String role) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/teams/$teamId/members'),
        headers: ApiConfig.headers,
        body: {'employee_id': employeeId.toString(), 'role': role},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          // Refresh teams to get updated members
          final teamIndex = _teams.indexWhere((t) => t.id == teamId);
          if (teamIndex != -1) {
            // Fetch updated team data
            final teamResponse = await http.get(
              Uri.parse('${ApiConfig.baseUrl}/teams/$teamId'),
              headers: ApiConfig.headers,
            );
            if (teamResponse.statusCode == 200) {
              final teamData = json.decode(teamResponse.body);
              if (teamData['success'] == true) {
                _teams[teamIndex] = Team.fromJson(teamData['data']);
                notifyListeners();
              }
            }
          }
          return true;
        } else {
          _error = data['error'] ?? 'Error al agregar miembro';
          notifyListeners();
        }
      } else {
        _error = 'Error al agregar miembro: ${response.statusCode}';
        notifyListeners();
      }
      return false;
    } catch (e) {
      _error = 'Error al agregar miembro: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeMember(int teamId, int employeeId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/teams/$teamId/members/$employeeId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final teamIndex = _teams.indexWhere((t) => t.id == teamId);
          if (teamIndex != -1) {
            _teams[teamIndex].members.removeWhere(
              (m) => m.employeeId == employeeId,
            );
            notifyListeners();
          }
          return true;
        } else {
          _error = data['error'] ?? 'Error al remover miembro';
          notifyListeners();
        }
      } else {
        _error = 'Error al remover miembro: ${response.statusCode}';
        notifyListeners();
      }
      return false;
    } catch (e) {
      _error = 'Error al remover miembro: $e';
      notifyListeners();
      return false;
    }
  }

  Team? getTeamById(int teamId) {
    try {
      return _teams.firstWhere((team) => team.id == teamId);
    } catch (e) {
      return null;
    }
  }
}
