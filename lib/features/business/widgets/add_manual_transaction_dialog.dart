import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/business_analytics_service.dart';
import '../providers/business_provider.dart';

class AddManualTransactionDialog extends ConsumerStatefulWidget {
  const AddManualTransactionDialog({super.key});

  @override
  ConsumerState<AddManualTransactionDialog> createState() =>
      _AddManualTransactionDialogState();
}

class _AddManualTransactionDialogState
    extends ConsumerState<AddManualTransactionDialog> {
  final _formKey = GlobalKey<FormState>();

  bool _isExpense = false; // false = Income, true = Expense
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _customCategoryController =
      TextEditingController();
  // Reference/Ticket ID field (optional, for tracking)
  final TextEditingController _referenceController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Servicios';
  bool _isLoading = false;

  final List<String> _incomeCategories = [
    'Servicios',
    'Productos',
    'Eventos',
    'Alquiler',
    'Propinas',
    'Otros',
  ];

  final List<String> _expenseCategories = [
    'Suministros',
    'Salarios',
    'Marketing',
    'Alquiler',
    'Impuestos',
    'Mantenimiento',
    'Otros',
  ];

  @override
  void initState() {
    super.initState();
    _updateCategorySelection();
  }

  void _updateCategorySelection() {
    // Reset category if not in the new list
    final List<String> currentList = _isExpense
        ? _expenseCategories
        : _incomeCategories;
    if (!currentList.contains(_selectedCategory)) {
      setState(() {
        _selectedCategory = currentList.first;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _customCategoryController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final businessData = ref.read(businessProvider).value;
      if (businessData?.businessProfile == null) {
        throw Exception("Business profile not loaded");
      }
      final businessId = businessData!.businessProfile!['id'] as int;

      final service = ref.read(businessAnalyticsServiceProvider);

      String finalCategory = _selectedCategory;
      if (_selectedCategory == 'Otros' &&
          _customCategoryController.text.isNotEmpty) {
        finalCategory = _customCategoryController.text;
      }

      // Append Reference to description if present
      String finalDesc = _descriptionController.text;
      if (_referenceController.text.isNotEmpty) {
        finalDesc = "$finalDesc [Ref: ${_referenceController.text}]".trim();
      }

      await service.addManualTransaction(
        businessId: businessId,
        amount: double.parse(_amountController.text),
        type: _isExpense ? 'expense' : 'income',
        category: finalCategory.toLowerCase(),
        description: finalDesc,
        date: _selectedDate.toIso8601String(),
      );

      if (mounted) {
        Navigator.pop(context, true); // Return true to trigger refresh
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine categories based on type
    final List<String> categories = _isExpense
        ? _expenseCategories
        : _incomeCategories;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark ? const Color(0xFF1E222D) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Registrar Movimiento',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Type Selector
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black26 : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpense = false;
                              _updateCategorySelection();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isExpense
                                  ? const Color(0xFF02d39a)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Ingreso (+)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: !_isExpense ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpense = true;
                              _updateCategorySelection();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isExpense
                                  ? const Color(0xFFFF5252)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Gasto (-)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _isExpense ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Amount
                TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Monto (\$)',
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Requerido';
                    if (double.tryParse(val) == null) return 'Inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Date Picker
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => _selectedDate = picked);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Fecha',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      DateFormat('dd MMM yyyy').format(_selectedDate),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
                if (_selectedCategory == 'Otros') ...[
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _customCategoryController,
                    decoration: InputDecoration(
                      labelText: 'Especifique Categoría',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),

                // Reference / ID
                TextFormField(
                  controller: _referenceController,
                  decoration: InputDecoration(
                    labelText: 'No. Referencia / Ticket (Opcional)',
                    prefixIcon: const Icon(Icons.receipt),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción / Notas',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 32),

                // Submit Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isExpense
                        ? const Color(0xFFFF5252)
                        : const Color(0xFF02d39a),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Guardar ${_isExpense ? "Gasto" : "Ingreso"}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
