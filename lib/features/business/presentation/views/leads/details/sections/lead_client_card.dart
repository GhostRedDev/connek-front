import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';

class LeadClientCard extends ConsumerWidget {
  final Lead lead;

  const LeadClientCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    final name = '${lead.clientFirstName} ${lead.clientLastName}'.trim();
    final leadImage = lead.clientImageUrl;
    final leadImageUrl = (leadImage != null && leadImage.isNotEmpty)
        ? (leadImage.startsWith('http')
              ? leadImage
              : 'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/client/$leadImage')
        : '';

    final dateStr =
        '${lead.createdAt.day}/${lead.createdAt.month}/${lead.createdAt.year} ${lead.createdAt.hour}:${lead.createdAt.minute.toString().padLeft(2, '0')}';
    final amount = (lead.requestBudgetMax ?? 0) / 100.0;

    // Status Logic
    String statusText = t['lead_status_pending'] ?? 'Pendiente';
    Color statusColor = const Color(0xFFFB8C00); // Warning/Orange
    Color statusBgColor = const Color(0xFFFFF3E0);

    if (lead.status == 'completed' || lead.status == 'converted') {
      statusText = t['lead_status_completed'] ?? 'Completado';
      statusColor = const Color(0xFF4285F4); // Primary/Blue
      statusBgColor = const Color(0xFFE3F2FD);
    } else if (lead.status == 'cancelled' || lead.status == 'declined') {
      statusText = t['lead_status_cancelled'] ?? 'Cancelado';
      statusColor = const Color(0xFFFF5252); // Destructive/Red
      statusBgColor = const Color(0xFFFFEBEE);
    }

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: leadImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.small(
                      'Financial',
                      color: theme.colorScheme.mutedForeground,
                    ),
                    AppText.h4(name),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    AppText.small(
                      "5.0",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  AppText.small(
                    dateStr,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E20),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppText.small(
                      '\$${amount.toStringAsFixed(0)}',
                      color: Colors.white,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppText.small(
                      statusText,
                      color: statusColor,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton.outline(
                  onPressed: () => context.push('/chats/${lead.id}'),
                  icon: Icons.message_outlined,
                  text: t['lead_action_message'] ?? 'Mensaje',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton.outline(
                  onPressed: () async {
                    final uri = Uri.parse('tel:${lead.clientPhone ?? ""}');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              t['lead_error_call_failed'] ??
                                  "No se pudo iniciar la llamada",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  icon: Icons.phone_outlined,
                  text: t['lead_action_call'] ?? 'Llamar',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
