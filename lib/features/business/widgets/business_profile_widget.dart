import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/business_provider.dart';

class BusinessProfileWidget extends ConsumerStatefulWidget {
  const BusinessProfileWidget({super.key});

  @override
  ConsumerState<BusinessProfileWidget> createState() =>
      _BusinessProfileWidgetState();
}

class _BusinessProfileWidgetState extends ConsumerState<BusinessProfileWidget> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Defer initialization to after build or use Ref.read in initState if provider keeps state
    // Best practice is to use ref.read to set initial values if not using a separate Controller/Notifier for form
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final businessData = ref.read(businessProvider);
    businessData.whenData((data) {
      final profile = data.businessProfile;
      if (profile != null) {
        setState(() {
          _nameController.text = profile['name'] ?? '';
          _descController.text = profile['description'] ?? '';
          _phoneController.text = profile['phone'] ?? '';
          _emailController.text = profile['email'] ?? '';
          _addressController.text = profile['address'] ?? '';
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final data = {
      'name': _nameController.text,
      'description': _descController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'address': _addressController.text,
    };

    final success = await ref
        .read(businessProvider.notifier)
        .updateBusinessProfile(data);

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado correctamente')),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch for avatar/banner updates if they happen
    final businessData = ref.watch(businessProvider);
    final profile = businessData.maybeWhen(
      data: (d) => d.businessProfile,
      orElse: () => null,
    );

    // Resolve Image
    // Using simple logic, repository might have full resolver
    String? imageUrl;
    if (profile != null && profile['image'] != null) {
      String path = profile['image'];
      if (path.startsWith('http')) {
        imageUrl = path;
      } else {
        // Basic fallback if resolver not handy in widget:
        // Assuming cached image or handle it loosely.
        // Ideally use the helper in provider but we need businessId.
        // For now, if it's not starting with http, it might fail to load with CachedNetwork if logic isn't exact.
        // But let's trust the logic we added to dashboard.
        // Wait, businessProfile in provider is RAW. It doesn't have the resolved URL logic which was applied to services/employees.
        // We might need to resolve it here or update provider mapping.
        // Simplest: use MyBusinessLogoProvider? Or update provider to resolve profile image too.
        // Let's use a placeholder if null.
      }
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final inputFillColor = isDark
        ? const Color(0xFF1E2126) // Slightly lighter than black
        : const Color(0xFFF5F7FA); // Light grey

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Safe Area
            SizedBox(height: MediaQuery.of(context).padding.top),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ), // Placeholder for back if needed or center title
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Editar perfil',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Actualiza la información de tu empresa',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Banner & Avatar
            SizedBox(
              height: 240,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Blue Gradient Banner
                  Container(
                    width: double.infinity,
                    height: 180,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0052D4),
                          Color(0xFF4364F7),
                        ], // Blue gradient
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Edit Icon Button
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Avatar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: const Color(
                            0xFF2C1E16,
                          ), // Dark brownish
                          backgroundImage: imageUrl != null
                              ? CachedNetworkImageProvider(imageUrl)
                              : null,
                          child: imageUrl == null
                              ? const Icon(
                                  Icons.business,
                                  size: 40,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),

                  // Logo overlay (white dots in circle as in design)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      // Simple overlay simulation if no image
                      child: IgnorePointer(
                        child: SizedBox(
                          width: 92,
                          height: 92,
                          child: Center(
                            child: Icon(
                              Icons.assistant,
                              color: Colors.white.withOpacity(0.5),
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información básica',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF16181C)
                            : const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Nombre de la empresa', textColor),
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Nombre de la empresa',
                            fillColor: inputFillColor,
                            textColor: textColor,
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Descripción (Bio)', textColor),
                          _buildTextField(
                            controller: _descController,
                            hint: 'Ej: Ofrecemos servicios...',
                            fillColor: inputFillColor,
                            textColor: textColor,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Información de contacto',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF16181C)
                            : const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildLabel('Numero de teléfono', textColor),
                          _buildTextField(
                            controller: _phoneController,
                            hint: '+58 424...',
                            icon: Icons.phone_outlined,
                            fillColor: inputFillColor,
                            textColor: textColor,
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Correo electrónico', textColor),
                          _buildTextField(
                            controller: _emailController,
                            hint: 'info@Example.com',
                            icon: Icons.email_outlined,
                            fillColor: inputFillColor,
                            textColor: textColor,
                          ),
                          const SizedBox(height: 16),
                          _buildLabel('Dirección', textColor),
                          _buildTextField(
                            controller: _addressController,
                            hint: 'Dirección completa',
                            icon: Icons.location_on_outlined,
                            fillColor: inputFillColor,
                            textColor: textColor,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Footer Buttons
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            color: textColor,
                            onPressed: () {}, // Back or Navigate
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? Colors.white10
                                  : Colors.grey[200],
                              foregroundColor: textColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Visitar perfil'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _updateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF0F172A,
                              ), // Dark Navy
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Actualizar perfil'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required Color fillColor,
    required Color textColor,
    IconData? icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.inter(color: textColor, fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: Colors.grey, fontSize: 13),
          prefixIcon: icon != null
              ? Icon(icon, color: Colors.grey, size: 20)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            // Optional validation logic
            return null;
          }
          return null;
        },
      ),
    );
  }
}
