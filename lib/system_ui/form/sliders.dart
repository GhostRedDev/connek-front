import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppSlider
/// Props: value, onValueChange, min, max, divisions
class AppSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onValueChange;
  final double min;
  final double max;
  final bool enabled;

  const AppSlider({
    super.key,
    required this.value,
    required this.onValueChange,
    this.min = 0.0,
    this.max = 1.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ShadSlider(
      initialValue: value,
      onChanged: enabled ? onValueChange : null,
      min: min,
      max: max,
    );
  }
}
