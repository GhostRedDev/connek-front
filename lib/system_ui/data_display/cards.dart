import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? description;
  final Widget? footer;
  final EdgeInsets padding;

  const AppCard({
    super.key,
    required this.child,
    this.title,
    this.description,
    this.footer,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: title != null ? Text(title!) : null,
      description: description != null
          ? Text(
              description!,
              style: TextStyle(
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
            )
          : null,
      footer: footer,
      padding: padding,
      child: child,
    );
  }
}
