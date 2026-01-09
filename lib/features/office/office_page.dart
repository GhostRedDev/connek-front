import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../settings/providers/profile_provider.dart';

class OfficePage extends ConsumerWidget {
  const OfficePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AppLayout provides DefaultTabController
    // Tabs: ['Overview', 'Reports', 'Team']

    return TabBarView(
      children: [
        // TAB 1: OVERVIEW
        _OfficeOverviewTab(),

        // TAB 2: REPORTS
        Center(
          child: Text(
            "Office Reports",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),

        // TAB 3: TEAM
        Center(
          child: Text(
            "Office Team",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}

class _OfficeOverviewTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return SingleChildScrollView(
      // Padding matches global header height (approx 200px)
      padding: const EdgeInsets.fromLTRB(16, 210, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileAsync.when(
            data: (profile) => Text(
              'Office Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            loading: () => const SizedBox(height: 50),
            error: (_, __) => const Text("Office"),
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "Recent Activities",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
