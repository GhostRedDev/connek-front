import 'package:flutter/material.dart';

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
    final indicator = LinearProgressIndicator(
      value: value.clamp(0.0, 1.0),
      backgroundColor: backgroundColor,
      color: color,
      minHeight: 8,
      borderRadius: BorderRadius.circular(999),
    );

    if (label == null && valueLabel == null) return indicator;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (label != null) Expanded(child: label!),
            if (valueLabel != null) valueLabel!,
          ],
        ),
        const SizedBox(height: 8),
        indicator,
      ],
    );
  }
}
