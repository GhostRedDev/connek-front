import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import '../providers/greg_provider.dart';

class GregCard extends ConsumerWidget {
  final bool isActive;
  const GregCard({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shadTheme = ShadTheme.of(context);
    final cs = shadTheme.colorScheme;

    return SizedBox(
      width: 170,
      height: 220,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/GREG_CARD_1.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: cs.muted,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton.primary(
                          text: 'Entrenar',
                          onPressed: () => context.push('/office/train-greg'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      AppButton.ghost(
                        text: '',
                        icon: Icons.chat_bubble_outline,
                        onPressed: () async {
                          final state = ref.read(gregProvider);
                          if (state is GregLoaded) {
                            context.push('/test-greg/${state.greg.businessId}');
                          } else {
                            await AppDialog.alert(
                              context,
                              title: 'Greg',
                              description: 'Greg no está listo aún.',
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 6),
                      AppButton.ghost(
                        text: '',
                        icon: Icons.settings_outlined,
                        onPressed: () => context.push('/office/settings-greg'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 12,
              left: 12,
              child: isActive
                  ? AppBadge.secondary('Activo')
                  : AppBadge.destructive('Inactivo'),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Greg',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: cs.primaryForeground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
