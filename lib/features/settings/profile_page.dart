// Add this for ImageFilter
// Add this for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../system_ui/core/constants.dart';

import 'widgets/profile_menu_widget.dart';
import 'widgets/settings_view.dart';
import 'providers/profile_provider.dart';
import '../../../core/models/user_model.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String? initialTab;

  const ProfilePage({super.key, this.initialTab});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late ProfileSection _currentSection;
  final bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _aboutController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Initialize section based on param
    if (widget.initialTab == 'settings') {
      _currentSection = ProfileSection.settings;
    } else {
      _currentSection = ProfileSection.profile;
    }

    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _aboutController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _initializeControllers(UserProfile? user) {
    if (user == null) return;
    // Always sync if controllers are empty or we want to ensure data is fresh on first load
    // But don't overwrite if user is typing (which is why we usually check specific conditions or use key)
    // Since we are rebuilding the form on every build if we don't manage state carefully,
    // we should only set text if empty.
    if (_nameController.text.isEmpty) {
      _nameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _phoneController.text = user.phone ?? '';
      _aboutController.text = user.aboutMe ?? '';
      _emailController.text = user.email;
    }
  }

  // Generic Image Picker
  Future<void> _pickImage(bool isBanner) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isBanner ? "Change Banner" : "Change Profile Photo",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(ctx);
                _uploadIds(ImageSource.camera, isBanner);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _uploadIds(ImageSource.gallery, isBanner);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadIds(ImageSource source, bool isBanner) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (isBanner) {
        await ref.read(profileProvider.notifier).uploadBanner(pickedFile);
      } else {
        await ref.read(profileProvider.notifier).uploadAvatar(pickedFile);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(profileProvider.notifier)
        .updateProfile(
          firstName: _nameController.text,
          lastName: _lastNameController.text,
          phone: _phoneController.text,
          aboutMe: _aboutController.text,
          email: _emailController.text,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  // ... Build Method (Unchanged until content) ...
  @override
  Widget build(BuildContext context) {
    // (Keep existing build method structure, this replaces logic)

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),

            // 1. Content (Now spans full height, with internal padding)
            Positioned.fill(
              child: Consumer(
                builder: (context, ref, child) {
                  final profileState = ref.watch(profileProvider);
                  return profileState.when(
                    data: (user) {
                      if (user == null) {
                        return const Center(child: Text("Guest or Error"));
                      }
                      _initializeControllers(user);

                      switch (_currentSection) {
                        case ProfileSection.profile:
                          // Pass padding to scroll view so it starts low but scrolls BEHIND header
                          return _buildProfileContent(
                            user,
                            Theme.of(context).brightness == Brightness.dark,
                            profileState.isLoading,
                            topPadding: 170,
                          );
                        case ProfileSection.media:
                          return const Center(
                            child: Text("Media Gallery Coming Soon"),
                          );
                        case ProfileSection.reviews:
                          return const Center(
                            child: Text("Reviews Coming Soon"),
                          );
                        case ProfileSection.settings:
                          // Note: SettingsView handles its own padding internally or via parent logic
                          // Current parent passes topPadding=170 to _buildProfileContent,
                          // but SettingsView is just a Widget.
                          // We need to ensure it has the same top padding logic so it starts below the header?
                          // ProfilePage passes topPadding 170 to _buildProfileContent which applies it.
                          // SettingsView is NOT _buildProfileContent.
                          // We should wrap SettingsView or allow it to accept padding?
                          // Or simply use padding here.
                          return SettingsView();
                      }
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text("Error: $e")),
                  );
                },
              ),
            ),

            // 2. Global AppBar handles the header now. We just show content.
            // Removed local custom header to fix "Double AppBar" issue.
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    UserProfile user,
    bool isDark,
    bool isLoading, {
    double topPadding = 20,
  }) {
    final inputFillColor = isDark
        ? const Color(0xFF2C2C2C)
        : const Color(0xFFF5F6FA);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D1E);
    final labelColor = isDark ? Colors.grey[400] : const Color(0xFF6B7280);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.laptop),
        child: SingleChildScrollView(
          // Padding 0 at top allows Banner to be behind the Translucent AppBar
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spacer for Global AppBar (120px) + Extra
                // But we WANT the banner to be behind it.
                // So we put the Banner first, and ensure it has height.
                // The Banner widget is constrained to height 220.
                // It will sit at top (0,0).

                // Banner + Avatar Section
                SizedBox(
                  height: 280, // Increased height to accommodate AppBar overlay
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Banner (Full width, top aligned)
                      Positioned(
                        top: 0,
                        left:
                            -20, // Negate parent padding to stretch full width
                        right: -20,
                        height:
                            200, // Taller banner to be visible behind AppBar
                        child: GestureDetector(
                          onTap: () => _pickImage(true),
                          child: Container(
                            decoration: BoxDecoration(
                              image:
                                  (user.bannerUrl != null &&
                                      user.bannerUrl!.isNotEmpty)
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        user.bannerUrl!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              gradient:
                                  (user.bannerUrl == null ||
                                      user.bannerUrl!.isEmpty)
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF0052D4),
                                        Color(0xFF4364F7),
                                        Color(0xFF6FB1FC),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 12,
                                  right: 24, // Adjusted for padding
                                  child: _buildCircleIconButton(
                                    icon: Icons.camera_alt_outlined,
                                    onTap: () => _pickImage(true),
                                    isDark: isDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Avatar
                      Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => _pickImage(false),
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                width: 4,
                              ),
                              color: Colors.grey[300],
                              image:
                                  (user.photoId != null &&
                                      user.photoId!.isNotEmpty)
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        user.photoId!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Perfil.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Profile Menu Tabs (Moved here from fixed header)
                ProfileMenuWidget(
                  currentSection: _currentSection,
                  onSectionSelected: (section) {
                    setState(() {
                      _currentSection = section;
                    });
                  },
                  isBusiness:
                      false, // user.hasBusiness ?? false check logic from before
                ),

                const SizedBox(height: 20),

                // Title and Info
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Editar perfil",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Actualiza tu información",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Fields
                _buildLabel("Información básica", textColor, isHeader: true),
                const SizedBox(height: 16),

                _buildLabel("Nombre de la empresa / Usuario", labelColor),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildModernInput(
                        _nameController,
                        "Nombre",
                        inputFillColor,
                        textColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernInput(
                        _lastNameController,
                        "Apellido",
                        inputFillColor,
                        textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildLabel("Descripción (Bio)", labelColor),
                const SizedBox(height: 8),
                _buildModernInput(
                  _aboutController,
                  "Biografía...",
                  inputFillColor,
                  textColor,
                  maxLines: 4,
                ),

                if (user.hasBusiness) ...[
                  const SizedBox(height: 30),
                  _buildLabel(
                    "Información del Negocio",
                    textColor,
                    isHeader: true,
                  ),
                  const SizedBox(height: 16),

                  // Business Image
                  if (user.businessProfileImage != null)
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(user.businessProfileImage!),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  _buildLabel("Nombre de la Empresa", labelColor),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: inputFillColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user.businessName ?? 'Sin nombre',
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Para editar los datos del negocio, ve a la sección 'Mi Negocio'.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],

                const SizedBox(height: 30),

                _buildLabel(
                  "Información de contacto",
                  textColor,
                  isHeader: true,
                ),
                const SizedBox(height: 16),

                _buildLabel("Número de teléfono", labelColor),
                const SizedBox(height: 8),
                _buildModernInput(
                  _phoneController,
                  "+58...",
                  inputFillColor,
                  textColor,
                  prefixIcon: Icons.phone_outlined,
                ),

                const SizedBox(height: 16),

                _buildLabel("Correo electrónico", labelColor),
                const SizedBox(height: 8),
                _buildModernInput(
                  _emailController,
                  "email@example.com",
                  inputFillColor,
                  textColor,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 40),

                // Actions
                Row(
                  children: [
                    _buildCircleButton(
                      icon: Icons.arrow_back,
                      onTap: () => context.go('/'),
                      color: isDark ? Colors.white12 : Colors.grey[200]!,
                      iconColor: textColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF111827),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Actualizar perfil"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helpers
  Widget _buildLabel(String text, Color? color, {bool isHeader = false}) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: isHeader ? 18 : 14,
        fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
        color: color,
      ),
    );
  }

  Widget _buildModernInput(
    TextEditingController controller,
    String hint,
    Color fillColor,
    Color textColor, {
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey[500], size: 20)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3), // Glassy dark
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
