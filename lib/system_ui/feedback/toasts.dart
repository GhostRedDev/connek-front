import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Design System: Toast Helpers
class AppToast {
  /// Show a simple message toast
  static void show(
    BuildContext context, {
    required String title,
    String? description,
    Widget? action,
  }) {
    ShadToaster.of(context).show(
      ShadToast(
        title: Text(title),
        description: description != null ? Text(description) : null,
        action: action,
      ),
    );
  }

  /// Show a destructive/error toast
  static void showError(
    BuildContext context, {
    required String title,
    String? description,
    Widget? action,
  }) {
    ShadToaster.of(context).show(
      ShadToast.destructive(
        title: Text(title),
        description: description != null ? Text(description) : null,
        action: action,
      ),
    );
  }
}
