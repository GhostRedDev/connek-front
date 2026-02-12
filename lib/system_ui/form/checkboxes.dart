import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppCheckbox
/// Props: checked (value), onCheckedChange (onChanged), label, sublabel
class AppCheckbox extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onCheckedChange;
  final String? label;
  final String? sublabel;
  final bool enabled;

  const AppCheckbox({
    super.key,
    required this.checked,
    required this.onCheckedChange,
    this.label,
    this.sublabel,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCheckbox(
      value: checked,
      onChanged: enabled ? onCheckedChange : null,
      label: label != null ? Text(label!) : null,
      sublabel: sublabel != null ? Text(sublabel!) : null,
    );
  }
}
