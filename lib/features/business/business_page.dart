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
      length: 3,
      child: TabBarView(
        children: [
          // TAB 1: OVERVIEW
          BusinessOverviewWidget(),

          // TAB 2: LEADS
          const BusinessLeadsWidget(),

          // TAB 3: CLIENTS
          // TAB 3: CLIENTS
          const BusinessClientsWidget(),
        ],
      ),
    );
  }
}
