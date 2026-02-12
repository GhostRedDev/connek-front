import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppSwitch
/// Props: checked (value), onCheckedChange (onChanged), label
class AppSwitch extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onCheckedChange;
  final String? label;
  final bool enabled;

  const AppSwitch({
    super.key,
    required this.checked,
    required this.onCheckedChange,
    this.label,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ShadSwitch(
      value: checked,
      onChanged: enabled ? onCheckedChange : null,
      label: label != null ? Text(label!) : null,
    );
  }
}
