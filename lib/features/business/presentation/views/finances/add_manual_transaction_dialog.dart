import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/features/business/services/business_analytics_service.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';

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
  String _selectedCategory = 'transaction_cat_services'; // Default key
  bool _isLoading = false;

  final List<String> _incomeCategories = [
    'transaction_cat_services',
    'transaction_cat_products',
    'transaction_cat_events',
    'transaction_cat_rent',
    'transaction_cat_tips',
    'transaction_cat_other',
  ];

  final List<String> _expenseCategories = [
    'transaction_cat_supplies',
    'transaction_cat_salaries',
    'transaction_cat_marketing',
    'transaction_cat_rent', // Reused
    'transaction_cat_taxes',
    'transaction_cat_maintenance',
    'transaction_cat_other',
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

    // Get translation for category resolution
    final t = ref.read(translationProvider).value ?? {};

    setState(() => _isLoading = true);

    try {
      final businessData = ref.read(businessProvider).value;
      if (businessData?.businessProfile == null) {
        throw Exception("Business profile not loaded");
      }
      final businessId = businessData!.businessProfile!['id'] as int;

      final service = ref.read(businessAnalyticsServiceProvider);

      String finalCategory = t[_selectedCategory] ?? _selectedCategory;
      if (_selectedCategory == 'transaction_cat_other' &&
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
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
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
                  t['transaction_title'] ?? 'Registrar Movimiento',
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
                              t['transaction_type_income'] ?? 'Ingreso (+)',
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
                              t['transaction_type_expense'] ?? 'Gasto (-)',
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
                    labelText: t['transaction_label_amount'] ?? 'Monto (\$)',
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return t['required_field'] ?? 'Requerido';
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
                      labelText: t['transaction_label_date'] ?? 'Fecha',
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
                    labelText: t['transaction_label_category'] ?? 'Categoría',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: categories
                      .map(
                        (c) =>
                            DropdownMenuItem(value: c, child: Text(t[c] ?? c)),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
                if (_selectedCategory == 'transaction_cat_other') ...[
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _customCategoryController,
                    decoration: InputDecoration(
                      labelText:
                          t['transaction_label_custom_category'] ??
                          'Especifique Categoría',
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
                    labelText:
                        t['transaction_label_reference'] ??
                        'No. Referencia / Ticket (Opcional)',
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
                    labelText:
                        t['transaction_label_description'] ??
                        'Descripción / Notas',
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
                          _isExpense
                              ? (t['transaction_save_expense'] ??
                                    'Guardar Gasto')
                              : (t['transaction_save_income'] ??
                                    'Guardar Ingreso'),
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
