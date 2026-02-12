import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppTextarea
/// Props: value, onValueChange, placeholder, minLines, maxLines
class AppTextarea extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const AppTextarea({
    super.key,
    this.controller,
    this.placeholder,
    this.minLines = 3,
    this.maxLines = 10,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller,
      placeholder: placeholder != null
          ? Builder(
              builder: (context) => Text(
                placeholder!,
                style: TextStyle(
                  color: ShadTheme.of(context).colorScheme.mutedForeground,
                ),
              ),
            )
          : null,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
