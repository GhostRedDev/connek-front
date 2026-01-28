import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/business_provider.dart';

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
  final _roleController = TextEditingController(); // Or dropdown
  // Image handling later

  @override
  void initState() {
    super.initState();
    if (widget.employeeToEdit != null) {
      final e = widget.employeeToEdit!;
      _nameController.text = e['name'] ?? '';
      _roleController.text = e['role'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
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
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                  isDark: isDark,
                ),
                Text(
                  widget.employeeToEdit != null
                      ? 'Editar Empleado'
                      : 'Añadir Empleado',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                _buildCircleButton(
                  icon: Icons.check,
                  onTap: _saveEmployee,
                  isDark: isDark,
                  color: const Color(0xFF4285F4),
                  iconColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildLabel('Nombre', context),
            _buildTextField(
              controller: _nameController,
              hint: 'Ej: Maria Sanchez',
              fillColor: inputFillColor,
              textColor: textColor,
            ),
            const SizedBox(height: 16),

            _buildLabel('Rol / Cargo', context),
            _buildTextField(
              controller: _roleController,
              hint: 'Ej: Gerente, Vendedor',
              fillColor: inputFillColor,
              textColor: textColor,
            ),
            const SizedBox(height: 32),
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
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: textColor),
      validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
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

    final payload = {
      'name': _nameController.text.trim(),
      'role': _roleController.text.trim(),
      'business_id': businessId,
      'status': 'Activo', // Default
      'type': 'human', // Default
    };

    if (widget.employeeToEdit != null) {
      // Update logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update not implemented yet')),
      );
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
