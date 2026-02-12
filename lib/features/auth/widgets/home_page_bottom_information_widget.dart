import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/locale_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../shared/widgets/info_sheet.dart';

class HomePageBottomInformationWidget extends ConsumerWidget {
  const HomePageBottomInformationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final theme = ShadTheme.of(context);

    // Helper for Consistent Links
    Widget buildFooterLink(String text, VoidCallback onTap) {
      return ShadButton.link(
        onPressed: onTap,
        child: Text(
          text,
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.mutedForeground,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      // Glass/Overlay effect if desired, or just transparent
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 4,
            children: [
              buildFooterLink(
                t['footer_terms'] ?? 'Terms of Use',
                () => showInfoSheet(
                  context,
                  title: t['footer_terms'] ?? 'Terms of Use',
                  content:
                      t['footer_terms_content'] ??
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                ),
              ),
              buildFooterLink(
                t['footer_privacy'] ?? 'Privacy Policy',
                () => showInfoSheet(
                  context,
                  title: t['footer_privacy'] ?? 'Privacy Policy',
                  content:
                      t['footer_privacy_content'] ??
                      "Your privacy is important to us.",
                ),
              ),
              buildFooterLink(
                t['footer_cookies'] ?? 'Cookies',
                () => showInfoSheet(
                  context,
                  title: t['footer_cookies'] ?? 'Cookies',
                  content:
                      t['footer_cookies_content'] ??
                      "We use cookies to improve your experience.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 1),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 4,
            children: [
              buildFooterLink(
                t['footer_how_it_works'] ?? 'How it works',
                () => showInfoSheet(
                  context,
                  title: t['footer_how_it_works'] ?? 'How it works',
                  content:
                      t['footer_how_it_works_content'] ??
                      "1. Search. 2. Request. 3. Done.",
                ),
              ),
              buildFooterLink(
                t['footer_about'] ?? 'About',
                () => showInfoSheet(
                  context,
                  title: t['footer_about'] ?? 'About',
                  content:
                      t['footer_about_content'] ??
                      "Connek connects you with the best professionals.",
                ),
              ),
              buildFooterLink(
                t['footer_contact'] ?? 'Contact Us',
                () => showInfoSheet(
                  context,
                  title: t['footer_contact'] ?? 'Contact Us',
                  content:
                      t['footer_contact_content'] ??
                      "Email: support@connek.com",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
