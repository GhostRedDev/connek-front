import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppContextMenu (Dropdown)
/// Props: trigger, items (List of items)
class AppContextMenu extends StatelessWidget {
  final Widget child;
  final List<Widget> items;

  const AppContextMenu({super.key, required this.child, required this.items});

  @override
  Widget build(BuildContext context) {
    return ShadContextMenu(items: items, child: child);
  }
}

/// React-style Component: AppMenubar
/// Placeholder for desktop-style menubar
class AppMenubar extends StatelessWidget {
  final List<Widget> menus;

  const AppMenubar({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return Row(children: menus);
  }
}
