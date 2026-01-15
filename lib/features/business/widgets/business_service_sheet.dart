import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/business_provider.dart';

class BusinessServiceSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? serviceToEdit;

  const BusinessServiceSheet({super.key, this.serviceToEdit});

  @override
  ConsumerState<BusinessServiceSheet> createState() =>
      _BusinessServiceSheetState();
}

class _BusinessServiceSheetState extends ConsumerState<BusinessServiceSheet> {
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  String _selectedCategory = 'Barbershop'; // Default or from list

  // Mock Data
  final List<String> _categories = [
    'Barbershop',
    'Spa',
    'Gym',
    'Salon',
    'Other',
  ];
  List<Map<String, dynamic>> _employees = [];

  @override
  void initState() {
    super.initState();
    // Initialize if Editing
    if (widget.serviceToEdit != null) {
      final s = widget.serviceToEdit!;
      _nameController.text = s['name'] ?? '';
      _descController.text = s['description'] ?? '';
      _priceController.text = (s['price'] ?? '').toString();
      _durationController.text = s['duration'] ?? '';
      _selectedCategory = s['category'] ?? 'Barbershop';
      // Initialize selected employees logic here if applicable
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch real employees to populate list
    final businessData = ref.watch(businessProvider);
    final allEmployees = businessData.maybeWhen(
      data: (data) => data.employees,
      orElse: () => <Map<String, dynamic>>[],
    );

    // Merge selection state (logic to be implemented, for now just show all)
    if (_employees.isEmpty && allEmployees.isNotEmpty) {
      _employees = allEmployees.map((e) => {...e, 'selected': false}).toList();
    }

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
                  widget.serviceToEdit != null
                      ? 'Editar servicio'
                      : 'Añadir un servicio',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                _buildCircleButton(
                  icon: Icons.check,
                  onTap: _saveService, // Implement Save Logic
                  isDark: isDark,
                  color: const Color(0xFF4285F4),
                  iconColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Flexible Content
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    _buildLabel('Nombra tu servicio'),
                    _buildTextField(
                      controller: _nameController,
                      hint: 'Ej: Cortes de cabello para caballeros.',
                      fillColor: inputFillColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),

                    // Description
                    _buildLabel('Descripción'),
                    _buildTextField(
                      controller: _descController,
                      hint:
                          'Ej: Ofrecemos servicios de cortes de cabello para hombres.',
                      maxLines: 4,
                      fillColor: inputFillColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),

                    // Price
                    _buildLabel('Precio'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _priceController,
                            hint: '\$',
                            fillColor: inputFillColor,
                            textColor: textColor,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildCircleButton(
                          icon: Icons.add,
                          onTap: () {},
                          isDark: isDark,
                          size: 48,
                        ), // Add variation placeholder
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Duration
                    _buildLabel('Duración (est)'),
                    _buildTextField(
                      controller: _durationController,
                      hint: 'Ej: 20 minutos',
                      fillColor: inputFillColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),

                    // Category
                    _buildLabel('Categoria'),
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
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: textColor,
                          ),
                          style: GoogleFonts.inter(color: textColor),
                          items: _categories
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _selectedCategory = val!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Content (Images)
                    _buildLabel('Contenido'),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: inputFillColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          style: BorderStyle.none,
                        ), // Dotted border effect requires custom painter or package, keeping simple for now
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 32,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Subir imágenes',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            'Max 5 (3MB por imagen)',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Employees
                    _buildLabel('Empleados/Recursos'),
                    Text(
                      'Selecciona a los empleados para este servicio.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _employees
                            .map((e) => _buildEmployeeCard(e, isDark))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Footer Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {}, // Save Draft Logic
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inputFillColor,
                              foregroundColor: textColor, // Text Color
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Guardar borrador'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildCircleButton(
                          icon: Icons.remove_red_eye_outlined,
                          onTap: () {},
                          isDark: isDark,
                          size: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
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

  Widget _buildEmployeeCard(Map<String, dynamic> employee, bool isDark) {
    final name = employee['name'] ?? 'Unknown';
    final role = employee['role'] ?? 'Staff';
    // final isSelected = employee['selected'] == true;
    final isSelected = true; // Mock selection for visual parity with design

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: employee['image'] != null
                ? CachedNetworkImageProvider(employee['image'])
                : null,
            child: employee['image'] == null ? const Icon(Icons.person) : null,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isDark ? Colors.white : Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            role,
            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Switch(
            value: isSelected,
            onChanged: (val) {
              // Update state logic
            },
            activeColor: Colors.grey[700], // Dark grey as in design
            activeTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  void _saveService() {
    // Implement Save Logic
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Service saved (Mock)')));
  }
}
