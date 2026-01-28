import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/business_provider.dart';

class BusinessClientSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? clientToEdit;

  const BusinessClientSheet({super.key, this.clientToEdit});

  @override
  ConsumerState<BusinessClientSheet> createState() =>
      _BusinessClientSheetState();
}

class _BusinessClientSheetState extends ConsumerState<BusinessClientSheet> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.clientToEdit != null) {
      final c = widget.clientToEdit!;
      _firstNameController.text = c['first_name'] ?? '';
      _lastNameController.text = c['last_name'] ?? '';
      _emailController.text = c['email'] ?? '';
      _phoneController.text = c['phone'] ?? '';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                  widget.clientToEdit != null
                      ? 'Editar Cliente'
                      : 'Añadir Cliente',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                _buildCircleButton(
                  icon: Icons.check,
                  onTap: _saveClient,
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
                    _buildLabel('Nombre', context),
                    _buildTextField(
                      controller: _firstNameController,
                      hint: 'Ej: Juan',
                      fillColor: inputFillColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Apellido', context),
                    _buildTextField(
                      controller: _lastNameController,
                      hint: 'Ej: Pérez',
                      fillColor: inputFillColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Email', context),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'Ej: juan@example.com',
                      fillColor: inputFillColor,
                      textColor: textColor,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Teléfono', context),
                    _buildTextField(
                      controller: _phoneController,
                      hint: 'Ej: +52 555 555 5555',
                      fillColor: inputFillColor,
                      textColor: textColor,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 32),

                    if (widget.clientToEdit != null)
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: _deleteClient,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Eliminar Cliente',
                            style: TextStyle(color: Colors.red),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.red.withOpacity(0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
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
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(color: textColor),
      validator: (val) {
        if (val == null || val.isEmpty) return 'Campo requerido';
        return null;
      },
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

  Future<void> _saveClient() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(businessRepositoryProvider);
    final businessData = ref.read(businessProvider).value;

    if (businessData?.businessProfile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Business not found')),
      );
      return;
    }
    final businessId = businessData!.businessProfile!['id'];

    final payload = {
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'business_id': businessId,
      // 'client_since': DateTime.now().toIso8601String(), // Optional
    };

    bool success = false;
    // Assuming we are talking about "Business Clients" (contacts), not Auth Users.
    // The repo method `createBusinessClient` should handle `business_clients` table insert.
    if (widget.clientToEdit != null) {
      // Update
      // final id = widget.clientToEdit!['id'];
      // success = await repo.updateBusinessClient(id, payload); // Implement if needed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update not implemented yet')),
      );
      // return;
    } else {
      // Create
      final res = await repo.createBusinessClient(payload);
      success = res != null;
    }

    if (mounted) {
      if (success) {
        ref.invalidate(businessProvider);
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cliente guardado')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error guardando cliente')),
        );
      }
    }
  }

  Future<void> _deleteClient() async {
    if (widget.clientToEdit == null) return;
    final repo = ref.read(businessRepositoryProvider);
    final id = widget.clientToEdit!['id'];
    final success = await repo.deleteBusinessClient(id);

    if (mounted) {
      if (success) {
        ref.invalidate(businessProvider);
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cliente eliminado')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error eliminando cliente')),
        );
      }
    }
  }
}
