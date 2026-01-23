import 'dart:ui';
import 'package:flutter/material.dart';

class GlassFabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const GlassFabButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60, // Slightly larger than standard 56
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.85),
                  Colors.white.withOpacity(0.45),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                customBorder: const CircleBorder(),
                child: Center(
                  child: Icon(
                    icon,
                    color: const Color(0xFF0D1C4D), // Deep Navy Blue
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
