import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            InkWell(
              onTap: () => context.push('/login'),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.3),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.blue, // Blue icon as seen in image
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
