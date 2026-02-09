import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connek_frontend/system_ui/system_ui.dart';
import '../providers/activity_feed_provider.dart';
import '../widgets/activity_card.dart';

class StaffActivityFeedPage extends StatefulWidget {
  final int businessId;

  const StaffActivityFeedPage({super.key, required this.businessId});

  @override
  State<StaffActivityFeedPage> createState() => _StaffActivityFeedPageState();
}

class _StaffActivityFeedPageState extends State<StaffActivityFeedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityFeedProvider>().fetchActivities(widget.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(Icons.feed_outlined, size: 24, color: colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Feed de Actividades',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                AppButton.outline(
                  text: 'Actualizar',
                  icon: Icons.refresh,
                  onPressed: () => context
                      .read<ActivityFeedProvider>()
                      .fetchActivities(widget.businessId),
                ),
              ],
            ),
          ),

          // Activity Feed
          Expanded(
            child: Consumer<ActivityFeedProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: AppCard(
                          title: 'Ocurrió un error',
                          description: 'No pudimos cargar el feed.',
                          footer: Align(
                            alignment: Alignment.centerRight,
                            child: AppButton.outline(
                              text: 'Reintentar',
                              icon: Icons.refresh,
                              onPressed: () =>
                                  provider.fetchActivities(widget.businessId),
                            ),
                          ),
                          child: AppText.p(
                            provider.error!,
                            style: theme.textTheme.bodyMedium,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (provider.activities.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: AppCard(
                          title: 'Sin actividades',
                          description: 'Aquí aparecerán eventos del equipo.',
                          footer: Align(
                            alignment: Alignment.centerRight,
                            child: AppButton.outline(
                              text: 'Actualizar',
                              icon: Icons.refresh,
                              onPressed: () =>
                                  provider.fetchActivities(widget.businessId),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                size: 20,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppText.muted(
                                  'Todavía no hay movimientos registrados.',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => provider.fetchActivities(widget.businessId),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: provider.activities.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ActivityCard(
                          activity: provider.activities[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
