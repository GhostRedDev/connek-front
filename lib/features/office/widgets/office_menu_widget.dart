import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/providers/locale_provider.dart';

class OfficeMenuWidget extends ConsumerWidget {
  final Function(int index) onTabSelected;
  final int selectedIndex;

  const OfficeMenuWidget({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    // Theme Colors
    final shadTheme = ShadTheme.of(context);
    final inactiveTextColor = shadTheme.colorScheme.mutedForeground;

    return Center(
      child: Container(
        height: 56,
        width: double.infinity,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: shadTheme.colorScheme.card,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: shadTheme.colorScheme.border),
        ),
        child: _DragHorizontalScroll(
          builder: (controller) => SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tab 1: My Bots
                _buildMenuOption(
                  context,
                  index: 0,
                  icon: Icons.smart_toy_outlined,
                  label: t['office_tab_my_bots'] ?? 'My bots',
                  isActive: selectedIndex == 0,
                  activeBg: shadTheme.colorScheme.primary,
                  activeText: shadTheme.colorScheme.primaryForeground,
                  inactiveText: inactiveTextColor,
                ),

                const SizedBox(width: 4),

                // Tab 2: Marketplace
                _buildMenuOption(
                  context,
                  index: 1,
                  icon: Icons.storefront_outlined,
                  label: t['office_tab_marketplace'] ?? 'Marketplace',
                  isActive: selectedIndex == 1,
                  activeBg: shadTheme.colorScheme.primary,
                  activeText: shadTheme.colorScheme.primaryForeground,
                  inactiveText: inactiveTextColor,
                ),

                const SizedBox(width: 4),

                // Tab 3: Staff
                _buildMenuOption(
                  context,
                  index: 2,
                  icon: Icons.people_outline,
                  label: t['office_tab_staff'] ?? 'Staff',
                  isActive: selectedIndex == 2,
                  activeBg: shadTheme.colorScheme.primary,
                  activeText: shadTheme.colorScheme.primaryForeground,
                  inactiveText: inactiveTextColor,
                ),

                const SizedBox(width: 4),

                // Tab 4: Resources
                _buildMenuOption(
                  context,
                  index: 3,
                  icon: Icons.source_outlined,
                  label: t['office_tab_resources'] ?? 'Resources',
                  isActive: selectedIndex == 3,
                  activeBg: shadTheme.colorScheme.primary,
                  activeText: shadTheme.colorScheme.primaryForeground,
                  inactiveText: inactiveTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeBg,
    required Color activeText,
    required Color inactiveText,
  }) {
    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(31),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        constraints: BoxConstraints(minWidth: isActive ? 120 : 56),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? activeText : inactiveText, size: 18),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: isActive ? activeText : inactiveText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
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
