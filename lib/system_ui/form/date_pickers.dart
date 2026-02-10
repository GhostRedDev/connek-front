import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'labels.dart';

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
    final picker = ShadDatePicker(
      selected: value,
      onChanged: onValueChange,
      placeholder: Builder(
        builder: (context) => Text(
          placeholder,
          style: TextStyle(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
        ),
      ),
    );

    if (label != null) {
      return AppLabel(text: label!, child: picker);
    }
    return picker;
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
