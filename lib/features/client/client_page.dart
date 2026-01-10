import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../settings/providers/profile_provider.dart';
import 'providers/client_requests_provider.dart';
import 'package:go_router/go_router.dart';
import 'widgets/client_metric_card_widget.dart';
import 'widgets/client_section_header_widget.dart';
import 'widgets/client_lead_card_widget.dart';
import 'widgets/client_chart_widget.dart';

class ClientPage extends ConsumerWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AppLayout provides DefaultTabController
    return TabBarView(
      children: [
        // TAB 1: OVERVIEW
        const ClientOverviewWidget(),
        // TAB 2: MARKET
        const Center(
          child: Text(
            'Marketplace - Coming Soon',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // TAB 3: ORDERS
        const Center(
          child: Text(
            'My Orders - Coming Soon',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ClientOverviewWidget extends ConsumerWidget {
  const ClientOverviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 210, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileAsync.when(
            data: (profile) => Text(
              'Welcome, ${profile?.firstName ?? 'User'}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            loading: () => const SizedBox(height: 50),
            error: (_, __) => const Text("Client Dashboard"),
          ),
          const SizedBox(height: 20),

          // --- METRICS ---
          const Row(
            children: [
              Expanded(
                child: ClientMetricCardWidget(
                  title: 'GASTADO',
                  value: '\$1,250',
                  change: '+15%',
                  icon: Icons.account_balance_wallet,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ClientMetricCardWidget(
                  title: 'ORDENES',
                  value: '8',
                  change: '+2',
                  icon: Icons.shopping_bag,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- CHART ---
          ClientSectionHeaderWidget(title: 'Gastos Mensuales', onSeeAll: () {}),
          const ClientChartWidget(),
          const SizedBox(height: 24),

          // --- RECENT ORDERS ---
          ClientSectionHeaderWidget(
            title: 'Ordenes Recientes',
            onSeeAll: () => context.push('/client/dashboard/requests'),
          ),
          SizedBox(
            height: 180,
            child: Consumer(
              builder: (context, ref, child) {
                final requestsAsync = ref.watch(clientRequestsProvider);

                return requestsAsync.when(
                  data: (requests) {
                    if (requests.isEmpty) {
                      return const Center(
                        child: Text(
                          "No hay ordenes recientes",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final req = requests[index];
                        return GestureDetector(
                          onTap: () {
                            context.push('/client/request-details', extra: req);
                          },
                          child: ClientLeadCardWidget(
                            lead: {
                              'name': req.title,
                              'role': req.role,
                              'amount': req.amount.toStringAsFixed(0),
                              'image': req.imageUrl,
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(
                    child: Text(
                      "Error: $e",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
