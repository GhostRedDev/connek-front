import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import '../providers/teams_provider.dart';

class AddMemberDialog extends StatefulWidget {
  final int teamId;
  final int businessId;

  const AddMemberDialog({
    super.key,
    required this.teamId,
    required this.businessId,
  });

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  List<Map<String, dynamic>> _employees = [];
  bool _isLoading = true;
  String? _error;
  int? _selectedEmployeeId;
  String _selectedRole = 'member';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final client = Supabase.instance.client;

      // Some environments store status as 'Activo', others as 'Active'/'active',
      // and sometimes the column might be missing or unreliable. Prefer showing
      // employees over blocking the flow.
      dynamic response;

      try {
        response = await client
            .from('employees')
            .select()
            .eq('business_id', widget.businessId)
            .inFilter('status', const ['Activo', 'Active', 'active'])
            .order('name', ascending: true);
      } catch (_) {
        response = [];
      }

      if (response is! List || response.isEmpty) {
        response = await client
            .from('employees')
            .select()
            .eq('business_id', widget.businessId)
            .order('name', ascending: true);
      }

      setState(() {
        _employees = List<Map<String, dynamic>>.from(response);
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
    final colorScheme = theme.colorScheme;

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
          Icon(Icons.error_outline, size: 40, color: colorScheme.error),
          const SizedBox(height: 12),
          Text(
            _error!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          AppButton.outline(
            text: 'Reintentar',
            icon: Icons.refresh,
            onPressed: _loadEmployees,
          ),
        ],
      );
    } else if (_employees.isEmpty) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline,
            size: 40,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            'No hay empleados activos disponibles',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      );
    } else {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabel(
            text: 'Empleado',
            isRequired: true,
            child: ShadSelect<int>(
              placeholder: const Text('Seleccionar empleado'),
              initialValue: _selectedEmployeeId,
              onChanged: (value) => setState(() => _selectedEmployeeId = value),
              options: _employees
                  .where((e) => e['id'] is num && (e['id'] as num).toInt() > 0)
                  .map((employee) {
                    final id = (employee['id'] as num).toInt();
                    final name = (employee['name'] ?? 'Unknown').toString();
                    final role = (employee['role'] ?? '').toString();
                    final image = employee['image']?.toString();
                    final isBot = employee['type'] == 'bot';

                    return ShadOption<int>(
                      value: id,
                      child: Row(
                        children: [
                          AppAvatar(
                            src: image,
                            alt: name,
                            size: 28,
                            backgroundColor: ShadTheme.of(
                              context,
                            ).colorScheme.muted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (role.isNotEmpty)
                                  Text(
                                    role,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  )
                                else
                                  Text(
                                    isBot ? 'Bot' : 'Empleado',
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                  .toList(),
              selectedOptionBuilder: (context, value) {
                final selected = _employees
                    .cast<Map<String, dynamic>>()
                    .where(
                      (e) =>
                          e['id'] is num && (e['id'] as num).toInt() == value,
                    )
                    .toList();
                final name = selected.isNotEmpty
                    ? (selected.first['name'] ?? 'Unknown').toString()
                    : 'Seleccionar empleado';
                return Text(name);
              },
            ),
          ),
          const SizedBox(height: 12),
          AppLabel(
            text: 'Rol en el equipo',
            child: ShadSelect<String>(
              placeholder: const Text('Seleccionar rol'),
              initialValue: _selectedRole,
              onChanged: (value) =>
                  setState(() => _selectedRole = value ?? 'member'),
              options: const [
                ShadOption<String>(
                  value: 'member',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 16),
                      SizedBox(width: 8),
                      Text('Miembro'),
                    ],
                  ),
                ),
                ShadOption<String>(
                  value: 'leader',
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 16),
                      SizedBox(width: 8),
                      Text('Líder'),
                    ],
                  ),
                ),
              ],
              selectedOptionBuilder: (context, value) {
                return Text(value == 'leader' ? 'Líder' : 'Miembro');
              },
            ),
          ),
          if (_isSaving) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(minHeight: 2),
          ],
        ],
      );
    }

    return ShadDialog.alert(
      title: const Text('Agregar miembro al equipo'),
      description: SizedBox(width: 420, child: content),
      actions: [
        ShadButton.outline(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ShadButton(
          onPressed: _isSaving || _selectedEmployeeId == null
              ? null
              : _handleAddMember,
          child: const Text('Agregar'),
        ),
      ],
    );
  }

  Future<void> _handleAddMember() async {
    if (_selectedEmployeeId == null) return;

    setState(() => _isSaving = true);

    try {
      final success = await context.read<TeamsProvider>().addMember(
        widget.teamId,
        _selectedEmployeeId!,
        _selectedRole,
      );

      if (success && mounted) {
        Navigator.of(context).pop();
        await AppDialog.alert(
          context,
          title: 'Listo',
          description: 'Miembro agregado exitosamente.',
        );
      } else if (mounted) {
        await AppDialog.alert(
          context,
          title: 'Error',
          description: 'Error al agregar miembro.',
        );
      }
    } catch (e) {
      if (mounted) {
        await AppDialog.alert(
          context,
          title: 'Error',
          description: 'Error: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
