import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/time_log_model.dart';
import '../../../../core/config/api_config.dart';
import 'dart:async';

class TimeTrackingProvider with ChangeNotifier {
  TimeLog? _runningTimer;
  List<TimeLog> _timeLogs = [];
  bool _isLoading = false;
  String? _error;
  Timer? _updateTimer;

  TimeLog? get runningTimer => _runningTimer;
  List<TimeLog> get timeLogs => _timeLogs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasRunningTimer => _runningTimer != null;

  Future<void> fetchRunningTimer(int employeeId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/time-tracking/employee/$employeeId/running',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          _runningTimer = TimeLog.fromJson(data['data']);
          _startUpdateTimer();
          notifyListeners();
        }
      }
    } catch (e) {
      _error = 'Error al cargar timer: $e';
      notifyListeners();
    }
  }

  Future<bool> startTimer(int taskId, int employeeId, {String? notes}) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/time-tracking/start'),
        headers: ApiConfig.headers,
        body: {
          'task_id': taskId.toString(),
          'employee_id': employeeId.toString(),
          if (notes != null) 'notes': notes,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _runningTimer = TimeLog.fromJson(data['data']);
          _startUpdateTimer();
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al iniciar timer: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> stopTimer(int logId) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/time-tracking/$logId/stop'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final stoppedLog = TimeLog.fromJson(data['data']);
          _timeLogs.insert(0, stoppedLog);
          _runningTimer = null;
          _stopUpdateTimer();
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al detener timer: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> pauseTimer(int logId) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/time-tracking/$logId/pause'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _runningTimer = TimeLog.fromJson(data['data']);
          _stopUpdateTimer();
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      _error = 'Error al pausar timer: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchTimeLogs(int employeeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/time-tracking/employee/$employeeId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _timeLogs = (data['data'] as List)
              .map((log) => TimeLog.fromJson(log))
              .toList();
        }
      }
    } catch (e) {
      _error = 'Error al cargar logs: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startUpdateTimer() {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners(); // Update UI every second to show running time
    });
  }

  void _stopUpdateTimer() {
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  @override
  void dispose() {
    _stopUpdateTimer();
    super.dispose();
  }
}
