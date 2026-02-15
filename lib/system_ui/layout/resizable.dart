import 'package:flutter/material.dart';

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
    final panels = children
        .map((child) => Expanded(child: child))
        .toList(growable: false);

    if (direction == Axis.vertical) {
      return Column(children: panels);
    }

    return Row(children: panels);
  }
}
