import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../providers/business_provider.dart';
import '../../leads/models/lead_model.dart';

class BusinessProposalSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? quoteToEdit;
  final Lead? prefilledLead;

  const BusinessProposalSheet({
    super.key,
    this.quoteToEdit,
    this.prefilledLead,
  });

  @override
  ConsumerState<BusinessProposalSheet> createState() =>
      _BusinessProposalSheetState();
}

class _BusinessProposalSheetState extends ConsumerState<BusinessProposalSheet> {
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;

  // Selection
  Lead? _selectedLead;
  Map<String, dynamic>? _selectedService;

  @override
  void initState() {
    super.initState();
    if (widget.quoteToEdit != null) {
      final q = widget.quoteToEdit!;
      final amountCents = q['amountCents'] ?? 0;
      _amountController.text = (amountCents / 100).toStringAsFixed(2);
      _descController.text = q['description'] ?? '';

      if (q['expiring'] != null) {
        _selectedDate = DateTime.tryParse(q['expiring']);
      }
    } else if (widget.prefilledLead != null) {
      // Prefill Logic
      _selectedLead = widget.prefilledLead;
      // Note: We can triggers _selectedService logic after build or here if we have access to services.
      // But services come from provider in build.
      // So we handle auto-selection in build or listener if we want it perfect.
      // For simplicity, we just set _selectedLead and let user confirm details,
      // or we can try to find service in build if _selectedService is null.
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1D21) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final inputFillColor = isDark
        ? const Color(0xFF2C3036)
        : const Color(0xFFF5F5F5);

    final businessData = ref.watch(businessProvider).value;
    final leads = businessData?.recentLeads ?? [];
    final services = businessData?.services ?? [];

    // Auto-select Service logic if prefilled
    if (_selectedLead != null &&
        _selectedService == null &&
        services.isNotEmpty) {
      if (_selectedLead!.serviceId > 0) {
        try {
          _selectedService = services.firstWhere(
            (s) => s['id'] == _selectedLead!.serviceId,
          );
          // Auto-fill defaults
          if (_selectedService != null) {
            final price = _selectedService!['price_cents'] ?? 0;
            if (price > 0 && _amountController.text.isEmpty) {
              _amountController.text = (price / 100).toStringAsFixed(2);
            }
            if (_descController.text.isEmpty) {
              _descController.text =
                  "Propuesta para ${_selectedService!['name']}";
            }
          }
        } catch (_) {}
      }
    }

    // Filter leads that don't have a proposal sent?
    // Or just show all. For now show all.

    // If Editing, we can't change Lead, so no dropdown needed for Lead.
    final isEditing = widget.quoteToEdit != null;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 8,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                  isDark: isDark,
                ),
                Text(
                  isEditing ? 'Editar Propuesta' : 'Nueva Propuesta',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                _buildCircleButton(
                  icon: Icons.check,
                  onTap: _saveProposal,
                  isDark: isDark,
                  color: const Color(0xFF4285F4),
                  iconColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 24),

            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isEditing) ...[
                      // Select Lead
                      _buildLabel('Seleccionar Cliente (Lead)', context),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: inputFillColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Lead>(
                            value: _selectedLead,
                            hint: Text(
                              'Seleccione un lead',
                              style: GoogleFonts.inter(color: Colors.grey),
                            ),
                            isExpanded: true,
                            dropdownColor: backgroundColor,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: textColor,
                            ),
                            style: GoogleFonts.inter(color: textColor),
                            items: leads.map((lead) {
                              return DropdownMenuItem<Lead>(
                                value: lead,
                                child: Text(
                                  '${lead.clientFirstName} ${lead.clientLastName} - ${lead.requestDescription}', // Assuming description is short enough
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedLead = val;
                                // Try to auto-select service
                                if (val != null && val.serviceId > 0) {
                                  try {
                                    _selectedService = services.firstWhere(
                                      (s) => s['id'] == val.serviceId,
                                    );
                                    // Auto-fill price if available
                                    if (_selectedService != null) {
                                      final price =
                                          _selectedService!['price_cents'] ?? 0;
                                      if (price > 0 &&
                                          _amountController.text.isEmpty) {
                                        _amountController.text = (price / 100)
                                            .toStringAsFixed(2);
                                      }
                                      if (_descController.text.isEmpty) {
                                        _descController.text =
                                            "Propuesta para ${_selectedService!['name']}";
                                      }
                                    }
                                  } catch (e) {
                                    // Service not found in list
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Select Service (Visible if not auto-selected or user wants to change?)
                      // For now allow changing it
                      _buildLabel('Servicio', context),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: inputFillColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Map<String, dynamic>>(
                            value: _selectedService,
                            hint: Text(
                              'Seleccione un servicio',
                              style: GoogleFonts.inter(color: Colors.grey),
                            ),
                            isExpanded: true,
                            dropdownColor: backgroundColor,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: textColor,
                            ),
                            style: GoogleFonts.inter(color: textColor),
                            items: services.map((s) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: s,
                                child: Text(s['name'] ?? 'Servicio'),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedService = val;
                                // Auto-fill
                                if (val != null) {
                                  final price = val['price_cents'] ?? 0;
                                  if (price > 0 &&
                                      _amountController.text.isEmpty) {
                                    _amountController.text = (price / 100)
                                        .toStringAsFixed(2);
                                  }
                                  if (_descController.text.isEmpty) {
                                    _descController.text =
                                        "Propuesta para ${val['name']}";
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Amount
                    _buildLabel('Monto (\$)', context),
                    _buildTextField(
                      controller: _amountController,
                      hint: '0.00',
                      fillColor: inputFillColor,
                      textColor: textColor,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    _buildLabel('Descripción', context),
                    _buildTextField(
                      controller: _descController,
                      hint: 'Detalles de la propuesta...',
                      fillColor: inputFillColor,
                      textColor: textColor,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Expiration Date
                    _buildLabel('Fecha de Expiración', context),
                    GestureDetector(
                      onTap: () async {
                        final now = DateTime.now();
                        final result = await showDatePicker(
                          context: context,
                          initialDate:
                              _selectedDate ?? now.add(const Duration(days: 7)),
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 365)),
                        );
                        if (result != null) {
                          setState(() => _selectedDate = result);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: inputFillColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? DateFormat(
                                      'dd MMM yyyy',
                                    ).format(_selectedDate!)
                                  : 'Seleccionar fecha',
                              style: GoogleFonts.inter(
                                color: _selectedDate != null
                                    ? textColor
                                    : Colors.grey,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: textColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0xFF1A1D21),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required Color fillColor,
    required Color textColor,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    Color? color,
    Color? iconColor,
    double size = 40,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? (isDark ? Colors.white10 : Colors.grey[200]),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor ?? (isDark ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Future<void> _saveProposal() async {
    if (!_formKey.currentState!.validate()) return;

    // Parse Amount
    final amountDouble = double.tryParse(_amountController.text) ?? 0.0;
    final amountCents = (amountDouble * 100).toInt();

    final payload = {
      'amountCents': amountCents,
      'description': _descController.text.trim(),
    };

    if (_selectedDate != null) {
      payload['expiring'] = _selectedDate!.toIso8601String();
    }

    final notifier = ref.read(businessProvider.notifier);
    bool success = false;

    if (widget.quoteToEdit != null) {
      // Edit
      final quoteId = widget.quoteToEdit!['id'];
      final res = await notifier.updateQuote(quoteId, payload);
      success = res != null;
    } else {
      // Create
      if (_selectedLead == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un cliente/lead')),
        );
        return;
      }
      if (_selectedService == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un servicio')),
        );
        return;
      }

      payload['lead_id'] = _selectedLead!.id;
      payload['service_id'] = _selectedService!['id'];

      final res = await notifier.createQuote(payload);
      success = res != null;
    }

    if (mounted) {
      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.quoteToEdit != null
                  ? 'Propuesta actualizada'
                  : 'Propuesta creada',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la propuesta')),
        );
      }
    }
  }
}
