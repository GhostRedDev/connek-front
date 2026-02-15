import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../system_ui/core/constants.dart';

class AuthInteractiveWaves extends StatefulWidget {
  final Widget child;

  const AuthInteractiveWaves({super.key, required this.child});

  @override
  State<AuthInteractiveWaves> createState() => _AuthInteractiveWavesState();
}

class AuthAutoImageSlideshow extends StatefulWidget {
  final List<String> assets;
  final Duration interval;
  final Duration fadeDuration;

  const AuthAutoImageSlideshow({
    super.key,
    required this.assets,
    this.interval = const Duration(seconds: 7),
    this.fadeDuration = const Duration(milliseconds: 700),
  });

  @override
  State<AuthAutoImageSlideshow> createState() => _AuthAutoImageSlideshowState();
}

class _AuthAutoImageSlideshowState extends State<AuthAutoImageSlideshow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _kenBurns;
  int _index = 0;
  Timer? _timer;
  Offset _pointer01 = const Offset(0.5, 0.5);

  @override
  void initState() {
    super.initState();

    _kenBurns = AnimationController(vsync: this, duration: widget.interval)
      ..repeat();

    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      if (widget.assets.isEmpty) return;
      setState(() {
        _index = (_index + 1) % widget.assets.length;
        _kenBurns
          ..stop()
          ..reset()
          ..repeat();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _kenBurns.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assets.isEmpty) return const SizedBox.shrink();
    final asset = widget.assets[_index.clamp(0, widget.assets.length - 1)];

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        Offset clamp01(Offset v) =>
            Offset(v.dx.clamp(0.0, 1.0), v.dy.clamp(0.0, 1.0));

        return MouseRegion(
          onHover: (event) {
            if (w <= 0 || h <= 0) return;
            final p = Offset(
              event.localPosition.dx / w,
              event.localPosition.dy / h,
            );
            setState(() => _pointer01 = clamp01(p));
          },
          child: ClipRect(
            child: AnimatedSwitcher(
              duration: widget.fadeDuration,
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: AnimatedBuilder(
                key: ValueKey<String>(asset),
                animation: _kenBurns,
                builder: (context, _) {
                  final t = _kenBurns.value;
                  final scale = 1.05 + (0.08 * Curves.easeInOut.transform(t));

                  final ax = (_pointer01.dx - 0.5) * 0.4;
                  final ay = (_pointer01.dy - 0.5) * 0.25;
                  final align = Alignment(ax, ay);

                  return Transform.scale(
                    scale: scale,
                    alignment: align,
                    child: Image.asset(
                      asset,
                      fit: BoxFit.cover,
                      alignment: align,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).colorScheme.primary,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AuthInteractiveWavesState extends State<AuthInteractiveWaves>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _pointer01 = const Offset(0.5, 0.35);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        Offset clamp01(Offset v) =>
            Offset(v.dx.clamp(0.0, 1.0), v.dy.clamp(0.0, 1.0));

        return MouseRegion(
          onHover: (event) {
            if (w <= 0 || h <= 0) return;
            final p = Offset(
              event.localPosition.dx / w,
              event.localPosition.dy / h,
            );
            setState(() => _pointer01 = clamp01(p));
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _WavyGradientPainter(
                  progress01: _controller.value,
                  pointer01: _pointer01,
                  scheme: scheme,
                  isDark: isDark,
                ),
                child: child,
              );
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _WavyGradientPainter extends CustomPainter {
  final double progress01;
  final Offset pointer01;
  final ColorScheme scheme;
  final bool isDark;

  const _WavyGradientPainter({
    required this.progress01,
    required this.pointer01,
    required this.scheme,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final rect = Offset.zero & size;
    final phase = progress01 * math.pi * 2;

    final baseShader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        scheme.primary.withValues(alpha: isDark ? 0.55 : 0.45),
        scheme.primaryContainer.withValues(alpha: isDark ? 0.45 : 0.35),
        scheme.secondaryContainer.withValues(alpha: isDark ? 0.35 : 0.25),
      ],
      stops: const [0.0, 0.55, 1.0],
    ).createShader(rect);

    canvas.drawRect(rect, Paint()..shader = baseShader);

    final highlightCenter = Alignment(
      pointer01.dx * 2 - 1,
      pointer01.dy * 2 - 1,
    );
    final highlightShader = RadialGradient(
      center: highlightCenter,
      radius: 1.1,
      colors: [
        scheme.primary.withValues(alpha: isDark ? 0.22 : 0.18),
        scheme.secondary.withValues(alpha: isDark ? 0.10 : 0.08),
        scheme.surface.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.45, 1.0],
    ).createShader(rect);
    canvas.drawRect(rect, Paint()..shader = highlightShader);

    final pointerX = (pointer01.dx - 0.5) * 2;
    final pointerY = (pointer01.dy - 0.5) * 2;

    void drawWave({
      required double baseline01,
      required double amp01,
      required double freq,
      required double speed,
      required Color color,
      required double alpha,
    }) {
      final baselineY = size.height * baseline01;
      final amplitude = size.height * amp01 * (1.0 + pointerY.abs() * 0.25);
      final dx = size.width / 64;
      final path = Path()..moveTo(0, baselineY);

      for (double x = 0; x <= size.width + dx; x += dx) {
        final nx = x / size.width;
        final y =
            baselineY +
            math.sin(
                  (nx * math.pi * 2 * freq) +
                      (phase * speed) +
                      (pointerX * math.pi),
                ) *
                amplitude;
        path.lineTo(x, y);
      }

      path
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();

      canvas.drawPath(
        path,
        Paint()
          ..color = color.withValues(alpha: alpha)
          ..style = PaintingStyle.fill,
      );
    }

    drawWave(
      baseline01: 0.22,
      amp01: 0.025,
      freq: 1.4,
      speed: 0.9,
      color: scheme.primary,
      alpha: isDark ? 0.18 : 0.14,
    );

    drawWave(
      baseline01: 0.42,
      amp01: 0.032,
      freq: 1.05,
      speed: 1.1,
      color: scheme.secondaryContainer,
      alpha: isDark ? 0.18 : 0.14,
    );

    drawWave(
      baseline01: 0.64,
      amp01: 0.04,
      freq: 0.85,
      speed: 1.3,
      color: scheme.primaryContainer,
      alpha: isDark ? 0.22 : 0.18,
    );
  }

  @override
  bool shouldRepaint(covariant _WavyGradientPainter oldDelegate) {
    return oldDelegate.progress01 != progress01 ||
        oldDelegate.pointer01 != pointer01 ||
        oldDelegate.scheme != scheme ||
        oldDelegate.isDark != isDark;
  }
}

class AuthDesktopSplit extends StatelessWidget {
  final Widget left;
  final String headline;
  final String description;
  final Widget? rightBackground;

  const AuthDesktopSplit({
    super.key,
    required this.left,
    required this.headline,
    required this.description,
    this.rightBackground,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primary = Theme.of(context).colorScheme.primary;

    final logoAsset = isDark
        ? 'assets/images/conneck_logo_white.png'
        : 'assets/images/conneck_logo_dark.png';

    return Row(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: AppSpacing.xl,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: left,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (rightBackground != null)
                Positioned.fill(child: rightBackground!)
              else
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: primary,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primary,
                          primary.withValues(alpha: isDark ? 0.85 : 0.92),
                        ],
                      ),
                    ),
                  ),
                ),

              // Always keep a blue overlay so text stays readable.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primary.withValues(alpha: isDark ? 0.72 : 0.62),
                        primary.withValues(alpha: isDark ? 0.86 : 0.78),
                      ],
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.xl,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AnimatedConnekLogo(asset: logoAsset),
                        const SizedBox(height: AppSpacing.l),
                        Text(
                          headline,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.m),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnimatedConnekLogo extends StatefulWidget {
  final String asset;

  const _AnimatedConnekLogo({required this.asset});

  @override
  State<_AnimatedConnekLogo> createState() => _AnimatedConnekLogoState();
}

class _AnimatedConnekLogoState extends State<_AnimatedConnekLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final floatY = math.sin(t * math.pi * 2) * 6;
        final rotate = math.sin(t * math.pi * 2) * 0.03;

        return Transform.translate(
          offset: Offset(0, floatY),
          child: Transform.rotate(angle: rotate, child: child),
        );
      },
      child: Image.asset(widget.asset, width: 120, fit: BoxFit.contain),
    );
  }
}
