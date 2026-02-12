import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../settings/providers/profile_provider.dart';
import 'services/client_requests_service.dart';
import 'providers/client_requests_provider.dart';

class CreateRequestPage extends ConsumerStatefulWidget {
  const CreateRequestPage({super.key});

  @override
  ConsumerState<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends ConsumerState<CreateRequestPage> {
  final _descriptionController = TextEditingController();
  final _maxBudgetController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _maxBudgetController.dispose();
    super.dispose();
  }

  int? _parseBudgetCents(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return null;
    final normalized = value.replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    if (parsed == null) return null;
    if (parsed < 0) return null;
    return (parsed * 100).round();
  }

  Future<void> _submit() async {
    final profile = ref.read(profileProvider).value;
    if (profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Necesitas iniciar sesión.')),
      );
      return;
    }

    final description = _descriptionController.text.trim();
    if (description.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Describe el trabajo (mínimo 10 caracteres).'),
        ),
      );
      return;
    }

    final maxBudgetCents = _parseBudgetCents(_maxBudgetController.text);
    if (_maxBudgetController.text.trim().isNotEmpty && maxBudgetCents == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Presupuesto máximo inválido.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final service = ref.read(clientRequestsServiceProvider);
      final ok = await service.createRequest({
        'client_id': profile.id,
        'description': description,
        'is_direct': false,
        if (maxBudgetCents != null) 'budget_max_cents': maxBudgetCents,
      });

      if (!mounted) return;

      if (ok) {
        ref.invalidate(clientRequestsProvider);
        context.go('/client/dashboard/requests');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo publicar el trabajo.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publicar trabajo')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: _descriptionController,
              minLines: 4,
              maxLines: 8,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                labelText: 'Descripción del trabajo',
                hintText:
                    'Ej: Necesito arreglar 3 closets. Busco el menor precio posible.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _maxBudgetController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Presupuesto máximo (opcional)',
                hintText: 'Ej: 250',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isSaving ? null : _submit,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.publish_outlined),
              label: Text(_isSaving ? 'Publicando...' : 'Publicar'),
            ),
          ],
        ),
      ),
    );
  }
}
