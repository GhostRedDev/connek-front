import 'package:flutter/material.dart';

/// React-style Component: AppSeparator
/// Props: orientation (horizontal/vertical), thickness, color
class AppSeparator extends StatelessWidget {
  final Axis orientation;
  final double? thickness;
  final Color? color;

  const AppSeparator({
    super.key,
    this.orientation = Axis.horizontal,
    this.thickness,
    this.color,
  });

  factory AppSeparator.vertical({double? thickness, Color? color}) {
    return AppSeparator(
      orientation: Axis.vertical,
      thickness: thickness,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (orientation == Axis.vertical) {
      return VerticalDivider(
        width: thickness ?? 1.0,
        thickness: thickness ?? 1.0,
        color: color ?? Theme.of(context).dividerColor,
      );
    }
    return Divider(
      height: thickness ?? 1.0,
      thickness: thickness ?? 1.0,
      color: color ?? Theme.of(context).dividerColor,
    );
  }
}
