import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../client/models/service_request_model.dart';
import '../models/job_request_search_item.dart';

class SearchResultJobCard extends StatelessWidget {
  final JobRequestSearchItem job;

  const SearchResultJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final budgetText = _budgetLabel(job.budgetMinCents, job.budgetMaxCents);
    final desc = job.description.trim().isEmpty
        ? 'Solicitud sin descripción'
        : job.description.trim();

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final req = _toServiceRequest(job);
        context.push('/client/request-details', extra: req);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withAlpha(31)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trabajo',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [_pill(theme, job.status), _pill(theme, budgetText)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(ThemeData theme, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(31),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  String _budgetLabel(int? minCents, int? maxCents) {
    String money(int cents) => (cents / 100).toStringAsFixed(0);

    if (minCents == null && maxCents == null) return 'Sin presupuesto';
    if (minCents != null && maxCents != null) {
      return '\$${money(minCents)} - \$${money(maxCents)}';
    }
    if (maxCents != null) return 'Máx: \$${money(maxCents)}';
    return 'Mín: \$${money(minCents!)}';
  }

  ServiceRequest _toServiceRequest(JobRequestSearchItem job) {
    final amount = (job.budgetMaxCents ?? 0) / 100.0;

    return ServiceRequest(
      id: job.id,
      title: job.description,
      role: 'Trabajo',
      amount: amount,
      imageUrl:
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?ixlib=rb-4.0.3',
      status: job.status,
      createdAt: job.createdAt,
      clientName: '',
      clientIndustry: '',
      rating: 0,
      message: job.description,
      serviceTitle: '',
      servicePriceRange: '',
      timeline: const [],
      proposals: const [],
    );
  }
}
