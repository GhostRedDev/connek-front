import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/neon_comet_effect.dart';

class AuthSuccessOverlay extends StatelessWidget {
  final String message;
  final bool isLogin;

  const AuthSuccessOverlay({
    super.key,
    required this.message,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: NeonCometEffect(
          strokeWidth: 4,
          radius: 20,
          duration: const Duration(seconds: 2),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF131619).withOpacity(0.95), // Dark modal bg
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with glow
                Container(
                   padding: const EdgeInsets.all(20),
                   decoration: BoxDecoration(
                     color: Colors.green.withOpacity(0.1),
                     shape: BoxShape.circle,
                     boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 20,
                        )
                     ],
                   ),
                   child: Icon(
                     isLogin ? Icons.check_circle_rounded : Icons.verified_user_rounded,
                     color: Colors.greenAccent,
                     size: 60,
                   ),
                ),
                const SizedBox(height: 24),
                
                // Message
                Text(
                  isLogin ? 'Login Successful' : 'Logout Successful',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper to show the overlay
Future<void> showAuthSuccessDialog(BuildContext context, {required String message, required bool isLogin}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.8), // Darken background heavily
    builder: (context) => AuthSuccessOverlay(message: message, isLogin: isLogin),
  );
  
  // Wait 3 seconds then close
  await Future.delayed(const Duration(seconds: 3));
  if (context.mounted) {
    Navigator.of(context, rootNavigator: true).pop(); // Close dialog
  }
}
