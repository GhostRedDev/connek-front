import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginDropdownButton extends StatelessWidget {
  const LoginDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final user = session?.user;
        final isLoggedIn = user != null;

        // Get User Data
        final metadata = user?.userMetadata ?? {};
        final firstName = metadata['first_name'] ?? 'Usuario';
        final lastName = metadata['last_name'] ?? '';
        final fullName = '$firstName $lastName'.trim();
        // Assuming 'role' or 'user_type' is in metadata. Defaulting to 'Miembro'
        final userType = metadata['role'] ?? metadata['user_type'] ?? 'Miembro'; 

        return Theme(
          data: Theme.of(context).copyWith(
            popupMenuTheme: PopupMenuThemeData(
              color: const Color(0xFF1A1D21), // Dark bg for menu
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              textStyle: GoogleFonts.inter(color: Colors.white),
            ),
          ),
          child: PopupMenuButton<String>(
            offset: const Offset(0, 50),
            onSelected: (value) async {
              if (value == 'login') {
                context.push('/login');
              } else if (value == 'register') {
                context.push('/register');
              } else if (value == 'profile') {
                context.push('/profile');
              } else if (value == 'logout') {
                 await Supabase.instance.client.auth.signOut();
                 if (context.mounted) context.go('/'); // Go home after logout
              }
            },
            itemBuilder: (context) {
              if (isLoggedIn) {
                return [
                  // 1. User Type (Non-clickable Header)
                   PopupMenuItem<String>(
                    enabled: false,
                    child: Text(
                      userType.toString().toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  // 2. User Name (Link to Profile)
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFF4F87C9), size: 20),
                        const SizedBox(width: 8),
                         Expanded(
                          child: Text(
                            fullName.isEmpty ? 'Mi Perfil' : fullName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 1),
                  // 3. Logout
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent, size: 20),
                        const SizedBox(width: 8),
                        Text('Cerrar Sesión', style: GoogleFonts.inter(color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ];
              } else {
                // Not Logged In
                return [
                  PopupMenuItem(
                    value: 'login',
                    child: Row(
                      children: [
                        const Icon(Icons.login, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Text('Iniciar Sesión', style: GoogleFonts.inter(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 1),
                  PopupMenuItem(
                    value: 'register',
                    child: Row(
                      children: [
                        const Icon(Icons.person_add, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Text('Registrarme', style: GoogleFonts.inter(color: Colors.white)),
                      ],
                    ),
                  ),
                ];
              }
            },
            child: Container(
              width: 40, 
              height: 40,
              decoration: BoxDecoration(
                color: isLoggedIn ? const Color(0xFF4F87C9) : Colors.white, // Blue if logged in
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                color: isLoggedIn ? Colors.white : Colors.black, // White icon if logged in
                size: 24
              ),
            ),
          ),
        );
      }
    );
  }
}
