import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BusinessMetricsSection extends StatelessWidget {
  final int totalRequests;
  final double monthEarnings;
  final Map<String, dynamic> t;

  const BusinessMetricsSection({
    super.key,
    required this.totalRequests,
    required this.monthEarnings,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 600;

        if (isDesktop) {
          return Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: t['total_requests'] ?? 'TOTAL REQUESTS',
                  value: '$totalRequests',
                  percentage: '12%',
                  icon: Icons.person_add_alt_1_rounded,
                  color: Colors.blueAccent,
                  sinceText: t['since_last_month'] ?? 'since last month',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _MetricCard(
                  label: t['earnings'] ?? 'EARNINGS',
                  value: '$monthEarnings',
                  percentage: '12%',
                  icon: Icons.flash_on_rounded,
                  color: Colors.amber,
                  sinceText: t['since_last_month'] ?? 'since last month',
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _MetricCard(
              label: t['total_requests'] ?? 'TOTAL REQUESTS',
              value: '$totalRequests',
              percentage: '12%',
              icon: Icons.person_add_alt_1_rounded,
              color: Colors.blueAccent,
              sinceText: t['since_last_month'] ?? 'since last month',
            ),
            const SizedBox(height: 12),
            _MetricCard(
              label: t['earnings'] ?? 'EARNINGS',
              value: '$monthEarnings',
              percentage: '12%',
              icon: Icons.flash_on_rounded,
              color: Colors.amber,
              sinceText: t['since_last_month'] ?? 'since last month',
            ),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String percentage;
  final IconData icon;
  final Color color;
  final String sinceText;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.sinceText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.small(
                label.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppText.h2(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4EA),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_upward,
                      size: 12,
                      color: Color(0xFF137333),
                    ), // Green
                    const SizedBox(width: 4),
                    Text(
                      percentage,
                      style: const TextStyle(
                        color: Color(0xFF137333),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppText.small(
                  sinceText,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
