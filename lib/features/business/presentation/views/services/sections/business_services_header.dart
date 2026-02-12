import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BusinessServicesHeader extends StatelessWidget {
  final Map<String, dynamic> t;
  final bool isDark;

  const BusinessServicesHeader({
    super.key,
    required this.t,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.h2(
          t['business_services_title'] ??
              'Servicios y Eventos', // Fallback or key check
        ),
        const SizedBox(height: 4),
        AppText.p(
          t['business_services_subtitle'] ??
              'Gestiona tus servicios, eventos y productos.',
          style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
        ),
      ],
    );
  }
}
