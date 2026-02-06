import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/system_ui/layout/buttons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:connek_frontend/features/business/presentation/views/sales/event_card_widget.dart';

class BusinessEventsSection extends StatelessWidget {
  final List<dynamic> events;
  final Map<String, dynamic> t;

  const BusinessEventsSection({
    super.key,
    required this.events,
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
              AppText.h4(t['upcoming_events'] ?? 'Próximos Eventos'),
              AppButton.ghost(
                text: t['add'] ?? 'Añadir',
                icon: Icons.add,
                onPressed: () => context.push('/business/create-portfolio'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: EventCardWidget(
              event: events.isNotEmpty
                  ? events.first
                  : const {
                      'title': 'Promoción Especial',
                      'description': 'Ejemplo de evento',
                      'promo_text': 'PROXIMAMENTE',
                    },
            ),
          ),
        ],
      ),
    );
  }
}
