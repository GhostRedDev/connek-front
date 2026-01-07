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
              color: const Color(0xFF252A34), // Rich Dark Navy
              shadowColor: Colors.black54,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
              ),
              textStyle: GoogleFonts.outfit(color: Colors.white),
            ),
          ),
          child: PopupMenuButton<String>(
            offset: const Offset(0, 50),
            tooltip: isLoggedIn ? 'Tu Perfil' : 'Menú de Usuario',
            onSelected: (value) async {
              if (value == 'login') {
                context.push('/login');
              } else if (value == 'register') {
                context.push('/register');
              } else if (value == 'profile') {
                context.push('/profile');
              } else if (value == 'logout') {
                 await Supabase.instance.client.auth.signOut();
                 if (context.mounted) context.go('/'); 
              }
            },
            itemBuilder: (context) {
              if (isLoggedIn) {
                return [
                  // 1. User Type Header
                   PopupMenuItem<String>(
                    enabled: false,
                    height: 30,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        userType.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: Colors.grey[400],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(height: 8),
                  // 2. User Name
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F87C9).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Color(0xFF4F87C9), size: 18),
                        ),
                        const SizedBox(width: 12),
                         Expanded(
                          child: Text(
                            fullName.isEmpty ? 'Mi Perfil' : fullName,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 8),
                  // 3. Logout
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Text('Cerrar Sesión', style: GoogleFonts.outfit(color: Colors.redAccent, fontSize: 14)),
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
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.tealAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.login_rounded, color: Colors.tealAccent, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Text('Iniciar Sesión', style: GoogleFonts.outfit(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 8),
                  PopupMenuItem(
                    value: 'register',
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.purpleAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_add_alt_1_rounded, color: Colors.purpleAccent, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Text('Registrarme', style: GoogleFonts.outfit(color: Colors.white, fontSize: 14)),
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
