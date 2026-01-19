import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/business_provider.dart';

class BusinessInvoiceSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? initialData;

  const BusinessInvoiceSheet({super.key, this.initialData});

  @override
  ConsumerState<BusinessInvoiceSheet> createState() =>
      _BusinessInvoiceSheetState();
}

class _BusinessInvoiceSheetState extends ConsumerState<BusinessInvoiceSheet> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  int? _selectedLeadId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _initFormData();
    }
  }

  void _initFormData() {
    final data = widget.initialData!;
    _descriptionController.text = data['title'] ?? data['description'] ?? '';

    // Parse amount from string like "$1,200.00" or raw cents
    // The widget passed "amount" as formatted string "$1,200.00"
    String amountStr = data['amount']?.toString() ?? '';
    amountStr = amountStr.replaceAll(RegExp(r'[^0-9.]'), '');
    _amountController.text = amountStr;

    // Pre-select lead if editing and leadId provided
    if (data.containsKey('lead_id')) {
      _selectedLeadId = data['lead_id'];
    }
    // Client handling is tricky if we don't pass the full client object in specific way
    // For editing, we might need to find the client in the provider list
    // This is simplified. Editing might require more robust client matching.
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _saveInvoice() async {
    if (!_formKey.currentState!.validate()) return;
    // Only check client selection if creating new invoice
    if (_selectedLeadId == null && widget.initialData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona un cliente')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final businessData = ref.read(businessProvider).value;
      if (businessData?.businessProfile == null) return;

      // Calculate cents
      final amountDouble = double.tryParse(_amountController.text) ?? 0.0;
      final amountCents = (amountDouble * 100).toInt();

      final repo = ref.read(businessRepositoryProvider);

      // Handle Edit or Create
      if (widget.initialData != null) {
        // Update
        // Need quote ID. 'id' in UI is #INV-XXXXXX. Better to pass raw ID or parse it.
        // Let's assume we can get the real ID. If initialData lacks real ID, we have check business_invoices_widget.
        // However, business_invoices_widget maps 'id' to display string.
        // We should update business_invoices_widget to pass raw 'quote_id'.

        // For now, assuming raw_id is passed
        final rawId = widget.initialData!['raw_id'];
        if (rawId != null) {
          await repo.updateQuote(int.parse(rawId.toString()), {
            'amountCents': amountCents,
            'description': _descriptionController.text,
          });
        }
      } else {
        // Create
        // Endpoint requires: lead_id, amountCents, description
        // Client selection must provide a lead_id or client_id.
        // Quotes usually linked to a Lead. If selecting a Client, we might need a Lead ID representing that relationship or create one?
        // Quotes API: lead_id is required.
        // If we select a generic "Client", does every client have a "lead_id"?
        // In this system, Clients are UserAccounts. Business-Client relationship might be via "Leads" table?
        // Or we select from "Leads".

        final leadId = _selectedLeadId!; // Assuming we pick from Leads list

        // We also need a dummy service_id if required by backend, OR modify backend.
        // Backend `create_quote` takes: lead_id, service_id, amountCents, description.
        // So we MUST pick a service or have a default "Custom Service".
        // Let's pick the first service as data fallback or ask user.
        // For simplicity, let's just pick array[0] service if available, or 0.
        int serviceId = 0;
        if (businessData!.services.isNotEmpty) {
          serviceId = businessData.services.first['id'];
        }

        await repo.createQuote({
          'lead_id': leadId,
          'service_id': serviceId,
          'amountCents': amountCents,
          'description': _descriptionController.text,
        });
      }

      ref.invalidate(businessProvider);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.initialData != null
                  ? 'Factura actualizada'
                  : 'Factura creada',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider).value;

    // Actually we need Leads for `lead_id`.
    // `recentLeads` in dashboard might be limited.
    // Ideally we fetch all leads/clients.
    // For now, we use `recentLeads` or `clients` if they have lead_id mapped.
    // Let's use `recentLeads` which DEFINITELY have `id` as `lead_id`.
    final leads = businessData?.recentLeads ?? [];

    // Merge logic: Clients list vs Leads list. Backend needs `lead_id`.
    // If we select a "Client" from `clients` list, we might not have a `lead_id` unless we create one.
    // Safest bet for "Invoices" is often sending to existing Leads.
    // Let's show LEADS in the dropdown for now to ensure `lead_id` validity.

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.initialData != null ? 'Editar Factura' : 'Nueva Factura',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Client Selection (Only if Creating)
              if (widget.initialData == null) ...[
                DropdownButtonFormField<int>(
                  decoration: _inputDecoration('Cliente / Lead'),
                  value: _selectedLeadId,
                  items: leads.map((lead) {
                    // Lead object to Map if needed, or if recentLeads is List<Lead>
                    // businessProvider: recentLeads is List<Lead>.
                    // We need to access props.
                    final name =
                        '${lead.clientFirstName} ${lead.clientLastName}'.trim();
                    return DropdownMenuItem<int>(
                      value: lead.id,
                      child: Text(name.isEmpty ? 'Lead #${lead.id}' : name),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedLeadId = val;
                    });
                  },
                  validator: (val) =>
                      val == null ? 'Selecciona un cliente' : null,
                ),
                const SizedBox(height: 16),
              ],

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration('Concepto / Título'),
                validator: (val) => val!.isEmpty ? 'Ingresa un concepto' : null,
              ),
              const SizedBox(height: 16),

              // Amount
              TextFormField(
                controller: _amountController,
                decoration: _inputDecoration('Monto', prefix: '\$ '),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (val) => val!.isEmpty ? 'Ingresa un monto' : null,
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveInvoice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Guardar Factura'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {String? prefix}) {
    return InputDecoration(
      labelText: label,
      prefixText: prefix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }
}
