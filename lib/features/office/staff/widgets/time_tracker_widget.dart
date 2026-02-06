import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_tracking_provider.dart';
import '../providers/tasks_provider.dart';

class TimeTrackerWidget extends StatefulWidget {
  final int employeeId;
  final int businessId;

  const TimeTrackerWidget({
    super.key,
    required this.employeeId,
    required this.businessId,
  });

  @override
  State<TimeTrackerWidget> createState() => _TimeTrackerWidgetState();
}

class _TimeTrackerWidgetState extends State<TimeTrackerWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimeTrackingProvider>().fetchRunningTimer(widget.employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<TimeTrackingProvider>(
      builder: (context, provider, child) {
        final runningTimer = provider.runningTimer;

        if (runningTimer == null) {
          return _buildStartTimerButton(context, isDark);
        }

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4F87C9),
                const Color(0xFF4F87C9).withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4F87C9).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Timer Activo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildStatusBadge(runningTimer.status),
                ],
              ),

              const SizedBox(height: 16),

              // Task Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.task_alt, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        runningTimer.task?.title ?? 'Tarea',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Timer Display
              Center(
                child: Text(
                  runningTimer.formattedDuration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Controls
              Row(
                children: [
                  if (runningTimer.isRunning) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pauseTimer(provider, runningTimer.id),
                        icon: const Icon(Icons.pause),
                        label: const Text('Pausar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ] else if (runningTimer.isPaused) ...[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _resumeTimer(provider, runningTimer.id),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Reanudar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4F87C9),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _stopTimer(provider, runningTimer.id),
                      icon: const Icon(Icons.stop),
                      label: const Text('Detener'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStartTimerButton(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => _showStartTimerDialog(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Iniciar Timer'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case 'running':
        color = Colors.green;
        label = 'En curso';
        icon = Icons.play_circle;
        break;
      case 'paused':
        color = Colors.orange;
        label = 'Pausado';
        icon = Icons.pause_circle;
        break;
      default:
        color = Colors.grey;
        label = 'Detenido';
        icon = Icons.stop_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showStartTimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _StartTimerDialog(employeeId: widget.employeeId),
    );
  }

  Future<void> _pauseTimer(TimeTrackingProvider provider, int logId) async {
    await provider.pauseTimer(logId);
  }

  Future<void> _resumeTimer(TimeTrackingProvider provider, int logId) async {
    // Resume is same as start with existing log
    await provider.startTimer(provider.runningTimer!.taskId, widget.employeeId);
  }

  Future<void> _stopTimer(TimeTrackingProvider provider, int logId) async {
    final success = await provider.stopTimer(logId);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Timer detenido exitosamente')),
      );
    }
  }
}

class _StartTimerDialog extends StatefulWidget {
  final int employeeId;

  const _StartTimerDialog({required this.employeeId});

  @override
  State<_StartTimerDialog> createState() => _StartTimerDialogState();
}

class _StartTimerDialogState extends State<_StartTimerDialog> {
  int? _selectedTaskId;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Iniciar Timer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Consumer<TasksProvider>(
              builder: (context, provider, child) {
                final tasks = provider.tasks
                    .where((t) => !t.isCompleted && !t.isCancelled)
                    .toList();

                return DropdownButtonFormField<int>(
                  value: _selectedTaskId,
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar Tarea',
                    border: OutlineInputBorder(),
                  ),
                  items: tasks.map((task) {
                    return DropdownMenuItem(
                      value: task.id,
                      child: Text(task.title),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedTaskId = value);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notas (opcional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _selectedTaskId != null ? _startTimer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F87C9),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Iniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startTimer() async {
    final success = await context.read<TimeTrackingProvider>().startTimer(
      _selectedTaskId!,
      widget.employeeId,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Timer iniciado')));
    }
  }
}
