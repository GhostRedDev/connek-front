import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/system_ui/layout/buttons.dart'; // AppButton
import 'package:connek_frontend/system_ui/typography.dart'; // AppText
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/details/sections/lead_client_card.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/details/sections/lead_about_card.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/details/sections/lead_timeline.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/details/sections/lead_financials.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/details/sections/lead_management_tile.dart';

class LeadDetailsPage extends ConsumerWidget {
  final Lead lead;
  final Map<String, dynamic>? service;

  const LeadDetailsPage({super.key, required this.lead, this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final businessData = ref.watch(businessProvider).value;

    // Try to find updated lead in provider, otherwise use passed lead
    final currentLead =
        businessData?.recentLeads.firstWhere(
          (l) => l.id == lead.id,
          orElse: () => lead,
        ) ??
        lead;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Center(
          child: AppButton.outline(
            width: 90,
            text: t['lead_details_back'] ?? "Volver",
            icon: Icons.arrow_back_ios_new,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: AppText.h4(
          t['lead_details_title'] ?? 'Detalles del cliente potencial',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          if (isDesktop) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- LEFT COLUMN ---
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        LeadClientCard(lead: currentLead),
                        const SizedBox(height: 20),
                        LeadAboutCard(lead: currentLead, service: service),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // --- RIGHT COLUMN ---
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        LeadTimeline(lead: currentLead),
                        const SizedBox(height: 20),
                        LeadFinancials(
                          lead: currentLead,
                          cardColor: Theme.of(context).cardColor,
                        ),
                        const SizedBox(height: 20),
                        LeadManagementTile(lead: currentLead),
                        const SizedBox(height: 20),

                        // Delete Button
                        SizedBox(
                          width: double.infinity,
                          child: AppButton.destructive(
                            onPressed: () {},
                            text: t['lead_action_delete'] ?? "Eliminar Lead",
                            icon: Icons.delete_outline,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // --- MOBILE LAYOUT ---
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                LeadClientCard(lead: currentLead),
                const SizedBox(height: 20),
                LeadAboutCard(lead: currentLead, service: service),
                const SizedBox(height: 20),
                LeadTimeline(lead: currentLead),
                const SizedBox(height: 20),
                LeadManagementTile(lead: currentLead),
                const SizedBox(height: 20),
                LeadFinancials(
                  lead: currentLead,
                  cardColor: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 20),

                // Delete Button
                SizedBox(
                  width: double.infinity,
                  child: AppButton.destructive(
                    onPressed: () {},
                    text: t['lead_action_delete'] ?? "Eliminar Lead",
                    icon: Icons.delete_outline,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
