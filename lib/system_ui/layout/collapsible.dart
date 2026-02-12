import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppCollapsible
/// Props: trigger, child (content), open, onOpenChange
class AppCollapsible extends StatelessWidget {
  final Widget trigger;
  final Widget child;
  final bool? open;
  final ValueChanged<bool>? onOpenChange;

  const AppCollapsible({
    super.key,
    required this.trigger,
    required this.child,
    this.open,
    this.onOpenChange,
  });

  @override
  Widget build(BuildContext context) {
    // Basic expansion tile implementation that mimics Collapsible behavior
    // Or Shadcn Accordion single item
    return ExpansionTile(
      title: trigger,
      initiallyExpanded: open ?? false,
      onExpansionChanged: onOpenChange,
      children: [child],
      tilePadding: EdgeInsets.zero,
      shape: const Border(), // Remove default border
      collapsedShape: const Border(),
    );
  }
}
