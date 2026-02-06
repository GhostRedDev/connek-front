import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum AppBadgeVariant { primary, secondary, destructive, outline }

/// React-style Component: AppBadge
/// Props: label, variant (default, secondary, destructive, outline), onTap
class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeVariant variant;
  final IconData? icon;
  final VoidCallback? onTap;

  const AppBadge(
    this.label, {
    super.key,
    this.variant = AppBadgeVariant.primary,
    this.icon,
    this.onTap,
  });

  factory AppBadge.secondary(
    String label, {
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return AppBadge(
      label,
      variant: AppBadgeVariant.secondary,
      icon: icon,
      onTap: onTap,
    );
  }

  factory AppBadge.destructive(
    String label, {
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return AppBadge(
      label,
      variant: AppBadgeVariant.destructive,
      icon: icon,
      onTap: onTap,
    );
  }

  factory AppBadge.outline(
    String label, {
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return AppBadge(
      label,
      variant: AppBadgeVariant.outline,
      icon: icon,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    Color? backgroundColor;
    Color? foregroundColor;
    ShadBorder? border;

    switch (variant) {
      case AppBadgeVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.primaryForeground;
        break;
      case AppBadgeVariant.secondary:
        backgroundColor = theme.colorScheme.secondary;
        foregroundColor = theme.colorScheme.secondaryForeground;
        break;
      case AppBadgeVariant.destructive:
        backgroundColor = theme.colorScheme.destructive;
        foregroundColor = theme.colorScheme.destructiveForeground;
        break;
      case AppBadgeVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.foreground;
        border = ShadBorder.all(color: theme.colorScheme.border);
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: ShadBadge(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        // shape: border != null ? const RoundedRectangleBorder().copyWith(side: border.borderSide) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: foregroundColor),
              const SizedBox(width: 4),
            ],
            Text(label),
          ],
        ),
      ),
    );
  }
}
