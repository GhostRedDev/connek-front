import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/evaluation_model.dart';
import '../../../../core/config/api_config.dart';

class EvaluationsProvider with ChangeNotifier {
  List<Evaluation> _evaluations = [];
  EmployeeRating? _employeeRating;
  bool _isLoading = false;
  String? _error;

  List<Evaluation> get evaluations => _evaluations;
  EmployeeRating? get employeeRating => _employeeRating;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEvaluations(int employeeId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/evaluations/employee/$employeeId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _evaluations = (data['data'] as List)
              .map((eval) => Evaluation.fromJson(eval))
              .toList();
        } else {
          _error = data['error'] ?? 'Error desconocido';
        }
      } else {
        _error = 'Error al cargar evaluaciones: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error de conexión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEmployeeRating(int employeeId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/evaluations/employee/$employeeId/rating',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _employeeRating = EmployeeRating.fromJson(data['data']);
          notifyListeners();
        }
      }
    } catch (e) {
      _error = 'Error al cargar rating: $e';
      notifyListeners();
    }
  }

  Future<bool> createEvaluation({
    required int employeeId,
    required int evaluatorId,
    required int rating,
    String? comment,
    int? relatedTaskId,
    int? relatedActivityId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/evaluations'),
        headers: ApiConfig.headers,
        body: {
          'employee_id': employeeId.toString(),
          'evaluator_id': evaluatorId.toString(),
          'rating': rating.toString(),
          if (comment != null) 'comment': comment,
          if (relatedTaskId != null)
            'related_task_id': relatedTaskId.toString(),
          if (relatedActivityId != null)
            'related_activity_id': relatedActivityId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final newEvaluation = Evaluation.fromJson(data['data']);
          _evaluations.insert(0, newEvaluation);
          // Refresh rating
          await fetchEmployeeRating(employeeId);
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al crear evaluación: $e';
      notifyListeners();
      return false;
    }
  }
}
