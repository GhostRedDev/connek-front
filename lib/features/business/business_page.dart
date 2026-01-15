import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/business_leads_widget.dart';
import 'widgets/business_overview_widget.dart';
import 'widgets/business_clients_widget.dart'; // Added
import 'providers/business_provider.dart'; // Added
import 'widgets/business_services_widget.dart';
import 'widgets/business_employees_widget.dart';
import 'widgets/business_profile_widget.dart'; // Added // Added // Added

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

    return TabBarView(
      children: [
        // TAB 1: OVERVIEW
        BusinessOverviewWidget(),

        // TAB 2: LEADS
        const BusinessLeadsWidget(),

        // TAB 3: CLIENTS
        const BusinessClientsWidget(),

        // TAB 4: SALES
        // TAB 4: SALES
        const BusinessSalesTab(),

        // TAB 5: SERVICES
        const BusinessServicesWidget(),

        // TAB 6: EMPLOYEES
        const BusinessEmployeesWidget(),

        // TAB 7: PROFILE
        const BusinessProfileWidget(),

        // TAB 8: SETTINGS
        const _BusinessPlaceholder(title: 'Ajustes'),
      ],
    );
  }
}

class BusinessSalesTab extends ConsumerWidget {
  const BusinessSalesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(selectedSalesViewProvider);

    switch (view) {
      case 'invoices':
        return const _BusinessPlaceholder(title: 'Ventas - Facturas');
      case 'proposals':
        return const _BusinessPlaceholder(title: 'Ventas - Propuestas');
      case 'bookings':
        return const _BusinessPlaceholder(title: 'Ventas - Bookings');
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 48,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '$title - Coming Soon',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
