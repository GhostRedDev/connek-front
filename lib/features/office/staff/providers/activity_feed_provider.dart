import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/activity_model.dart';
import '../../../../core/config/api_config.dart';

class ActivityFeedProvider with ChangeNotifier {
  List<Activity> _activities = [];
  bool _isLoading = false;
  String? _error;

  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchActivities(int businessId, {int limit = 50}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/activity-feed?business_id=$businessId&limit=$limit',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _activities = (data['data'] as List)
              .map((activity) => Activity.fromJson(activity))
              .toList();
        } else {
          _error = data['error'] ?? 'Error desconocido';
        }
      } else {
        _error = 'Error al cargar actividades: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createActivity({
    required int employeeId,
    required int businessId,
    required String activityType,
    required String content,
    int? relatedTaskId,
    int? relatedTeamId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/activity-feed'),
        headers: ApiConfig.headers,
        body: {
          'employee_id': employeeId.toString(),
          'business_id': businessId.toString(),
          'activity_type': activityType,
          'content': content,
          if (relatedTaskId != null)
            'related_task_id': relatedTaskId.toString(),
          if (relatedTeamId != null)
            'related_team_id': relatedTeamId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final newActivity = Activity.fromJson(data['data']);
          _activities.insert(0, newActivity); // Add to top
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al crear actividad: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchTeamActivities(int teamId, {int limit = 50}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/activity-feed/team/$teamId?limit=$limit',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _activities = (data['data'] as List)
              .map((activity) => Activity.fromJson(activity))
              .toList();
        }
      }
    } catch (e) {
      _error = 'Error al cargar actividades del equipo: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEmployeeActivities(int employeeId, {int limit = 50}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/activity-feed/employee/$employeeId?limit=$limit',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _activities = (data['data'] as List)
              .map((activity) => Activity.fromJson(activity))
              .toList();
        }
      }
    } catch (e) {
      _error = 'Error al cargar actividades del empleado: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
