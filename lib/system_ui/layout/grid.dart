import 'package:flutter/material.dart';
import '../core/constants.dart';

/// React-style Component: AppContainer
/// "Defines the maximum width of your app to prevent it from spreading on ultrawide monitors."
class AppContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets padding;

  const AppContainer({
    super.key,
    required this.child,
    this.maxWidth = AppBreakpoints.ultraWide,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.m),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// React-style Component: AppGrid
/// "A simple 12-column grid system wrapper"
/// Note: Flutter is natively Flex-heavy. This simulates a grid using Wrap or Row/Column logic.
/// For true CSS Grid behavior, consider libraries, but this works for standard layouts.
class AppGrid extends StatelessWidget {
  final List<Widget> children;
  final int
  crossAxisCount; // How many columns (default 12 usually implies full width slots if count is 1)
  final double spacing;
  final double runSpacing;

  const AppGrid({
    super.key,
    required this.children,
    this.crossAxisCount =
        2, // Default to 2 columns for general use, or use 12 for strict scaffolding
    this.spacing = AppSpacing.m,
    this.runSpacing = AppSpacing.m,
  });

  @override
  Widget build(BuildContext context) {
    // Using Wrap to simulate a responsive grid where items flow
    // Ideally, children would have specific widths (e.g., width / 12) to be strict "col-span-x"
    // Here we provide a simplified grid.

    // For a strict 12-column system, we would need LayoutBuilder and calculate widths.
    // Let's implement a simplified version that works like Wrap but spacing handled.
    return Wrap(spacing: spacing, runSpacing: runSpacing, children: children);
  }
}

/// React-style Component: AppCol (Column Item for Grid)
/// Use inside a Wrap or Flex context if you want 'col-span-x' behavior manually
class AppCol extends StatelessWidget {
  final Widget child;
  final int span; // 1 to 12
  final int totalColumns;

  const AppCol({
    super.key,
    required this.child,
    this.span = 12,
    this.totalColumns = 12,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate width based on total available width
        // Use a slight manual calculation if parent provides constraints
        final width = (constraints.maxWidth * (span / totalColumns));
        return SizedBox(width: width, child: child);
      },
    );
  }
}
