import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppLabel
/// Props: text, required, child (for nesting input, optional)
class AppLabel extends StatelessWidget {
  final String text;
  final bool isRequired;
  final Widget? child;

  const AppLabel({
    super.key,
    required this.text,
    this.isRequired = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [_buildLabelText(context), const SizedBox(height: 8), child!],
      );
    }
    return _buildLabelText(context);
  }

  Widget _buildLabelText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: ShadTheme.of(
            context,
          ).textTheme.small.copyWith(fontWeight: FontWeight.w500),
        ),
        if (isRequired)
          Text(
            ' *',
            style: ShadTheme.of(context).textTheme.small.copyWith(
              color: ShadTheme.of(context).colorScheme.destructive,
            ),
          ),
      ],
    );
  }
}
