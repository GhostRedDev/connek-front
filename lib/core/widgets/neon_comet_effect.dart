import 'dart:math';
import 'package:flutter/material.dart';

class NeonCometEffect extends StatefulWidget {
  final Widget child;
  final double strokeWidth;
  final double radius;
  final Duration duration;

  const NeonCometEffect({
    super.key,
    required this.child,
    this.strokeWidth = 2.5,
    this.radius = 30,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<NeonCometEffect> createState() => _NeonCometEffectState();
}

class _NeonCometEffectState extends State<NeonCometEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AnimatedGradientBorderPainter(
        controller: _controller,
        strokeWidth: widget.strokeWidth,
        radius: widget.radius,
      ),
      child: widget.child,
    );
  }
}

class _AnimatedGradientBorderPainter extends CustomPainter {
  final AnimationController controller;
  final double strokeWidth;
  final double radius;

  _AnimatedGradientBorderPainter({
    required this.controller,
    required this.strokeWidth,
    required this.radius,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Calculate rotation angle
    final double startAngle = controller.value * 2 * pi;

    // Define the gradient colors and stops to create the "comet" effect
    // Trail (Blue) -> Red -> Head (White)
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: const [
        Colors.blue, // Deep tail
        Colors.blue, // Mid tail
        Colors.blue, // Fore tail
        Colors.red,  // Secondary color
        Colors.white, // Bright Head
        Colors.blue, // Connect back to tail
      ],
      stops: const [
        0.0,
        0.5,
        0.7,
        0.85,
        0.95,
        1.0
      ],
      transform: GradientRotation(startAngle),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; 

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedGradientBorderPainter oldDelegate) {
    return true;
  }
}
