import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dashboard Views
import 'client_dashboard_orders.dart';
import '../office/widgets/office_marketplace_widget.dart'; // Reusing marketplace
import 'client_dashboard_bookmarks.dart'; // Treating bookmarks as "Resumen" or part of it for now

class ClientPage extends ConsumerWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check inherited controller to prevent crash if AppLayout thinks we are in a different mode (e.g. Business with 8 tabs)
    final inheritedController = DefaultTabController.of(context);
    final inheritedLength = inheritedController.length;
    const requiredLength = 3;

    Widget content = const TabBarView(
      children: [
        // Resumen
        ClientDashboardBookmarks(),

        // Mercado
        OfficeMarketplaceWidget(),

        // Ordenes
        ClientDashboardOrders(),
      ],
    );

    if (inheritedLength != requiredLength) {
      return DefaultTabController(length: requiredLength, child: content);
    }

    return content;
  }
}
