import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/locale_provider.dart';
import '../../shared/widgets/info_sheet.dart';

class HomePageBottomInformationWidget extends ConsumerWidget {
  const HomePageBottomInformationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: [
              _buildLink(
                context,
                t['footer_terms'] ?? 'Terms of Use',
                () => showInfoSheet(
                  context,
                  title: t['footer_terms'] ?? 'Terms of Use',
                  content:
                      t['footer_terms_content'] ??
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n(Placeholder for Terms of Use)",
                ),
              ),
              _buildLink(
                context,
                t['footer_privacy'] ?? 'Privacy Policy',
                () => showInfoSheet(
                  context,
                  title: t['footer_privacy'] ?? 'Privacy Policy',
                  content:
                      t['footer_privacy_content'] ??
                      "Your privacy is important to us. It is Connek's policy to respect your privacy regarding any information we may collect from you across our website and other sites we own and operate.\n\n(Placeholder for Privacy Policy)",
                ),
              ),
              _buildLink(
                context,
                t['footer_cookies'] ?? 'Cookies',
                () => showInfoSheet(
                  context,
                  title: t['footer_cookies'] ?? 'Cookies',
                  content:
                      t['footer_cookies_content'] ??
                      "We use cookies to improve your experience on our website. By browsing this website, you agree to our use of cookies.\n\n(Placeholder for Cookies Policy)",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: [
              _buildLink(
                context,
                t['footer_how_it_works'] ?? 'How it works',
                () => showInfoSheet(
                  context,
                  title: t['footer_how_it_works'] ?? 'How it works',
                  content:
                      t['footer_how_it_works_content'] ??
                      "1. Search for a service.\n2. Book or Request.\n3. Get it done!\n\nConnek connects you with the best professionals in your area.",
                ),
              ),
              _buildLink(
                context,
                t['footer_about'] ?? 'About',
                () => showInfoSheet(
                  context,
                  title: t['footer_about'] ?? 'About',
                  content:
                      t['footer_about_content'] ??
                      "Connek is a leading platform for connecting clients with service providers. Our mission is to make service discovery seamless and reliable.",
                ),
              ),
              _buildLink(
                context,
                t['footer_contact'] ?? 'Contact Us',
                () => showInfoSheet(
                  context,
                  title: t['footer_contact'] ?? 'Contact Us',
                  content:
                      t['footer_contact_content'] ??
                      "Have questions? Reach out to us at:\n\nEmail: support@connek.com\nPhone: +1 234 567 890\n\nWe are here to help!",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLink(BuildContext context, String text, VoidCallback onTap) {
    // Adaptive text color: White for dark mode, Grey/Black for light mode
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black.withOpacity(0.6);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
