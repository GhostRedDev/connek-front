import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/business_leads_widget.dart';
import 'widgets/business_overview_widget.dart';
import 'widgets/business_clients_widget.dart'; // Added

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

    return DefaultTabController(
      length: 8, // Updated to 8 tabs
      child: TabBarView(
        children: [
          // TAB 1: OVERVIEW
          BusinessOverviewWidget(),

          // TAB 2: LEADS
          const BusinessLeadsWidget(),

          // TAB 3: CLIENTS
          const BusinessClientsWidget(),

          // TAB 4: SALES
          const _BusinessPlaceholder(title: 'Ventas'),

          // TAB 5: SERVICES
          const _BusinessPlaceholder(title: 'Servicios'),

          // TAB 6: EMPLOYEES
          const _BusinessPlaceholder(title: 'Empleados'),

          // TAB 7: PROFILE
          const _BusinessPlaceholder(title: 'Perfil'),

          // TAB 8: SETTINGS
          const _BusinessPlaceholder(title: 'Ajustes'),
        ],
      ),
    );
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
