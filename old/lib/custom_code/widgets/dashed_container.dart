// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:dotted_border/dotted_border.dart';

class DashedContainer extends StatefulWidget {
  const DashedContainer({
    super.key,
    this.width,
    this.height,
    this.borderColor,
    this.borderWeight,
    this.borderRadius,
    this.borderSpacing,
    required this.iconColor,
  });

  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWeight;
  final double? borderRadius;
  final double? borderSpacing;
  final Color iconColor;

  @override
  State<DashedContainer> createState() => _DashedContainerState();
}

class _DashedContainerState extends State<DashedContainer> {
  @override
  Widget build(BuildContext context) {
    Color color = widget.borderColor ?? Colors.white;
    double weight = widget.borderWeight ?? 1;
    double radius = widget.borderRadius ?? 0;
    double spacing = widget.borderSpacing ?? 6;

    return DottedBorder(
      color: color,
      strokeWidth: weight,
      radius: Radius.circular(radius),
      borderType: BorderType.RRect,
      dashPattern: [spacing],
      child: Container(
        width: widget.width ?? 100,
        height: widget.height ?? 100,
        alignment:
            Alignment.center, // Esto centra el contenido dentro del contenedor
        child: Icon(
          Icons.add,
          size: 24,
          color: widget.iconColor,
        ),
      ),
    );
  }
}
