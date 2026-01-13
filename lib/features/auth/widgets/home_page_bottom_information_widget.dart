import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/locale_provider.dart';

class HomePageBottomInformationWidget extends ConsumerWidget {
  const HomePageBottomInformationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      // Background is handled by parent gradient, so transparent here or removed
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLink(t['footer_terms'] ?? 'Terms of Use'),
              const SizedBox(width: 24),
              _buildLink(t['footer_privacy'] ?? 'Privacy Policy'),
              const SizedBox(width: 24),
              _buildLink(t['footer_cookies'] ?? 'Cookies'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLink(t['footer_how_it_works'] ?? 'How it works'),
              const SizedBox(width: 24),
              _buildLink(t['footer_about'] ?? 'About'),
              const SizedBox(width: 24),
              _buildLink(t['footer_contact'] ?? 'Contact Us'),
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
