import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/settings/providers/profile_provider.dart';
import '../../settings/providers/profile_provider.dart' show profileProvider;
import '../services/client_requests_service.dart';

class SendJobRequestDialog extends ConsumerStatefulWidget {
  final int businessId;
  final List<dynamic> businessServices;

  const SendJobRequestDialog({
    super.key,
    required this.businessId,
    required this.businessServices,
  });

  static Future<void> show(
    BuildContext context, {
    required int businessId,
    required List<dynamic> businessServices,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: SendJobRequestDialog(
          businessId: businessId,
          businessServices: businessServices,
        ),
      ),
    );
  }

  @override
  ConsumerState<SendJobRequestDialog> createState() =>
      _SendJobRequestDialogState();
}

class _SendJobRequestDialogState extends ConsumerState<SendJobRequestDialog> {
  final _descController = TextEditingController();
  final _minBudgetController = TextEditingController();
  final _maxBudgetController = TextEditingController();

  bool _isSending = false;
  int? _selectedServiceId;
  List<String> _uploadedFileUrls = const [];

  @override
  void dispose() {
    _descController.dispose();
    _minBudgetController.dispose();
    _maxBudgetController.dispose();
    super.dispose();
  }

  int? _parseBudgetCents(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return null;
    final normalized = v.replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    if (parsed == null || parsed < 0) return null;
    return (parsed * 100).round();
  }

  Future<void> _pickAndUploadImages() async {
    final profile = ref.read(profileProvider).value;
    if (profile == null) return;

    final picker = ImagePicker();
    final images = await picker.pickMultiImage(imageQuality: 85);
    if (images.isEmpty) return;

    final supabase = Supabase.instance.client;
    final newUrls = <String>[];

    for (final img in images) {
      final bytes = await img.readAsBytes();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final path = '${profile.id}/requests/${ts}_${img.name}';

      await supabase.storage
          .from('client')
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );
      final publicUrl = supabase.storage.from('client').getPublicUrl(path);
      newUrls.add(publicUrl);
    }

    if (!mounted) return;
    setState(() {
      _uploadedFileUrls = [..._uploadedFileUrls, ...newUrls];
    });
  }

  Future<void> _send() async {
    final profile = ref.read(profileProvider).value;
    if (profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Necesitas iniciar sesión.')),
      );
      return;
    }

    final desc = _descController.text.trim();
    if (desc.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Describe el trabajo (mínimo 10 caracteres).'),
        ),
      );
      return;
    }

    final minCents = _parseBudgetCents(_minBudgetController.text);
    final maxCents = _parseBudgetCents(_maxBudgetController.text);
    if (_minBudgetController.text.trim().isNotEmpty && minCents == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Presupuesto mínimo inválido.')),
      );
      return;
    }
    if (_maxBudgetController.text.trim().isNotEmpty && maxCents == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Presupuesto máximo inválido.')),
      );
      return;
    }

    setState(() => _isSending = true);
    try {
      final service = ref.read(clientRequestsServiceProvider);
      final ok = await service.createRequest({
        'client_id': profile.id,
        'business_id': widget.businessId,
        'description': desc,
        'is_direct': true,
        if (minCents != null) 'budget_min_cents': minCents,
        if (maxCents != null) 'budget_max_cents': maxCents,
        if (_selectedServiceId != null) 'service_id': _selectedServiceId,
        if (_uploadedFileUrls.isNotEmpty)
          'files': jsonEncode(_uploadedFileUrls),
        if (profile.hasBusiness && profile.businessId != null)
          'obo_business_id': profile.businessId,
      });

      if (!mounted) return;
      if (ok) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solicitud enviada con éxito.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo enviar la solicitud.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = widget.businessServices;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enviar solicitud',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              minLines: 4,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Descripción del trabajo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minBudgetController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Presupuesto mín (opcional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _maxBudgetController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Presupuesto máx (opcional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (services.isNotEmpty)
              DropdownButtonFormField<int>(
                initialValue: _selectedServiceId,
                items: services
                    .whereType<Map>()
                    .map((s) => Map<String, dynamic>.from(s))
                    .map(
                      (s) => DropdownMenuItem<int>(
                        value: (s['id'] as num?)?.toInt(),
                        child: Text((s['name'] ?? 'Servicio').toString()),
                      ),
                    )
                    .where((e) => e.value != null)
                    .cast<DropdownMenuItem<int>>()
                    .toList(),
                onChanged: (v) => setState(() => _selectedServiceId = v),
                decoration: const InputDecoration(
                  labelText: 'Servicio (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _isSending ? null : _pickAndUploadImages,
              icon: const Icon(Icons.attach_file),
              label: Text(
                _uploadedFileUrls.isEmpty
                    ? 'Adjuntar imágenes'
                    : 'Adjuntos: ${_uploadedFileUrls.length}',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isSending
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _send,
                    child: _isSending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Enviar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
