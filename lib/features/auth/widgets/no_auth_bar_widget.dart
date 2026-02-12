import 'package:flutter/material.dart';
import '../../home/widgets/login_dropdown_button.dart';

class NoAuthBarWidget extends StatelessWidget {
  const NoAuthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo Area
            Image.asset(
              'assets/images/conneck_logo_white.png',
              height: 30, // Adjust height to fit the bar
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Text(
                'connek',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  letterSpacing: -1.0,
                ),
              ),
            ),
            // Profile/Login Icon
            const LoginDropdownButton(),
          ],
        ),
      ),
    );
  }
}
