import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/system_ui/form/selects.dart'; // AppSelect
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';

class LeadManagementTile extends ConsumerWidget {
  final Lead lead;

  const LeadManagementTile({super.key, required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Checks
    final businessData = ref.watch(businessProvider).value;
    final hasMissingDate = lead.bookingMade && lead.proposedBookingDate == null;
    final hasDraftProposals =
        businessData?.quotes.any(
          (q) => q['status'] == 'draft' && q['lead_id'] == lead.id,
        ) ??
        false;

    return AppCard(
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: Border.all(color: Colors.transparent),
        title: Row(
          children: [
            Icon(Icons.manage_accounts, color: Colors.blue[900]),
            const SizedBox(width: 12),
            AppText.h4(
              "Gestionar Cliente Potencial",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Validation / Missing items
                if (hasMissingDate || hasDraftProposals) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        if (hasDraftProposals)
                          Row(
                            children: [
                              const Icon(
                                Icons.warning_amber,
                                color: Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              AppText.small(
                                "Propuestas en borrador",
                                color: Colors.orange[800],
                              ),
                            ],
                          ),
                        if (hasMissingDate)
                          Row(
                            children: [
                              const Icon(
                                Icons.event_busy,
                                color: Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              AppText.small(
                                "Falta definir fecha",
                                color: Colors.orange[800],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Toggles
                const Divider(),
                _buildToggle(
                  context,
                  ref,
                  lead,
                  "Visto por mí",
                  lead.seen,
                  'seen',
                ),
                _buildToggle(
                  context,
                  ref,
                  lead,
                  "Cliente Contactado",
                  lead.clientContacted,
                  'client_contacted',
                ),
                _buildToggle(
                  context,
                  ref,
                  lead,
                  "Propuesta Enviada",
                  lead.proposalSent,
                  'proposal_sent',
                ),
                _buildToggle(
                  context,
                  ref,
                  lead,
                  "Booking Agendado",
                  lead.bookingMade,
                  'booking_made',
                ),
                _buildToggle(
                  context,
                  ref,
                  lead,
                  "Pago Realizado",
                  lead.paymentMade,
                  'payment_made',
                ),

                const Divider(height: 24),

                // Propose Appointment
                SizedBox(
                  width: double.infinity,
                  child: AppButton.outline(
                    onPressed: () async {
                      // Show Date Picker
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null && context.mounted) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          // Call backend to update 'proposed_booking_date'
                          final dateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );

                          await ref
                              .read(businessProvider.notifier)
                              .updateLeadField(lead.id, {
                                'proposed_booking_date': dateTime
                                    .toIso8601String(),
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Cita propuesta para ${DateFormat('dd/MM').format(date)} a las ${time.format(context)}",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    icon: Icons.calendar_today,
                    text: "Proponer Cita",
                  ),
                ),
                const SizedBox(height: 16),

                // Status Dropdown
                AppText.small("Estado del Lead", color: Colors.grey),
                const SizedBox(height: 8),
                AppSelect<String>(
                  value:
                      ['open', 'completed', 'cancelled'].contains(lead.status)
                      ? lead.status
                      : 'open',
                  options: const {
                    'open': 'Abierto / En Progreso',
                    'completed': 'Completado',
                    'cancelled': 'Cancelado',
                  },
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(businessProvider.notifier).updateLeadField(
                        lead.id,
                        {'status': val},
                      );
                    }
                  },
                  placeholder: 'Seleccionar estado',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(
    BuildContext context,
    WidgetRef ref,
    Lead lead,
    String title,
    bool value,
    String field,
  ) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.inter(fontSize: 14)),
      value: value,
      contentPadding: EdgeInsets.zero,
      dense: true,
      activeColor: Colors.blue[900],
      onChanged: (val) {
        ref.read(businessProvider.notifier).updateLeadField(lead.id, {
          field: val,
        });
      },
    );
  }
}
