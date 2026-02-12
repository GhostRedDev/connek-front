import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';
import '../../../../core/config/api_config.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Kanban columns
  List<Task> get pendingTasks =>
      _tasks.where((t) => t.status == 'pending').toList();
  List<Task> get inProgressTasks =>
      _tasks.where((t) => t.status == 'in_progress').toList();
  List<Task> get completedTasks =>
      _tasks.where((t) => t.status == 'completed').toList();

  Future<void> fetchTasks(int businessId, {String? status, int? teamId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      var url = '${ApiConfig.baseUrl}/tasks?business_id=$businessId';
      if (status != null) url += '&status=$status';
      if (teamId != null) url += '&team_id=$teamId';

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _tasks = (data['data'] as List)
              .map((task) => Task.fromJson(task))
              .toList();
        } else {
          _error = data['error'] ?? 'Error desconocido';
        }
      } else {
        _error = 'Error al cargar tareas: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTask({
    required int businessId,
    required String title,
    String? description,
    int? teamId,
    String priority = 'medium',
    double? estimatedHours,
    DateTime? dueDate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/tasks'),
        headers: ApiConfig.headers,
        body: {
          'business_id': businessId.toString(),
          'title': title,
          if (description != null) 'description': description,
          if (teamId != null) 'team_id': teamId.toString(),
          'priority': priority,
          if (estimatedHours != null)
            'estimated_hours': estimatedHours.toString(),
          if (dueDate != null) 'due_date': dueDate.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final newTask = Task.fromJson(data['data']);
          _tasks.add(newTask);
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al crear tarea: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTaskStatus(int taskId, String newStatus) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId'),
        headers: ApiConfig.headers,
        body: {'status': newStatus},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
          if (taskIndex != -1) {
            _tasks[taskIndex] = Task.fromJson(data['data']);
            notifyListeners();
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al actualizar tarea: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> assignTask(int taskId, int employeeId) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId/assign'),
        headers: ApiConfig.headers,
        body: {'employee_id': employeeId.toString()},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          // Refresh task
          final taskResponse = await http.get(
            Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId'),
            headers: ApiConfig.headers,
          );
          if (taskResponse.statusCode == 200) {
            final taskData = json.decode(taskResponse.body);
            if (taskData['success'] == true) {
              final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
              if (taskIndex != -1) {
                _tasks[taskIndex] = Task.fromJson(taskData['data']);
                notifyListeners();
              }
            }
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al asignar tarea: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeTask(int taskId) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/tasks/$taskId/complete'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
          if (taskIndex != -1) {
            _tasks[taskIndex] = Task.fromJson(data['data']);
            notifyListeners();
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al completar tarea: $e';
      notifyListeners();
      return false;
    }
  }

  Task? getTaskById(int taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }
}
