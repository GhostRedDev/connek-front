import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart'; // Removed

import 'package:cached_network_image/cached_network_image.dart';
import '../providers/business_provider.dart';

class BusinessServiceSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? serviceToEdit;
  final String type; // 'service', 'event', 'item'

  const BusinessServiceSheet({
    super.key,
    this.serviceToEdit,
    this.type = 'service',
  });

  @override
  ConsumerState<BusinessServiceSheet> createState() =>
      _BusinessServiceSheetState();
}

class _BusinessServiceSheetState extends ConsumerState<BusinessServiceSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _stockController = TextEditingController();

  DateTime? _eventDate;
  TimeOfDay? _eventTime;
  String _selectedCategory = 'Barbershop';

  final List<String> _categories = [
    'Barbershop',
    'Spa',
    'Gym',
    'Salon',
    'Other',
  ];

  List<Map<String, dynamic>> _employees = [];
  List<Map<String, dynamic>> _customQuestions =
      []; // Local state for form builder
  String? _previewImage;
  bool _showPreview = false;

  @override
  void initState() {
    super.initState();

    if (widget.serviceToEdit != null) {
      _showPreview = true;
      final s = widget.serviceToEdit!;
      _nameController.text = s['name'] ?? '';
      _descController.text = s['description'] ?? '';
      _priceController.text =
          (s['price'] ?? s['price_cents'] != null
                  ? (s['price_cents'] / 100).toString()
                  : '')
              .toString();
      _durationController.text = (s['duration_minutes'] ?? s['duration'] ?? '')
          .toString();
      _stockController.text = (s['stock_quantity'] ?? s['stock'] ?? '')
          .toString();

      _previewImage = s['image'] ?? s['image_url'];
      if (_previewImage == null &&
          s['photos'] != null &&
          (s['photos'] as List).isNotEmpty) {
        _previewImage = s['photos'][0];
      }

      if (s['event_date'] != null) {
        try {
          final dt = DateTime.parse(s['event_date']);
          _eventDate = dt;
          _eventTime = TimeOfDay.fromDateTime(dt);
        } catch (_) {}
      }

      _selectedCategory =
          s['category'] ?? s['service_category'] ?? 'Barbershop';
      if (!_categories.contains(_selectedCategory)) {
        _categories.add(_selectedCategory);
      }

      if (s['custom_form'] != null) {
        _customQuestions = List<Map<String, dynamic>>.from(s['custom_form']);
      }
    }

    _nameController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider);
    final allEmployees = businessData.maybeWhen(
      data: (data) => data.employees,
      orElse: () => <Map<String, dynamic>>[],
    );

    if (_employees.isEmpty && allEmployees.isNotEmpty) {
      _employees = allEmployees.map((e) => {...e, 'selected': false}).toList();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1D21) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final inputFillColor = isDark
        ? const Color(0xFF2C3036)
        : const Color(0xFFF5F5F5);

    String actionLabel = 'servicio';
    if (widget.type == 'event') actionLabel = 'evento';
    if (widget.type == 'item') actionLabel = 'item';

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
                      ? 'Editar $actionLabel'
                      : 'Añadir un $actionLabel',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'Inter',
                  ),
                ),
                Row(
                  children: [
                    _buildCircleButton(
                      icon: _showPreview
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onTap: () => setState(() => _showPreview = !_showPreview),
                      isDark: isDark,
                      color: _showPreview ? const Color(0xFF4285F4) : null,
                      iconColor: _showPreview ? Colors.white : null,
                    ),
                    const SizedBox(width: 8),
                    _buildCircleButton(
                      icon: Icons.check,
                      onTap: _saveService,
                      isDark: isDark,
                      color: const Color(0xFF4285F4),
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Live Preview Section
            if (_showPreview) ...[
              Text(
                'Vista Previa',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              _buildLivePreviewCard(),
              const SizedBox(height: 24),
            ],

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
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Stock (Item Only)
                    if (widget.type == 'item') ...[
                      _buildLabel('Stock / Cantidad'),
                      _buildTextField(
                        controller: _stockController,
                        hint: 'Ej: 50',
                        fillColor: inputFillColor,
                        textColor: textColor,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Event Date (Event Only)
                    if (widget.type == 'event') ...[
                      _buildLabel('Fecha y Hora'),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (date != null) {
                                  setState(() => _eventDate = date);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: inputFillColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _eventDate == null
                                      ? 'Fecha'
                                      : '${_eventDate!.day}/${_eventDate!.month}/${_eventDate!.year}',
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null) {
                                  setState(() => _eventTime = time);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: inputFillColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _eventTime == null
                                      ? 'Hora'
                                      : _eventTime!.format(context),
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Duration (Hide for Item)
                    if (widget.type != 'item') ...[
                      _buildLabel('Duración (est)'),
                      _buildTextField(
                        controller: _durationController,
                        hint: 'Ej: 20 minutos',
                        fillColor: inputFillColor,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 16),
                    ],

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
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'Inter',
                          ),
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
                        ),
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
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            'Max 5 (3MB por imagen)',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Custom Form Builder
                    _buildLabel('Formulario Personalizado (Datos del Cliente)'),
                    Text(
                      'Diseña las preguntas que el cliente debe responder al reservar este servicio.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_customQuestions.isNotEmpty)
                      ..._customQuestions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final q = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: inputFillColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                q['type'] == 'boolean'
                                    ? Icons.check_circle_outline
                                    : q['type'] == 'options'
                                    ? Icons.list
                                    : Icons.text_fields,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      q['label'] ?? 'Pregunta sin título',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Tipo: ${q['type']} • ${q['required'] == true ? 'Obligatorio' : 'Opcional'}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _customQuestions.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _showAddQuestionDialog,
                        icon: const Icon(Icons.add_circle_outline, size: 18),
                        label: const Text('Agregar Pregunta'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF4285F4),
                          side: const BorderSide(color: Color(0xFF4285F4)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Employees
                    _buildLabel('Empleados/Recursos'),
                    Text(
                      'Selecciona a los empleados para este servicio.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'Inter',
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

                    // Delete Button
                    if (widget.serviceToEdit != null)
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: _deleteService,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Eliminar este servicio',
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
                    const SizedBox(height: 40),
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
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0xFF1A1D21),
          fontFamily: 'Inter',
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
      style: TextStyle(color: textColor, fontFamily: 'Inter'),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Inter'),
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
    final isSelected = true; // Mock

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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isDark ? Colors.white : Colors.black,
              fontFamily: 'Inter',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            role,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Switch(
            value: isSelected,
            onChanged: (val) {},
            activeThumbColor: Colors.grey[700],
            activeTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildLivePreviewCard() {
    final title = _nameController.text.isEmpty
        ? 'Nombre del servicio'
        : _nameController.text;
    final desc = _descController.text.isEmpty
        ? 'Descripción corta del servicio o evento...'
        : _descController.text;
    final price = _priceController.text.isEmpty ? '0' : _priceController.text;

    ImageProvider? imageProvider;
    if (_previewImage != null) {
      if (_previewImage!.startsWith('http')) {
        imageProvider = CachedNetworkImageProvider(_previewImage!);
      } else {
        imageProvider = NetworkImage(_previewImage!); // Placeholder
      }
    } else if (widget.serviceToEdit != null) {
      final img =
          widget.serviceToEdit!['image'] ?? widget.serviceToEdit!['image_url'];
      if (img != null) {
        imageProvider = CachedNetworkImageProvider(img);
      } else if (widget.serviceToEdit!['photos'] != null &&
          (widget.serviceToEdit!['photos'] as List).isNotEmpty) {
        imageProvider = CachedNetworkImageProvider(
          widget.serviceToEdit!['photos'][0],
        );
      }
    }

    // --- EVENT STYLE ---
    if (widget.type == 'event') {
      final timeLeft = _eventDate != null
          ? 'Finaliza en ${_eventDate!.difference(DateTime.now()).inDays} días'
          : 'Finaliza en 5 días';

      return Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: imageProvider != null
              ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
              : null,
          color: imageProvider == null ? Colors.grey[300] : null,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.4, 0.7, 1.0],
                ),
              ),
            ),
            // Blue Pill
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeLeft,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROMOCIÓN',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            letterSpacing: 1.0,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Outfit',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // --- SERVICE / DEFAULT STYLE ---
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        image: imageProvider != null
            ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
            : null,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$$price',
                  style: TextStyle(
                    color: const Color(0xFF4285F4),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddQuestionDialog() async {
    String label = '';
    String type = 'text'; // text, boolean, options
    bool required = false;
    String optionsText = '';
    final formKey = GlobalKey<FormState>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final bg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
            final text = isDark ? Colors.white : Colors.black;

            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nueva Pregunta',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: text,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Pregunta / Etiqueta',
                        hintText: 'Ej: ¿Tiene alergias?',
                        filled: true,
                        fillColor: isDark ? Colors.white10 : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: text),
                      onChanged: (val) => label = val,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: type,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Respuesta',
                        filled: true,
                        fillColor: isDark ? Colors.white10 : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: bg,
                      style: TextStyle(color: text),
                      items: const [
                        DropdownMenuItem(
                          value: 'text',
                          child: Text('Texto Libre'),
                        ),
                        DropdownMenuItem(
                          value: 'boolean',
                          child: Text('Si / No'),
                        ),
                        DropdownMenuItem(
                          value: 'options',
                          child: Text('Selección Múltiple'),
                        ),
                      ],
                      onChanged: (val) => setModalState(() => type = val!),
                    ),
                    if (type == 'options') ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Opciones (separadas por comas)',
                          hintText: 'Ej: Opción A, Opción B, Opción C',
                          filled: true,
                          fillColor: isDark ? Colors.white10 : Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: text),
                        onChanged: (val) => optionsText = val,
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                    ],
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        'Respuesta Obligatoria',
                        style: TextStyle(color: text),
                      ),
                      value: required,
                      activeColor: const Color(0xFF4285F4),
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) => setModalState(() => required = val),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4285F4),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final question = {
                              'id': DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              'label': label,
                              'type': type,
                              'required': required,
                            };
                            if (type == 'options') {
                              question['options'] = optionsText
                                  .split(',')
                                  .map((e) => e.trim())
                                  .where((e) => e.isNotEmpty)
                                  .toList();
                            }
                            setState(() {
                              _customQuestions.add(question);
                            });
                            Navigator.pop(ctx);
                          }
                        },
                        child: const Text(
                          'Guardar Pregunta',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _saveService() async {
    if (!_formKey.currentState!.validate()) return;

    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final priceCents = (price * 100).toInt();

    String? eventDateIso;
    if (_eventDate != null) {
      final t = _eventTime ?? const TimeOfDay(hour: 0, minute: 0);
      final dt = DateTime(
        _eventDate!.year,
        _eventDate!.month,
        _eventDate!.day,
        t.hour,
        t.minute,
      );
      eventDateIso = dt.toIso8601String();
    }

    final payload = {
      'name': _nameController.text.trim(),
      'description': _descController.text.trim(),
      'price_cents': priceCents,
      'price_low_cents': priceCents,
      'price_high_cents': priceCents,
      'duration_minutes':
          int.tryParse(
            _durationController.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          30,
      'service_category': _selectedCategory,
      'type': widget.type,
    };

    if (widget.type == 'item') {
      payload['stock_quantity'] =
          int.tryParse(_stockController.text.trim()) ?? 0;
    }
    if (widget.type == 'event' && eventDateIso != null) {
      payload['event_date'] = eventDateIso;
    }

    // Save custom form
    payload['custom_form'] = _customQuestions;

    final businessData = ref.read(businessProvider).value;

    if (businessData?.businessProfile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Business not found')),
      );
      return;
    }

    final businessId = businessData!.businessProfile!['id'];
    payload['business_id'] = businessId;

    final repo = ref.read(businessRepositoryProvider);
    bool success = false;

    if (widget.serviceToEdit != null) {
      final id = widget.serviceToEdit!['id'];
      final res = await repo.updateService(id, payload);
      success = res != null;
    } else {
      final res = await repo.createService(payload);
      success = res != null;
    }

    if (mounted) {
      if (success) {
        ref.invalidate(businessProvider);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.serviceToEdit != null
                  ? 'Servicio actualizado'
                  : 'Servicio creado',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error guardando el servicio')),
        );
      }
    }
  }

  Future<void> _deleteService() async {
    if (widget.serviceToEdit == null) return;

    final repo = ref.read(businessRepositoryProvider);
    final id = widget.serviceToEdit!['id'];

    final success = await repo.deleteService(id);

    if (mounted) {
      if (success) {
        ref.invalidate(businessProvider);
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Servicio eliminado')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error eliminando servicio')),
        );
      }
    }
  }
}
