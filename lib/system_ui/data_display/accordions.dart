import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppAccordion
/// Props: items (List of {value, title, content})
class AppAccordion extends StatelessWidget {
  final List<AppAccordionItem> items;
  final bool multiple;

  const AppAccordion({super.key, required this.items, this.multiple = false});

  @override
  Widget build(BuildContext context) {
    if (multiple) {
      return ShadAccordion.multiple(
        children: items
            .map(
              (item) => ShadAccordionItem(
                value: item.value,
                title: Text(item.title),
                child: item.content,
              ),
            )
            .toList(),
      );
    }
    return ShadAccordion(
      children: items
          .map(
            (item) => ShadAccordionItem(
              value: item.value,
              title: Text(item.title),
              child: item.content,
            ),
          )
          .toList(),
    );
  }
}

class AppAccordionItem {
  final String value;
  final String title;
  final Widget content;

  const AppAccordionItem({
    required this.value,
    required this.title,
    required this.content,
  });
}
