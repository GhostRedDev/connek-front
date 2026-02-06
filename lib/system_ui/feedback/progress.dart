import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppProgress
/// Props: value (0.0 to 1.0), label, valueLabel
class AppProgress extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Widget? label;
  final Widget? valueLabel;
  final Color? backgroundColor;
  final Color? color;

  const AppProgress({
    super.key,
    required this.value,
    this.label,
    this.valueLabel,
    this.backgroundColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ShadProgress(
      value: value,
      label: label,
      valueLabel: valueLabel,
      backgroundColor: backgroundColor,
      color: color,
    );
  }
}
