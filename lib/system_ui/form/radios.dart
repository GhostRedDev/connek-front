import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppRadioGroup
/// Props: value, onValueChange, items (Map or List of custom objects), label
class AppRadioGroup<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T?> onValueChange;
  final Map<T, String> items; // Value -> Label map
  final Axis direction;

  const AppRadioGroup({
    super.key,
    required this.value,
    required this.onValueChange,
    required this.items,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ShadRadioGroup<T>(
      initialValue: value,
      onChanged: onValueChange,
      items: items.entries.map((entry) {
        return ShadRadio<T>(value: entry.key, label: Text(entry.value));
      }).toList(),
    );
  }
}
