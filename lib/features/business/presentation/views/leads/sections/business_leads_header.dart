import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/lead_newx_widget.dart';

class BusinessLeadsHeader extends StatelessWidget {
  final List<Lead> recentLeads;
  final Map<String, dynamic> t;

  const BusinessLeadsHeader({
    super.key,
    required this.recentLeads,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    if (recentLeads.isEmpty) return const SizedBox.shrink();

    final theme = ShadTheme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: AppText.h4(
              t['received_last_week'] ?? 'Recibidos la semana pasada',
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: recentLeads.take(5).map((lead) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: LeadNewxWidget(lead: lead),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
