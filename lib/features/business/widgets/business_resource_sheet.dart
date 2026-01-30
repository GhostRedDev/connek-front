import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/business_provider.dart';
import '../../../core/providers/locale_provider.dart';

class BusinessResourceSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? resourceToEdit;

  const BusinessResourceSheet({super.key, this.resourceToEdit});

  @override
  ConsumerState<BusinessResourceSheet> createState() =>
      _BusinessResourceSheetState();
}

class _BusinessResourceSheetState extends ConsumerState<BusinessResourceSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _customCategoryController = TextEditingController();
  final _imageController = TextEditingController();

  String _selectedType = 'Sala';
  bool _isActive = true;

  final List<String> _types = ['Sala', 'Equipo', 'Vehículo', 'Puesto', 'Otro'];

  @override
  void initState() {
    super.initState();
    if (widget.resourceToEdit != null) {
      final r = widget.resourceToEdit!;
      _nameController.text = r['name'] ?? '';
      _imageController.text = r['profile_image'] ?? '';
      _isActive = r['active'] ?? true;

      String type = r['resource_type'] ?? 'Sala';
      if (_types.contains(type)) {
        _selectedType = type;
      } else {
        _selectedType = 'Otro';
        _customCategoryController.text = type;
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
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                    isDark: isDark,
                  ),
                  Text(
                    widget.resourceToEdit != null
                        ? t['business_resource_sheet_edit_title'] ??
                              'Editar Recurso'
                        : t['business_resource_sheet_add_title'] ??
                              'Añadir Recurso',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  _buildCircleButton(
                    icon: Icons.check,
                    onTap: _saveResource,
                    isDark: isDark,
                    color: const Color(0xFF4285F4),
                    iconColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildLabel(
                t['business_resource_sheet_name_label'] ?? 'Nombre del Recurso',
                context,
              ),
              _buildTextField(
                controller: _nameController,
                hint: 'Ej: Sala de Juntas A',
                fillColor: inputFillColor,
                textColor: textColor,
              ),
              const SizedBox(height: 16),

              _buildLabel(
                t['business_resource_sheet_type_label'] ?? 'Tipo de Recurso',
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
                    value: _selectedType,
                    isExpanded: true,
                    dropdownColor: backgroundColor,
                    style: GoogleFonts.inter(color: textColor),
                    items: _types.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue!;
                      });
                    },
                  ),
                ),
              ),
              if (_selectedType == 'Otro') ...[
                const SizedBox(height: 16),
                _buildLabel(
                  t['business_employee_sheet_custom_role_label'] ??
                      'Especificar Tipo',
                  context,
                ),
                _buildTextField(
                  controller: _customCategoryController,
                  hint: 'Ej: Proyector 4K',
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
                    t['business_resource_sheet_active_label'] ??
                        'Disponible / Activo',
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
          : null,
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

  Future<void> _saveResource() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(businessRepositoryProvider);
    final businessData = ref.read(businessProvider).value;

    if (businessData?.businessProfile == null) return;
    final businessId = businessData!.businessProfile!['id'];

    final type = _selectedType == 'Otro'
        ? _customCategoryController.text.trim()
        : _selectedType;

    // Default service_time for backend compatibility (Mon-Fri 9-5)
    final defaultServiceTime =
        '{"1": ["09:00", "17:00"], "2": ["09:00", "17:00"], "3": ["09:00", "17:00"], "4": ["09:00", "17:00"], "5": ["09:00", "17:00"]}';

    final payload = {
      'name': _nameController.text.trim(),
      'resource_type': type,
      'business_id': businessId.toString(),
      'active': _isActive.toString(),
      'service_time': defaultServiceTime, // Backend needs this
      'profile_image': _imageController.text.isNotEmpty
          ? _imageController.text.trim()
          : null,
    };

    if (widget.resourceToEdit != null) {
      final res = await repo.updateResource(
        widget.resourceToEdit!['id'],
        payload,
      );
      if (mounted) {
        if (res != null) {
          ref.invalidate(businessProvider);
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Recurso actualizado')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error actualizando recurso')),
          );
        }
      }
    } else {
      final res = await repo.createResource(payload);
      if (mounted) {
        if (res != null) {
          ref.invalidate(businessProvider);
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Recurso creado')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error creando recurso')),
          );
        }
      }
    }
  }
}
