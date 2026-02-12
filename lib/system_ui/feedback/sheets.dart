import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Design System: Sheet Helpers (Side Panels)
class AppSheet {
  /// Show a Side Sheet (Drawer)
  static Future<void> show(
    BuildContext context, {
    required Widget child,
    ShadSheetSide side = ShadSheetSide.right,
    Widget? title,
    Widget? description,
    List<Widget>? actions,
  }) {
    return showShadSheet(
      context: context,
      side: side,
      builder: (context) => ShadSheet(
        title: title,
        description: description,
        actions: actions ?? [],
        child: child,
      ),
    );
  }
}
