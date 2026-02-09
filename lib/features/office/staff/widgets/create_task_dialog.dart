import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:connek_frontend/system_ui/system_ui.dart' hide AppDatePicker;
import 'package:connek_frontend/system_ui/form/date_pickers.dart'
    show AppDatePicker;
import '../providers/tasks_provider.dart';

class CreateTaskDialog extends StatefulWidget {
  final int businessId;

  const CreateTaskDialog({super.key, required this.businessId});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _estimatedHoursController = TextEditingController();
  String _priority = 'medium';
  DateTime? _dueDate;
  double? _estimatedHours;
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _estimatedHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final priorityOptions = const <String, String>{
      'low': '⚪ Baja',
      'medium': '🟢 Media',
      'high': '🟡 Alta',
      'urgent': '🔴 Urgente',
    };

    return ShadDialog.alert(
      title: const Row(
        children: [
          Icon(Icons.add_task, size: 20),
          SizedBox(width: 10),
          Text('Nueva tarea'),
        ],
      ),
      description: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLabel(
              text: 'Título',
              isRequired: true,
              child: AppInput.text(
                controller: _titleController,
                placeholder: 'Ej. Llamar al cliente',
              ),
            ),
            const SizedBox(height: 12),
            AppLabel(
              text: 'Descripción (opcional)',
              child: AppInput.area(
                controller: _descriptionController,
                placeholder: 'Detalles de la tarea…',
                minLines: 3,
                maxLines: 6,
              ),
            ),
            const SizedBox(height: 12),
            AppLabel(
              text: 'Prioridad',
              child: AppSelect<String>(
                value: _priority,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() => _priority = v);
                },
                options: priorityOptions,
                placeholder: 'Seleccionar prioridad',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppDatePicker(
                    value: _dueDate,
                    onValueChange: (v) => setState(() => _dueDate = v),
                    label: 'Fecha límite (opcional)',
                    placeholder: 'Seleccionar',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppLabel(
                    text: 'Horas estimadas (opcional)',
                    child: AppInput.text(
                      controller: _estimatedHoursController,
                      placeholder: 'Ej. 2.5',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (value) {
                        final parsed = double.tryParse(value);
                        _estimatedHours = parsed;
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_isSaving) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(minHeight: 2),
            ],
          ],
        ),
      ),
      actions: [
        AppButton.outline(
          text: 'Cancelar',
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
        ),
        AppButton.primary(
          text: 'Crear',
          icon: Icons.check,
          isLoading: _isSaving,
          onPressed: _isSaving ? null : _createTask,
        ),
      ],
    );
  }

  Future<void> _createTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      await AppDialog.alert(
        context,
        title: 'Falta información',
        description: 'El título es requerido.',
      );
      return;
    }

    setState(() => _isSaving = true);

    final success = await context.read<TasksProvider>().createTask(
      businessId: widget.businessId,
      title: title,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      priority: _priority,
      estimatedHours: _estimatedHours,
      dueDate: _dueDate,
    );

    if (success && mounted) {
      Navigator.pop(context);
      await AppDialog.alert(
        context,
        title: 'Listo',
        description: 'Tarea creada exitosamente.',
      );
    } else if (mounted) {
      await AppDialog.alert(
        context,
        title: 'Error',
        description: 'Error al crear tarea.',
      );
    }

    if (mounted) {
      setState(() => _isSaving = false);
    }
  }
}
