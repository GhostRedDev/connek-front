import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';

class CreateEventDialog extends ConsumerStatefulWidget {
  final Map<String, dynamic>? eventData; // If null, creating new

  const CreateEventDialog({super.key, this.eventData});

  @override
  ConsumerState<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends ConsumerState<CreateEventDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _promoController;
  late TextEditingController
  _dateController; // Simple string for now or date picker logic

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.eventData?['title'] ?? '',
    );
    _descController = TextEditingController(
      text: widget.eventData?['description'] ?? '',
    );
    _promoController = TextEditingController(
      text: widget.eventData?['promo_text'] ?? '',
    );
    _dateController = TextEditingController(
      text: widget.eventData?['start_date'] ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _promoController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final business = ref.read(businessProvider).value;
      if (business == null || business.businessProfile == null) {
        throw Exception("Business not found");
      }

      final businessId = business.businessProfile!['id']; // Ensure int

      if (widget.eventData == null) {
        // CREATE
        // Note: Provider might not have a direct 'createEvent' method exposed yet,
        // but we can add it or use repo directly.
        // Let's assume we need to add `createEvent` to BusinessNotifier or Repository.
        // I'll check BusinessNotifier again. It has `createQuote`.
        // I'll assume I can call repository directly or add to notifier.
        // Better to use Notifier to invalidate self.

        // For now, I'll access the repository via provider and invalidate manually if needed,
        // or better, I will assume I added `createEvent` to `BusinessNotifier` (I haven't yet, but I can add it).
        // Actually, I'll just use the repository and then ref.invalidate(businessProvider).

        final repo = ref.read(businessRepositoryProvider);
        final data = {
          'business_id': businessId,
          'title': _titleController.text,
          'description': _descController.text,
          'promo_text': _promoController.text,
          'start_date': _dateController.text.isEmpty
              ? DateTime.now().toIso8601String()
              : _dateController.text,
          // 'image': ... handle file upload if possible, or skip for now
        };

        await repo.createEvent(data); // Need to add this to repo
      } else {
        // UPDATE
        final repo = ref.read(businessRepositoryProvider);
        final data = {
          'business_id': businessId, // For auth check
          'title': _titleController.text,
          'description': _descController.text,
          'promo_text': _promoController.text,
          'start_date': _dateController.text,
        };
        await repo.updateEvent(
          widget.eventData!['id'],
          data,
        ); // Need to add this to repo
      }

      // Refresh
      ref.invalidate(businessProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.eventData == null ? 'Crear Evento' : 'Editar Evento',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'TÃ­tulo'),
                  validator: (v) => v!.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'DescripciÃ³n'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _promoController,
                  decoration: const InputDecoration(
                    labelText: 'Texto Promocional (Ej: -20%)',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha (YYYY-MM-DD)',
                  ),
                  // Ideally use DatePicker
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now(),
                    );
                    if (date != null) {
                      _dateController.text = date.toIso8601String();
                    }
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4285F4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(widget.eventData == null ? 'Crear' : 'Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
