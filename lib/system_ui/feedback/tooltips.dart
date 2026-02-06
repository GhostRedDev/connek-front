import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppTooltip
/// Props: child, message (tooltip text)
class AppTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final Duration? waitDuration;

  const AppTooltip({
    super.key,
    required this.child,
    required this.message,
    this.waitDuration,
  });

  @override
  Widget build(BuildContext context) {
    return ShadTooltip(
      builder: (context) => Text(message),
      waitDuration: waitDuration,
      child: child,
    );
  }
}
