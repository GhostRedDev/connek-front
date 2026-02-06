import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppDatePicker
/// Props: value, onValueChange, placeholder
class AppDatePicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?> onValueChange;
  final String placeholder;
  final String? label;

  const AppDatePicker({
    super.key,
    required this.value,
    required this.onValueChange,
    this.placeholder = 'Select a date',
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ShadDatePicker(
      value: value,
      onChanged: onValueChange,
      label: label != null ? Text(label!) : null,
      placeholder: Builder(
        builder: (context) => Text(
          placeholder,
          style: TextStyle(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
        ),
      ),
    );
  }
}

/// React-style Component: AppCalendar
/// Props: value, onValueChange
class AppCalendar extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?> onValueChange;

  const AppCalendar({
    super.key,
    required this.value,
    required this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCalendar(selected: value, onChanged: onValueChange);
  }
}
