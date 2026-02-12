import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';

class ResourceAssignmentDialog extends StatefulWidget {
  final int businessId;
  final Map<String, dynamic> resource;
  final BusinessRepository repo;

  const ResourceAssignmentDialog({
    super.key,
    required this.businessId,
    required this.resource,
    required this.repo,
  });

  @override
  State<ResourceAssignmentDialog> createState() =>
      _ResourceAssignmentDialogState();
}

class _ResourceAssignmentDialogState extends State<ResourceAssignmentDialog> {
  bool _isLoading = true;
  String? _error;

  List<Map<String, dynamic>> _employees = const [];
  List<Map<String, dynamic>> _teams = const [];

  String _assigneeType = 'employee';
  int? _assigneeId;
  bool _isSaving = false;

  Map<String, dynamic>? _activeAssignment;
  List<Map<String, dynamic>> _usage = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  int get _resourceId => (widget.resource['id'] as num).toInt();

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await Future.wait([
        widget.repo.getEmployees(widget.businessId),
        widget.repo.getTeams(widget.businessId),
        widget.repo
            .getActiveResourceAssignment(_resourceId)
            .then((a) => a == null ? <Map<String, dynamic>>[] : [a]),
        widget.repo.getResourceUsageLogs(_resourceId),
      ]);

      final employees = results[0] as List<Map<String, dynamic>>;
      final teams = results[1] as List<Map<String, dynamic>>;
      final activeAssignmentList = results[2] as List<Map<String, dynamic>>;
      final usage = results[3] as List<Map<String, dynamic>>;

      setState(() {
        _employees = employees;
        _teams = teams;
        _activeAssignment = activeAssignmentList.isNotEmpty
            ? activeAssignmentList.first
            : null;
        _usage = usage;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = (widget.resource['name'] ?? 'Recurso').toString();
    final type = (widget.resource['resource_type'] ?? 'Otro').toString();

    Widget content;

    if (_isLoading) {
      content = const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (_error != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          AppButton.outline(
            text: 'Reintentar',
            icon: Icons.refresh,
            onPressed: _load,
          ),
        ],
      );
    } else {
      content = SizedBox(
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AppBadge.secondary(type),
                if (_activeAssignment == null)
                  AppBadge.outline('Sin asignación')
                else
                  AppBadge.secondary('Asignado'),
              ],
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(12),
              title: 'Asignación',
              description: 'Asigna este recurso a un empleado o a un equipo.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLabel(
                    text: 'Tipo',
                    isRequired: true,
                    child: ShadSelect<String>(
                      placeholder: const Text('Seleccionar'),
                      selectedOptionBuilder: (context, value) {
                        return Text(value == 'team' ? 'Equipo' : 'Empleado');
                      },
                      initialValue: _assigneeType,
                      options: const [
                        ShadOption(value: 'employee', child: Text('Empleado')),
                        ShadOption(value: 'team', child: Text('Equipo')),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _assigneeType = value;
                          _assigneeId = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppLabel(
                    text: _assigneeType == 'employee' ? 'Empleado' : 'Equipo',
                    isRequired: true,
                    child: ShadSelect<int>(
                      placeholder: Text(
                        _assigneeType == 'employee'
                            ? 'Seleccionar empleado'
                            : 'Seleccionar equipo',
                      ),
                      selectedOptionBuilder: (context, value) {
                        final list = _assigneeType == 'employee'
                            ? _employees
                            : _teams;

                        for (final item in list) {
                          final id = (item['id'] as num?)?.toInt();
                          if (id == value) {
                            return Text(
                              (item['name'] ?? 'Seleccionado').toString(),
                            );
                          }
                        }

                        return const Text('Seleccionado');
                      },
                      initialValue: _assigneeId,
                      options: _assigneeType == 'employee'
                          ? _employees
                                .map(
                                  (e) => ShadOption<int>(
                                    value: (e['id'] as num).toInt(),
                                    child: Text(
                                      (e['name'] ?? 'Empleado').toString(),
                                    ),
                                  ),
                                )
                                .toList()
                          : _teams
                                .map(
                                  (t) => ShadOption<int>(
                                    value: (t['id'] as num).toInt(),
                                    child: Text(
                                      (t['name'] ?? 'Equipo').toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                      onChanged: (value) => setState(() => _assigneeId = value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton.primary(
                          text: 'Asignar',
                          icon: Icons.assignment_ind_outlined,
                          onPressed: _isSaving ? null : _handleAssign,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton.outline(
                          text: 'Desasignar',
                          icon: Icons.link_off_outlined,
                          onPressed: _isSaving ? null : _handleUnassign,
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
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(12),
              title: 'Historial',
              description: 'Eventos recientes del recurso.',
              child: _usage.isEmpty
                  ? Text(
                      'Sin eventos todavía.',
                      style: theme.textTheme.bodyMedium,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _usage.take(8).map((row) {
                        final action = (row['action'] ?? '').toString();
                        final createdAt = (row['created_at'] ?? '').toString();
                        final notes = (row['notes'] ?? '').toString();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppBadge.outline(
                                action.isEmpty ? 'evento' : action,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      createdAt,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    if (notes.trim().isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        notes,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      );
    }

    return ShadDialog.alert(
      title: Text('Asignar: $name'),
      description: content,
      actions: [
        ShadButton.outline(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  Future<void> _handleAssign() async {
    if (_assigneeId == null) {
      await AppDialog.alert(
        context,
        title: 'Falta información',
        description: 'Selecciona a quién asignar este recurso.',
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final result = await widget.repo.assignResource(
        businessId: widget.businessId,
        resourceId: _resourceId,
        assigneeType: _assigneeType,
        assigneeId: _assigneeId!,
      );

      if (result == null) {
        await AppDialog.alert(
          context,
          title: 'No se pudo asignar',
          description: 'Intenta de nuevo.',
        );
      } else {
        await _load();
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _handleUnassign() async {
    final ok = await AppDialog.confirm(
      context,
      title: 'Desasignar recurso',
      description: 'Esto quitará la asignación activa (si existe).',
      confirmText: 'Desasignar',
      isDestructive: true,
    );

    if (!ok) return;

    setState(() => _isSaving = true);

    try {
      final success = await widget.repo.unassignResource(
        businessId: widget.businessId,
        resourceId: _resourceId,
      );

      if (!success) {
        await AppDialog.alert(
          context,
          title: 'No se pudo desasignar',
          description: 'Intenta de nuevo.',
        );
      } else {
        await _load();
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
