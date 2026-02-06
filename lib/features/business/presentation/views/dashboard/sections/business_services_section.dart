import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/system_ui/layout/buttons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:connek_frontend/features/business/presentation/views/services/service_mini_card_widget.dart';

class BusinessServicesSection extends StatelessWidget {
  final List<dynamic> services;
  final Map<String, dynamic> t;

  const BusinessServicesSection({
    super.key,
    required this.services,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h4(t['services'] ?? 'Servicios'),
              AppButton.ghost(
                text: t['add'] ?? 'Añadir',
                icon: Icons.add,
                onPressed: () => context.push('/business/create-service'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (services.isEmpty)
            _NoServicesCard(t: t)
          else
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: services.map((e) {
                return InkWell(
                  onTap: () {
                    context.push('/business/create-service', extra: e);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: ServiceMiniCardWidget(service: e),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _NoServicesCard extends StatelessWidget {
  final Map<String, dynamic> t;
  const _NoServicesCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.spa_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 10),
            AppText.p(
              t['no_services'] ?? 'No hay servicios registrados',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
