import 'package:flutter/material.dart';

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
    return TextField(
      controller: TextEditingController(text: value)
        ..selection = TextSelection.collapsed(offset: value.length),
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      onChanged: onValueChange,
      decoration: const InputDecoration(counterText: ''),
    );
  }
}
