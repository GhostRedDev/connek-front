import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:animate_do/animate_do.dart'; // Using animate_do for pulse if Shadcn doesn't have native skeleton

/// React-style Component: AppSkeleton
/// Props: width, height, shape (rect/circle)
class AppSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxShape shape;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
  });

  factory AppSkeleton.circle({double size = 40}) {
    return AppSkeleton(width: size, height: size, shape: BoxShape.circle);
  }

  @override
  Widget build(BuildContext context) {
    // If shadcn_ui doesn't have ShadSkeleton, we can emulate it or check if it exists.
    // Assuming standard usage or falling back to a styled container with pulse.
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ShadTheme.of(context).colorScheme.muted, // Skeleton color
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(6)
              : null,
        ),
      ),
    );
  }
}
