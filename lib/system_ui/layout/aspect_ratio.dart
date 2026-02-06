import 'package:flutter/material.dart';

/// React-style Component: AppAspectRatio
/// Props: ratio, child
class AppAspectRatio extends StatelessWidget {
  final double ratio;
  final Widget child;

  const AppAspectRatio({super.key, required this.ratio, required this.child});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: ratio, child: child);
  }
}
