import 'package:flutter/material.dart';

class HomePageBottomInformationWidget extends StatelessWidget {
  const HomePageBottomInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      // Background is handled by parent gradient, so transparent here or removed
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLink('Terms of Use'),
              const SizedBox(width: 24),
              _buildLink('Privacy Policy'),
              const SizedBox(width: 24),
              _buildLink('Cookies'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLink('How it works'),
              const SizedBox(width: 24),
              _buildLink('About'),
              const SizedBox(width: 24),
              _buildLink('Contact Us'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLink(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
