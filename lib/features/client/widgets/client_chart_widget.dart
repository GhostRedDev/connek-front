import 'package:flutter/material.dart';

class ClientChartWidget extends StatelessWidget {
  const ClientChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Adaptive bg
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Stack(
        children: [
          // Grid lines (vertical)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              7,
              (i) => VerticalDivider(
                color: Colors.grey[300],
                thickness: 1,
                indent: 20,
                endIndent: 30,
              ),
            ),
          ),
          // Chart Line (Custom Paint)
          Positioned.fill(child: CustomPaint(painter: _ChartPainter())),
          // Tooltip (Mock)
          Positioned(
            top: 40,
            left: 120,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D21),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mié',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '\$38,500.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Ganancias',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Labels
          const Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Lun', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Mar', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Mié', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Jue', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Vie', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Sáb', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text('Dom', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [const Color(0xFF4285F4).withOpacity(0.3), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    // Mock Points
    final w = size.width;
    final h = size.height;
    final points = [
      Offset(w * 0.05, h * 0.6),
      Offset(w * 0.2, h * 0.5),
      Offset(w * 0.35, h * 0.3), // Peak
      Offset(w * 0.5, h * 0.35),
      Offset(w * 0.65, h * 0.2),
      Offset(w * 0.8, h * 0.5),
      Offset(w * 0.95, h * 0.65),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      // simple lerp for smoothness
      path.quadraticBezierTo(
        (p0.dx + p1.dx) / 2,
        (p0.dy + p1.dy) / 2 - 20, // control point
        p1.dx,
        p1.dy,
      );
    }

    canvas.drawPath(path, paint);

    // Close path for fill
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    canvas.drawPath(path, fillPaint);

    // Draw dots
    for (var p in points) {
      canvas.drawCircle(p, 4, Paint()..color = Colors.white);
      canvas.drawCircle(
        p,
        4,
        Paint()
          ..color = const Color(0xFF4285F4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
