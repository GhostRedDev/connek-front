import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessMenuWidget extends ConsumerWidget {
  final Function(int index) onTabSelected;
  final int selectedIndex;

  const BusinessMenuWidget({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Theme Colors
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inactiveTextColor = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    final tabs = [
      {'icon': Icons.dashboard_outlined, 'label': 'Resumen'},
      {'icon': Icons.person_search_outlined, 'label': 'Leads'},
      {'icon': Icons.people_outline, 'label': 'Clientes'},
      {'icon': Icons.receipt, 'label': 'Ventas'},
      {'icon': Icons.description_outlined, 'label': 'Cotizaciones'},
      {'icon': Icons.event_available_outlined, 'label': 'Bookings'},
      {'icon': Icons.design_services_outlined, 'label': 'Servicios'},
      {'icon': Icons.badge_outlined, 'label': 'Equipo'},
      {'icon': Icons.person_outline, 'label': 'Perfil'},
      {'icon': Icons.settings_outlined, 'label': 'Configuración'},
      {'icon': Icons.account_balance_outlined, 'label': 'Contabilidad'},
    ];

    return Center(
      child: Container(
        height: 56,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _DragHorizontalScroll(
          builder: (controller) => ListView.separated(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: tabs.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(width: 4),
            itemBuilder: (context, index) {
              final tab = tabs[index];
              final isActive = selectedIndex == index;

              return InkWell(
                onTap: () => onTabSelected(index),
                borderRadius: BorderRadius.circular(100),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isActive
                        ? (isDark ? Colors.white : Colors.black)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  constraints: BoxConstraints(minWidth: isActive ? 120 : 56),
                  child: Row(
                    children: [
                      Icon(
                        tab['icon'] as IconData,
                        size: 20,
                        color: isActive
                            ? (isDark ? Colors.black : Colors.white)
                            : inactiveTextColor,
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 8),
                        Text(
                          tab['label'] as String,
                          style: TextStyle(
                            color: isActive
                                ? (isDark ? Colors.black : Colors.white)
                                : inactiveTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DragHorizontalScroll extends StatefulWidget {
  final Widget Function(ScrollController controller) builder;
  const _DragHorizontalScroll({required this.builder});

  @override
  State<_DragHorizontalScroll> createState() => _DragHorizontalScrollState();
}

class _DragHorizontalScrollState extends State<_DragHorizontalScroll> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDrag(DragUpdateDetails details) {
    if (!_controller.hasClients) return;
    final max = _controller.position.maxScrollExtent;
    final min = _controller.position.minScrollExtent;
    final target = (_controller.offset - details.delta.dx).clamp(min, max);
    _controller.jumpTo(target);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: _handleDrag,
      child: widget.builder(_controller),
    );
  }
}
