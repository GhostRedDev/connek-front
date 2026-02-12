import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../providers/teams_provider.dart';
import '../models/team_model.dart';

class CreateTeamDialog extends StatefulWidget {
  final int businessId;
  final Team? team; // If editing

  const CreateTeamDialog({super.key, required this.businessId, this.team});

  @override
  State<CreateTeamDialog> createState() => _CreateTeamDialogState();
}

class _CreateTeamDialogState extends State<CreateTeamDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.team?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.team?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.team != null;

    return ShadDialog.alert(
      title: Text(isEditing ? 'Editar equipo' : 'Crear equipo'),
      description: Form(
        key: _formKey,
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLabel(
                text: 'Nombre del equipo',
                isRequired: true,
                child: AppInput.text(
                  controller: _nameController,
                  placeholder: 'Ej. Equipo de ventas',
                ),
              ),
              const SizedBox(height: 12),
              AppLabel(
                text: 'Descripción (opcional)',
                child: AppInput.area(
                  controller: _descriptionController,
                  placeholder: '¿Qué hace este equipo?',
                  minLines: 3,
                  maxLines: 6,
                ),
              ),
              if (_isLoading) ...[
                const SizedBox(height: 12),
                const LinearProgressIndicator(minHeight: 2),
              ],
            ],
          ),
        ),
      ),
      actions: [
        ShadButton.outline(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ShadButton(
          onPressed: _isLoading ? null : _handleSubmit,
          child: Text(isEditing ? 'Guardar' : 'Crear'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      await AppDialog.alert(
        context,
        title: 'Falta información',
        description: 'Ingresa un nombre para el equipo.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final provider = context.read<TeamsProvider>();

      final bool success;
      if (widget.team != null) {
        success = await provider.updateTeam(
          widget.team!.id,
          name,
          _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        );
      } else {
        success = await provider.createTeam(
          widget.businessId,
          name,
          _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        );
      }

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pop();
        await AppDialog.alert(
          context,
          title: 'Listo',
          description: widget.team != null
              ? 'Equipo actualizado correctamente.'
              : 'Equipo creado correctamente.',
        );
      } else {
        await AppDialog.alert(
          context,
          title: 'Error',
          description: provider.error ?? 'No se pudo guardar el equipo.',
        );
      }
    } catch (e) {
      if (mounted) {
        await AppDialog.alert(
          context,
          title: 'Error',
          description: 'No se pudo guardar el equipo: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
