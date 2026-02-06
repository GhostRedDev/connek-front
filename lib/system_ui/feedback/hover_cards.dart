import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppHoverCard
/// Props: trigger, content
class AppHoverCard extends StatelessWidget {
  final Widget child; // Trigger
  final Widget content;
  final ShadHoverCardController? controller;

  const AppHoverCard({
    super.key,
    required this.child,
    required this.content,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ShadHoverCard(
      controller: controller,
      hoverCard: content,
      child: child,
    );
  }
}
