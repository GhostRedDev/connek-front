import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppSelect
/// Props: value, onValueChange, options (Map<Value, Label>), placeholder
class AppSelect<T> extends StatelessWidget {
  final T? value;
  final ValueChanged<T?> onChanged;
  final Map<T, String> options;
  final String placeholder;

  const AppSelect({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    this.placeholder = 'Select an option',
  });

  @override
  Widget build(BuildContext context) {
    return ShadSelect<T>(
      placeholder: Text(placeholder),
      initialValue: value,
      onChanged: onChanged,
      options: options.entries.map((entry) {
        return ShadOption(value: entry.key, child: Text(entry.value));
      }).toList(),
      selectedOptionBuilder: (context, value) {
        return Text(options[value] ?? value.toString());
      },
    );
  }
}
