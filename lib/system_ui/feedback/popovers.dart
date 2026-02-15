import 'package:flutter/material.dart';

/// React-style Component: AppPopover
/// Props: child (trigger), content (popover body), controller
class AppPopover extends StatelessWidget {
  final Widget child; // Trigger
  final Widget content;

  const AppPopover({super.key, required this.child, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (context) => Dialog(
            child: Padding(padding: const EdgeInsets.all(16), child: content),
          ),
        );
      },
      child: child,
    );
  }
}
