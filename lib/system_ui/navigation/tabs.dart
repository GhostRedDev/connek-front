import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppTabs
/// Props: value, onValueChange, tabs (List of {value, label, content})
class AppTabs<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T> onValueChange;
  final List<AppTabItem<T>> tabs;
  final double? width;

  const AppTabs({
    super.key,
    required this.value,
    required this.onValueChange,
    required this.tabs,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ShadTabs<T>(
      value: value,
      onChanged: onValueChange,
      tabs: tabs
          .map(
            (tab) => ShadTab<T>(
              value: tab.value,
              content: tab.content,
              child: Text(tab.label),
            ),
          )
          .toList(),
      // Note: ShadTabs usually manages structure.
      // This wrapper assumes ShadTab contains both the trigger label (child) and the content.
    );
  }
}

class AppTabItem<T> {
  final T value;
  final String label;
  final Widget content;

  const AppTabItem({
    required this.value,
    required this.label,
    required this.content,
  });
}
