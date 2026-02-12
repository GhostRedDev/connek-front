import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/constants/connek_icons.dart';

class HomeSearchWidget extends ConsumerStatefulWidget {
  const HomeSearchWidget({super.key});

  @override
  ConsumerState<HomeSearchWidget> createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends ConsumerState<HomeSearchWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Speed of rotation
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
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: t['home_title_find_services'] ?? 'Find services in\n',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const TextSpan(
                    text: 'Connek',
                    style: TextStyle(
                      color: Colors.blue, // Match the blue in image
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Search Bar with Animated Border
            GestureDetector(
              onTap: () => context.push('/search', extra: {'autofocus': true}),
              behavior: HitTestBehavior.opaque,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _AnimatedGradientBorderPainter(
                      controller: _controller,
                      strokeWidth: 2.5,
                      radius: 30,
                    ),
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      if (Theme.of(context).brightness == Brightness.light)
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
                          blurRadius: 10,
                        ),
                    ],
                  ),
                  child: AbsorbPointer(
                    child: ShadInput(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      placeholder: Text(
                        t['home_search_hint'] ?? 'Search...',
                        style: TextStyle(
                          color: Theme.of(context).hintColor.withAlpha(
                            (((Theme.of(context).hintColor.a * 0.7) * 255.0)
                                    .round()
                                    .clamp(0, 255))
                                .toInt(),
                          ),
                        ),
                      ),
                      decoration: const ShadDecoration(
                        border: ShadBorder.none,
                        focusedBorder: ShadBorder.none,
                        errorBorder: ShadBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Buttons Row
            // Request Button
            SizedBox(
              width: double.infinity,
              child: ShadButton(
                height: 56,
                backgroundColor: const Color(0xFF0D47A1),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                decoration: ShadDecoration(
                  border: ShadBorder.all(
                    radius: BorderRadius.circular(999),
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      ConnekIcons.awesome,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t['home_button_request'] ?? 'Solicitar',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
  });

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
        Colors.red, // Secondary color
        Colors.white, // Bright Head
        Colors.blue, // Connect back to tail
      ],
      stops: const [0.0, 0.5, 0.7, 0.85, 0.95, 1.0],
      transform: GradientRotation(startAngle),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Soft edges for the line itself

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedGradientBorderPainter oldDelegate) {
    return true; // Repaint on every tick
  }
}
