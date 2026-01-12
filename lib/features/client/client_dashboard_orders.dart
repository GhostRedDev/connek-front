import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/providers/locale_provider.dart';
import 'client_dashboard_requests.dart';
import 'client_dashboard_booking.dart';

class ClientDashboardOrders extends ConsumerStatefulWidget {
  const ClientDashboardOrders({super.key});

  @override
  ConsumerState<ClientDashboardOrders> createState() =>
      _ClientDashboardOrdersState();
}

class _ClientDashboardOrdersState extends ConsumerState<ClientDashboardOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Sub-Tab Navigation (Pill Style)
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2429) : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: const Color(0xFF4B39EF), // Primary color
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: isDark ? Colors.grey : Colors.grey[700],
            labelStyle: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: t['client_tab_requests'] ?? 'Solicitudes'),
              Tab(text: t['client_tab_bookings'] ?? 'Reservas'),
            ],
          ),
        ),

        // Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              ClientDashboardRequests(),
              ClientDashboardBooking(),
            ],
          ),
        ),
      ],
    );
  }
}
