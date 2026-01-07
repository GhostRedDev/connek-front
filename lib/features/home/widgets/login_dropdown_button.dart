import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_bottom_sheet.dart';

class LoginDropdownButton extends StatelessWidget {
  const LoginDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;
        
        return InkWell(
          onTap: () => showProfileBottomSheet(context),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(2), // Border width
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isLoggedIn 
                ? const LinearGradient(
                    colors: [Color(0xFF4285F4), Color(0xFF90CAF9)], // Blue gradient for Auth
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFF2C3138), Color(0xFF1A1D21)], // Grey gradient for Guest
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.4), // Inner darkened bg
              ),
              child: Icon(
                isLoggedIn ? Icons.person : Icons.person_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }
}
