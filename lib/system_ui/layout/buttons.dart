import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../system_ui/core/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  static Widget _buildContent(String text, IconData? icon, bool isLoading) {
    if (isLoading) {
      return Builder(
        builder: (context) {
          // Use the icon color (foreground color set by ShadButton) for the spinner
          final color = IconTheme.of(context).color;
          return SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: color != null ? AlwaysStoppedAnimation(color) : null,
            ),
          );
        },
      );
    }

    if (icon != null) {
      if (text.isEmpty) {
        return Icon(icon, size: 18);
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: AppSpacing.s),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  static Widget primary({
    required String text,
    VoidCallback? onPressed,
    double? width,
    IconData? icon,
    bool isLoading = false,
  }) {
    return ShadButton(
      width: width,
      onPressed: onPressed,
      child: _buildContent(text, icon, isLoading),
    );
  }

  static Widget outline({
    required String text,
    VoidCallback? onPressed,
    double? width,
    IconData? icon,
    bool isLoading = false,
  }) {
    return ShadButton.outline(
      width: width,
      onPressed: onPressed,
      child: _buildContent(text, icon, isLoading),
    );
  }

  static Widget ghost({
    required String text,
    VoidCallback? onPressed,
    double? width,
    IconData? icon,
  }) {
    return ShadButton.ghost(
      width: width,
      onPressed: onPressed,
      child: _buildContent(text, icon, false),
    );
  }

  static Widget destructive({
    required String text,
    VoidCallback? onPressed,
    double? width,
    IconData? icon,
  }) {
    return ShadButton.destructive(
      width: width,
      onPressed: onPressed,
      child: _buildContent(text, icon, false),
    );
  }
}
