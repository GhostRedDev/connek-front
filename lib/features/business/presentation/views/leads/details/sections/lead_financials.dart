import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/system_ui/feedback/dialogs.dart'; // AppDialog
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';

class LeadFinancials extends ConsumerWidget {
  final Lead lead;
  final Color cardColor;

  const LeadFinancials({
    super.key,
    required this.lead,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessData = ref.watch(businessProvider).value;
    final quotes =
        businessData?.quotes.where((q) {
          final qLeadId = q['lead_id'];
          final qLeads = q['leads'];
          final nestedLeadId = qLeads is Map ? qLeads['id'] : null;
          return qLeadId == lead.id || nestedLeadId == lead.id;
        }).toList() ??
        [];

    // Sort by date descending if created_at exists
    quotes.sort((a, b) {
      final dateA =
          DateTime.tryParse(a['created_at']?.toString() ?? '') ??
          DateTime(2000);
      final dateB =
          DateTime.tryParse(b['created_at']?.toString() ?? '') ??
          DateTime(2000);
      return dateB.compareTo(dateA);
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Actividad Comercial",
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            "Booking",
            lead.bookingMade ? "Agendado" : "Pendiente",
            lead.bookingMade ? Colors.green : Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            "Pago",
            lead.paymentMade ? "Pagado" : "Pendiente",
            lead.paymentMade ? Colors.green : Colors.orange,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1),
          ),
          if (!lead.paymentMade)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: AppButton.primary(
                  onPressed: () => _showPaymentDialog(context, ref, lead),
                  icon: Icons.attach_money,
                  text: "Registrar Pago",
                ),
              ),
            ),
          AppText.h4(
            "Propuestas",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 12),
          if (quotes.isEmpty)
            AppText.p("No se han enviado propuestas.", color: Colors.grey)
          else
            ...quotes.map((q) {
              final status = q['status'] ?? 'Draft';
              final isAccepted = status == 'accepted' || status == 'paid';
              final isCounterOffer = status == 'counter_offer';

              Color statusColor = Colors.blue;
              Color statusBg = Colors.blue.withOpacity(0.1);

              if (isAccepted) {
                statusColor = Colors.green;
                statusBg = Colors.green.withOpacity(0.1);
              } else if (isCounterOffer) {
                statusColor = Colors.deepPurple;
                statusBg = Colors.deepPurple.withOpacity(0.1);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Propuesta #${q['id']}",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${((q['amount_cents'] ?? q['amountCents'] ?? 0) / 100).toStringAsFixed(2)}",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isCounterOffer
                            ? "CONTRA OFERTA"
                            : status.toString().toUpperCase(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                color == Colors.green
                    ? Icons.check_circle
                    : Icons.hourglass_empty,
                size: 12,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showPaymentDialog(
    BuildContext context,
    WidgetRef ref,
    Lead lead,
  ) async {
    final confirmed = await AppDialog.confirm(
      context,
      title: "Registrar Pago",
      description:
          "¿Confirmas que has recibido el pago por este servicio? Esta acción marcará el lead como PAGADO.",
      confirmText: "Confirmar Pago",
    );

    if (confirmed) {
      // Implement payment logic
    }
  }
}
