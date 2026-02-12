import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/features/business/presentation/views/shared/business_shared_widgets.dart';

import 'sections/business_metrics_section.dart';
import 'sections/business_leads_section.dart';
import 'sections/business_events_section.dart';
import 'sections/business_employees_section.dart';
import 'sections/business_services_section.dart';

class BusinessOverviewWidget extends ConsumerWidget {
  const BusinessOverviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessData = ref.watch(businessProvider);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return businessData.when(
      data: (data) => LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                const EmptySpaceTopWidget(),

                // --- Metric Blocks ---
                BusinessMetricsSection(
                  totalRequests: data.totalRequests,
                  monthEarnings: data.monthEarnings,
                  t: t,
                ),
                const SizedBox(height: 20),

                if (isDesktop) ...[
                  // Desktop Grid Layout
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Leads (60%)
                      Expanded(
                        flex: 3,
                        child: BusinessLeadsSection(
                          leads: data.recentLeads,
                          t: t,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Column 2: Events (40%)
                      Expanded(
                        flex: 2,
                        child: BusinessEventsSection(events: data.events, t: t),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Employees
                      Expanded(
                        child: BusinessEmployeesSection(
                          employees: data.employees,
                          t: t,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Column 2: Services
                      Expanded(
                        child: BusinessServicesSection(
                          services: data.services,
                          t: t,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Mobile Vertical Layout
                  BusinessLeadsSection(leads: data.recentLeads, t: t),
                  const SizedBox(height: 20),
                  BusinessEventsSection(events: data.events, t: t),
                  const SizedBox(height: 20),
                  BusinessEmployeesSection(employees: data.employees, t: t),
                  const SizedBox(height: 20),
                  BusinessServicesSection(services: data.services, t: t),
                ],
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
