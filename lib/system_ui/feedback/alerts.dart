import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppAlert
/// Props: title, description, icon, variant (default, destructive)
class AppAlert extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final bool isDestructive;

  const AppAlert({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.isDestructive = false,
  });

  factory AppAlert.destructive({
    required String title,
    String? description,
    IconData? icon,
  }) {
    return AppAlert(
      title: title,
      description: description,
      icon: icon ?? Icons.error_outline,
      isDestructive: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isDestructive) {
      return ShadAlert.destructive(
        icon: icon != null ? Icon(icon) : null,
        title: Text(title),
        description: description != null ? Text(description!) : null,
      );
    }
    return ShadAlert(
      icon: icon != null ? Icon(icon) : null,
      title: Text(title),
      description: description != null ? Text(description!) : null,
    );
  }
}
