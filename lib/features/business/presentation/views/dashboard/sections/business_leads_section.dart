import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/lead_newx_widget.dart';
import 'package:connek_frontend/system_ui/layout/buttons.dart';

class BusinessLeadsSection extends StatelessWidget {
  final List<Lead> leads;
  final Map<String, dynamic> t;

  const BusinessLeadsSection({super.key, required this.leads, required this.t});

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
              AppText.h4(t['recent_leads'] ?? 'Leads recientes'),
              // Optional: Add "View All" button here if needed
            ],
          ),
          const SizedBox(height: 20),
          if (leads.isEmpty)
            _NoLeadsCard(t: t)
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...leads
                      .take(5)
                      .map(
                        (lead) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: LeadNewxWidget(lead: lead),
                        ),
                      ),
                  if (leads.length > 5)
                    _SeeAllLeadsCard(excessCount: leads.length - 5, t: t),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NoLeadsCard extends StatelessWidget {
  final Map<String, dynamic> t;
  const _NoLeadsCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.inbox_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 10),
            AppText.p(
              t['no_leads_yet'] ?? 'No hay leads recientes',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeeAllLeadsCard extends StatelessWidget {
  final int excessCount;
  final Map<String, dynamic> t;

  const _SeeAllLeadsCard({required this.excessCount, required this.t});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E222D)
            : Colors.grey[50], // Match card bg
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: AppText.h4(
                '+$excessCount',
                style: const TextStyle(color: Color(0xFF4285F4)),
              ),
            ),
            const SizedBox(height: 8),
            AppText.small(t['see_all'] ?? 'Ver todos'),
          ],
        ),
      ),
    );
  }
}
