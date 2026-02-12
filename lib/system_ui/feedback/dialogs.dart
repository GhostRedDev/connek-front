import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Design System: Dialog Helpers
class AppDialog {
  /// Show a Confirmation Dialog
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String description,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool isDestructive = false,
  }) async {
    final result = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(title),
        description: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(description),
        ),
        actions: [
          ShadButton.outline(
            child: Text(cancelText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ShadButton(
            backgroundColor: isDestructive
                ? ShadTheme.of(context).colorScheme.destructive
                : null,
            child: Text(confirmText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Show an Alert/Info Dialog
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String description,
    String actionText = 'OK',
  }) async {
    await showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(title),
        description: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(description),
        ),
        actions: [
          ShadButton(
            child: Text(actionText),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
