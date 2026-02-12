import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppBreadcrumb
/// Props: items (Map<Label, Callback?>)
class AppBreadcrumb extends StatelessWidget {
  final Map<String, VoidCallback?> items;

  const AppBreadcrumb({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // ShadBreadcrumb availability check. If not, use Row + Text + Separator
    // Assuming customized implementation for now as it's simple.
    final List<Widget> children = [];
    items.entries.toList().asMap().forEach((index, entry) {
      final isLast = index == items.length - 1;

      if (entry.value != null && !isLast) {
        children.add(
          InkWell(
            onTap: entry.value,
            child: Text(
              entry.key,
              style: ShadTheme.of(context).textTheme.muted,
            ),
          ),
        );
      } else {
        children.add(
          Text(
            entry.key,
            style: isLast
                ? ShadTheme.of(context).textTheme.p
                : ShadTheme.of(context).textTheme.muted,
          ),
        );
      }

      if (!isLast) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ),
        );
      }
    });

    return Row(children: children);
  }
}
