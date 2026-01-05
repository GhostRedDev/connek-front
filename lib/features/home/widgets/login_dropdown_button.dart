import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class LoginDropdownButton extends StatelessWidget {
  const LoginDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xFF1A1D21), // Dark bg for menu
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(color: Colors.white),
        ),
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 45), // Shift down slightly
        onSelected: (value) {
          if (value == 'login') {
             context.push('/login');
          } else if (value == 'register') {
             context.push('/register');
          }
        },
        itemBuilder: (context) => [
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
        ],
        child: Container(
          width: 40, 
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, // Requested White
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.person, color: Colors.black, size: 24), // Black icon on white
        ),
      ),
    );
  }
}
