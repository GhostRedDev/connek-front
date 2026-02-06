import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/lead_newx_widget.dart';
import 'package:connek_frontend/features/business/presentation/views/leads/lead_card_info_widget.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/system_ui/layout/buttons.dart';

class BusinessLeadsList extends StatelessWidget {
  final List<dynamic>
  leads; // Using dynamic because List<Lead> vs List<Map> ambiguity in legacy
  final bool isListMode;
  final Function(bool) onToggleMode;
  final Map<String, dynamic> t;

  const BusinessLeadsList({
    super.key,
    required this.leads,
    required this.isListMode,
    required this.onToggleMode,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    if (leads.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            AppText.h3(t['leads_empty_title'] ?? 'No hay leads aún'),
            const SizedBox(height: 8),
            AppText.p(
              t['leads_empty_desc'] ??
                  'Tus clientes potenciales aparecerán aquí.',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // View Toggle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.grid_view_rounded,
                        color: !isListMode
                            ? const Color(0xFF4285F4)
                            : Colors.grey,
                      ),
                      onPressed: () => onToggleMode(false),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.view_list_rounded,
                        color: isListMode
                            ? const Color(0xFF4285F4)
                            : Colors.grey,
                      ),
                      onPressed: () => onToggleMode(true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Grid/List Content
        if (!isListMode)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: leads.map((lead) {
              return LeadNewxWidget(lead: lead);
            }).toList(),
          )
        else
          Column(
            children: leads.map((lead) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: LeadCardInfoWidget(lead: lead),
              );
            }).toList(),
          ),
      ],
    );
  }
}
