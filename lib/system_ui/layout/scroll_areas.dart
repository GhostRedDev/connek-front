import 'package:flutter/material.dart';

/// React-style Component: AppScrollArea
/// Props: child, horizontal (bool)
class AppScrollArea extends StatelessWidget {
  final Widget child;
  final bool horizontal;

  const AppScrollArea({
    super.key,
    required this.child,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
        child: child,
      ),
    );
  }
}

/// React-style Component: AppResizable (Placeholder)
class AppResizable extends StatelessWidget {
  final Widget child;

  const AppResizable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Flutter doesn't have native resizable panels like Web
    return child;
  }
}
