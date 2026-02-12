import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppPopover
/// Props: child (trigger), content (popover body), controller
class AppPopover extends StatelessWidget {
  final Widget child; // Trigger
  final Widget content;
  final ShadPopoverController? controller;
  final Alignment? alignment;

  const AppPopover({
    super.key,
    required this.child,
    required this.content,
    this.controller,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: controller,
      popover: (context) => content,
      alignment: alignment ?? Alignment.bottomCenter,
      child: child,
    );
  }
}
