import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppInputOTP
/// Props: value, onValueChange, maxLength
class AppInputOTP extends StatelessWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final int maxLength;

  const AppInputOTP({
    super.key,
    required this.value,
    required this.onValueChange,
    this.maxLength = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ShadInputOTP(
      value: value,
      maxLength: maxLength,
      onChanged: onValueChange,
    );
  }
}
