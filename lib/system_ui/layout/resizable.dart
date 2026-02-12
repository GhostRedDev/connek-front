import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppResizablePanel
/// Props: children, minSizes, maxSizes, direction
class AppResizablePanel extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final List<double>? defaultSizes;

  const AppResizablePanel({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.defaultSizes,
  });

  @override
  Widget build(BuildContext context) {
    return ShadResizablePanelGroup(
      axis: direction,
      defaultSizes: defaultSizes,
      children: children
          .map((child) => ShadResizablePanel(child: child))
          .toList(),
    );
  }
}
