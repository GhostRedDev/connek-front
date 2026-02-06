import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/business/presentation/sheets/business_proposal_sheet.dart';

class LeadAboutCard extends ConsumerWidget {
  final Lead lead;
  final Map<String, dynamic>? service;

  const LeadAboutCard({super.key, required this.lead, this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    // Service Info
    Map<String, dynamic>? resolvedService = service;

    if (resolvedService == null) {
      final businessData = ref.watch(businessProvider).value;
      if (businessData != null) {
        try {
          resolvedService = businessData.services.firstWhere(
            (s) => s['id'] == lead.serviceId,
            orElse: () => {},
          );
          if (resolvedService.isEmpty) resolvedService = null;
        } catch (_) {}
      }
    }

    final serviceName = resolvedService != null
        ? resolvedService['name'] ?? (t['lead_label_service'] ?? 'Servicio')
        : (t['lead_label_service'] ?? 'Servicio');

    String servicePrice = '\$--';
    if (resolvedService != null && resolvedService['price_cents'] != null) {
      final price = (resolvedService['price_cents'] as int) / 100.0;
      servicePrice = '\$${price.toStringAsFixed(2)}';
    }

    String? serviceImageView = resolvedService != null
        ? (resolvedService['profile_image'] as String?)
        : null;

    if (serviceImageView != null && !serviceImageView.startsWith('http')) {
      serviceImageView =
          'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/$serviceImageView';
    }

    final amount = (lead.requestBudgetMax ?? 0) / 100.0;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h4(
            t['lead_section_about'] ?? 'About request',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Service Widget
          if (resolvedService != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.muted,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colorScheme.border),
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: serviceImageView != null
                          ? DecorationImage(
                              image: NetworkImage(serviceImageView!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: theme.colorScheme.mutedForeground,
                    ),
                    child: serviceImageView == null
                        ? Center(
                            child: Icon(
                              Icons.spa,
                              color: theme.colorScheme.background,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AppText.small(
                            t['lead_label_service'] ?? "Service",
                            color: Colors.black,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        AppText.p(
                          serviceName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        AppText.small(servicePrice, color: Colors.green),
                      ],
                    ),
                  ),
                  AppButton.ghost(
                    onPressed: () {
                      context.push(
                        '/business/create-service',
                        extra: resolvedService,
                      );
                    },
                    text: "Ver servicio",
                  ),
                ],
              ),
            ),
          if (resolvedService == null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.mutedForeground,
                  ),
                  const SizedBox(width: 8),
                  AppText.p(
                    t['lead_error_no_service'] ?? "No service info available",
                    color: theme.colorScheme.mutedForeground,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          AppText.small("Mensaje:", color: theme.colorScheme.mutedForeground),
          const SizedBox(height: 4),
          AppText.p(
            lead.requestDescription.isNotEmpty
                ? lead.requestDescription
                : "Sin descripción.",
            style: const TextStyle(height: 1.4, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              AppText.p(
                "Presupuesto: ",
                color: theme.colorScheme.mutedForeground,
              ),
              AppText.p(
                "\$${amount.toStringAsFixed(0)}",
                color: Colors.green,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppButton.primary(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) =>
                      BusinessProposalSheet(prefilledLead: lead),
                );
              },
              text: t['lead_action_quote'] ?? "Cotizar",
            ),
          ),
        ],
      ),
    );
  }
}
