import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppAvatar
/// Props: src (image url), alt (initials/fallback), size
class AppAvatar extends StatelessWidget {
  final String? src;
  final String alt; // Initials or Fallback text
  final double size;
  final Color? backgroundColor;

  const AppAvatar({
    super.key,
    this.src,
    this.alt = 'U',
    this.size = 40,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ShadAvatar(
      src,
      placeholder: Text(
        alt.isNotEmpty ? alt.substring(0, 1).toUpperCase() : 'U',
        style: TextStyle(fontSize: size * 0.4),
      ),
      size: Size(size, size),
      backgroundColor: backgroundColor,
    );
  }
}
