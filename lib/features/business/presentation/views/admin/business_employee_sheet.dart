import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/business_provider.dart';
import '../../../../../core/providers/locale_provider.dart';
import '../../../../../core/constants/connek_icons.dart';

class BusinessEmployeeSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? employeeToEdit;

  const BusinessEmployeeSheet({super.key, this.employeeToEdit});

  @override
  ConsumerState<BusinessEmployeeSheet> createState() =>
      _BusinessEmployeeSheetState();
}

class _BusinessEmployeeSheetState extends ConsumerState<BusinessEmployeeSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _customCategoryController = TextEditingController();
  final _imageController = TextEditingController();

  String _selectedCategory = 'Vendedor';
  bool _isActive = true;

  final List<String> _categories = [
    'Gerente',
    'Vendedor',
    'Técnico',
    'Limpieza',
    'Seguridad',
    'Administración',
    'Otro',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.employeeToEdit != null) {
      final e = widget.employeeToEdit!;
      _nameController.text = e['name'] ?? '';
      _imageController.text = e['image'] ?? '';
      _isActive = e['status'] == 'Activo';

      String role = e['role'] ?? 'Vendedor';
      if (_categories.contains(role)) {
        _selectedCategory = role;
      } else {
        _selectedCategory = 'Otro';
        _customCategoryController.text = role;
      }

      // Handle custom category field if needed
      if (e['custom_category'] != null) {
        _selectedCategory = 'Otro';
        _customCategoryController.text = e['custom_category'];
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _customCategoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1D21) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final inputFillColor = isDark
        ? const Color(0xFF2C3036)
        : const Color(0xFFF5F5F5);

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
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
                    icon: ConnekIcons.close,
                    onTap: () => Navigator.pop(context),
                    isDark: isDark,
                  ),
                  Text(
                    widget.employeeToEdit != null
                        ? t['business_employee_sheet_edit_title'] ??
                              'Editar Empleado'
                        : t['business_employee_sheet_add_title'] ??
                              'Añadir Empleado',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  _buildCircleButton(
                    icon: ConnekIcons.check,
                    onTap: _saveEmployee,
                    isDark: isDark,
                    color: const Color(0xFF4285F4),
                    iconColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildLabel(
                t['business_employee_sheet_name_label'] ?? 'Nombre',
                context,
              ),
              _buildTextField(
                controller: _nameController,
                hint: 'Ej: Maria Sanchez', // Name hint usually stays or simple
                fillColor: inputFillColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),

              _buildLabel(
                t['business_employee_sheet_role_label'] ?? 'Categoría / Rol',
                context,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: inputFillColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    dropdownColor: backgroundColor,
                    style: GoogleFonts.inter(color: textColor),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                ),
              ),
              if (_selectedCategory == 'Otro') ...[
                const SizedBox(height: 16),
                _buildLabel(
                  t['business_employee_sheet_custom_role_label'] ??
                      'Especificar Categoría',
                  context,
                ),
                _buildTextField(
                  controller: _customCategoryController,
                  hint: 'Ej: Consultor Externo',
                  fillColor: inputFillColor,
                  textColor: textColor,
                ),
              ],

              const SizedBox(height: 16),
              _buildLabel(
                t['business_employee_sheet_image_label'] ?? 'Imagen (URL)',
                context,
              ),
              _buildTextField(
                controller: _imageController,
                hint: 'https://...',
                fillColor: inputFillColor,
                textColor: textColor,
                isRequired: false,
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t['business_employee_sheet_active_label'] ??
                        'Estado Activo',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Switch(
                    value: _isActive,
                    onChanged: (val) => setState(() => _isActive = val),
                    activeColor: const Color(0xFF4285F4),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
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
    bool isRequired = true,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: textColor),
      validator: (val) => isRequired && (val == null || val.isEmpty)
          ? (ref.read(translationProvider).value?['required_field'] ??
                'Requerido')
          : null, // Access provider via ref passed? No, widget param?
      // Wait, _buildTextField is just a method. It can't access `ref` unless it's in State which it is.
      // But `ref` property is available in `ConsumerState`.
      // Accessing translationProvider here:
      // We can use `ref.read(translationProvider).value?['required_field']` or pass `t` to this method.
      // Passing `t` is cleaner to avoid read in build phase if possible, but validator is callback.
      // In validator `ref.read` is fine.
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

  Future<void> _saveEmployee() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(businessRepositoryProvider);
    final businessData = ref.read(businessProvider).value;

    if (businessData?.businessProfile == null) return;
    final businessId = businessData!.businessProfile!['id'];

    final role = _selectedCategory == 'Otro'
        ? _customCategoryController.text.trim()
        : _selectedCategory;

    final payload = {
      'name': _nameController.text.trim(),
      'role': role,
      'business_id': businessId,
      'status': _isActive ? 'Activo' : 'Inactivo',
      'type': 'human',
      'image': _imageController.text.isNotEmpty
          ? _imageController.text.trim()
          : null,
      'custom_category': _selectedCategory == 'Otro' ? role : null,
      'purpose': 'human', // Fix db not-null constraint
    };

    if (widget.employeeToEdit != null) {
      final res = await repo.updateEmployee(
        widget.employeeToEdit!['id'],
        payload,
      );
      if (mounted) {
        if (res != null) {
          ref.invalidate(businessProvider);
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Empleado actualizado')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error actualizando empleado')),
          );
        }
      }
    } else {
      final res = await repo.createEmployee(payload);
      if (mounted) {
        if (res != null) {
          ref.invalidate(businessProvider);
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Empleado creado')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error creando empleado')),
          );
        }
      }
    }
  }
}
