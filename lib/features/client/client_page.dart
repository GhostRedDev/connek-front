import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dashboard Views
// Dashboard Views
import 'client_dashboard_requests.dart';
import 'client_dashboard_booking.dart';
import 'client_dashboard_wallet.dart';
import 'client_dashboard_bookmarks.dart';

class ClientPage extends ConsumerWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check inherited controller to prevent crash if AppLayout thinks we are in a different mode
    final inheritedController = DefaultTabController.of(context);
    final inheritedLength = inheritedController.length;
    const requiredLength = 4;

    Widget content = const TabBarView(
      children: [
        // 1. Solicitudes
        ClientDashboardRequests(),

        // 2. Bookings
        ClientDashboardBooking(),

        // 3. Wallet
        ClientDashboardWallet(),

        // 4. Bookmarks
        ClientDashboardBookmarks(),
      ],
    );

    if (inheritedLength != requiredLength) {
      return DefaultTabController(length: requiredLength, child: content);
    }

    return content;
  }
}
