import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppInput {
  const AppInput._();

  static Widget text({
    required TextEditingController controller,
    required String placeholder,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? leading,
    Widget? trailing,
    ValueChanged<String>? onChanged,
    FocusNode? focusNode,
  }) {
    return ShadInput(
      controller: controller,
      focusNode: focusNode,
      placeholder: Builder(
        builder: (context) => Text(
          placeholder,
          style: TextStyle(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      leading: leading,
      trailing: trailing,
      onChanged: onChanged,
    );
  }

  static Widget area({
    required TextEditingController controller,
    required String placeholder,
    int minLines = 3,
    int maxLines = 6,
  }) {
    return ShadInput(
      controller: controller,
      placeholder: Builder(
        builder: (context) => Text(
          placeholder,
          style: TextStyle(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
        ),
      ),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
