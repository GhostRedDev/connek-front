import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Since Shadcn Flutter might not have a full 'ShadCarousel', we can use a standard PageView
// or assume the user wants a structural wrapper.

/// React-style Component: AppCarousel
/// Props: items, height, autoPlay
class AppCarousel extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;

  const AppCarousel({
    super.key,
    required this.items,
    this.height = 200,
    this.autoPlay = false,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholder using ListView/PageView if specific shadcn carousel is missing
    return SizedBox(
      height: height,
      child: PageView(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ShadCard(child: Center(child: item)),
              ),
            )
            .toList(),
      ),
    );
  }
}
