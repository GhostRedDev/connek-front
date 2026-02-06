import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart' as shad;

import '../views/leads/business_leads_widget.dart';
import '../views/dashboard/business_overview_widget.dart';
import '../views/clients/business_clients_widget.dart';
import '../providers/business_provider.dart';
import '../views/services/business_services_widget.dart';
import '../views/admin/business_employees_widget.dart';
import '../views/admin/business_profile_widget.dart';
import '../views/sales/business_proposals_widget.dart';
import '../views/finances/business_invoices_widget.dart';
import '../views/sales/business_bookings_widget.dart';
import '../views/admin/business_settings_widget.dart';
import '../views/finances/business_accounting_widget.dart';

class BusinessPage extends ConsumerStatefulWidget {
  const BusinessPage({super.key});

  @override
  ConsumerState<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends ConsumerState<BusinessPage> {
  // Config: Header height is now handled globally (approx 200px)
  // Logic: AppLayout provides DefaultTabController.

  @override
  Widget build(BuildContext context) {
    // We don't need a Scaffold or Stack for header anymore.
    // Just the TabBarView content.

    // Check inherited controller to prevent crash if AppLayout thinks we are in a different mode
    final inheritedController = DefaultTabController.of(context);
    final inheritedLength = inheritedController.length;
    const requiredLength = 9;

    Widget content = TabBarView(
      children: [
        // TAB 1: OVERVIEW
        BusinessOverviewWidget(),

        // TAB 2: LEADS
        const BusinessLeadsWidget(),

        // TAB 3: CLIENTS
        const BusinessClientsWidget(),

        // TAB 4: SALES
        const BusinessSalesTab(),

        // TAB 5: SERVICES
        const BusinessServicesWidget(),

        // TAB 6: EMPLOYEES
        const BusinessEmployeesWidget(),

        // TAB 7: PROFILE
        const BusinessProfileWidget(),

        // TAB 8: SETTINGS
        const BusinessSettingsWidget(),

        // TAB 9: ACCOUNTING
        const BusinessAccountingWidget(),
      ],
    );

    if (inheritedLength != requiredLength) {
      return DefaultTabController(length: requiredLength, child: content);
    }

    return content;
  }
}

class BusinessSalesTab extends ConsumerWidget {
  const BusinessSalesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(selectedSalesViewProvider);

    switch (view) {
      case 'invoices':
        return const BusinessInvoicesWidget();
      case 'proposals':
        return const BusinessProposalsWidget();
      case 'bookings':
        return const BusinessBookingsWidget();
      default:
        return const _BusinessPlaceholder(title: 'Ventas - General');
    }
  }
}

class _BusinessPlaceholder extends StatelessWidget {
  final String title;
  const _BusinessPlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = shad.ShadTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 48,
            color: theme.colorScheme.mutedForeground.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          AppText.h3(
            '$title - Coming Soon',
            style: TextStyle(color: theme.colorScheme.mutedForeground),
          ),
        ],
      ),
    );
  }
}
