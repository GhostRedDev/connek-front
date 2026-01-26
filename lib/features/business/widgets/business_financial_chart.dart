import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/business_analytics_service.dart';

class BusinessFinancialChart extends StatefulWidget {
  final List<String> labels;

  final String period;
  final List<GraphSpot> incomeSpots;
  final List<GraphSpot> expenseSpots;

  const BusinessFinancialChart({
    super.key,
    required this.labels,
    required this.period,
    required this.incomeSpots,
    required this.expenseSpots,
  });

  @override
  State<BusinessFinancialChart> createState() => _BusinessFinancialChartState();
}

class _BusinessFinancialChartState extends State<BusinessFinancialChart> {
  // Colors...
  List<Color> gradientColorsIncome = [
    const Color(0xFF23b6e6),
    const Color(0xFF02d39a),
  ];

  List<Color> gradientColorsExpense = [
    const Color(0xFFE57373),
    const Color(0xFFFF5252),
  ];

  @override
  Widget build(BuildContext context) {
    // ... same build ...
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(_mainData(isDark)),
          ),
        ),
      ],
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }
    final index = value.toInt();
    if (index < 0 || index >= widget.labels.length) {
      return const SizedBox.shrink();
    }

    // Improve Label Logic: Skip labels if too many
    int interval = 1;
    if (widget.labels.length > 7) {
      interval = (widget.labels.length / 5).ceil();
    }

    if (index % interval != 0 && index != widget.labels.length - 1) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        widget.labels[index],
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.grey,
    );
    String text;
    if (value >= 1000) {
      text = '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      text = value.toInt().toString();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData _mainData(bool isDark) {
    // Convert GraphSpot to FlSpot
    final flIncome = widget.incomeSpots.map((e) => FlSpot(e.x, e.y)).toList();
    final flExpense = widget.expenseSpots.map((e) => FlSpot(e.x, e.y)).toList();

    // Calculate Max Y for scaling
    double maxY = 0;
    for (var s in flIncome) if (s.y > maxY) maxY = s.y;
    for (var s in flExpense) if (s.y > maxY) maxY = s.y;
    maxY = (maxY * 1.2).ceilToDouble(); // Add 20% padding
    if (maxY == 0) maxY = 10;

    // Calculate Max X
    double maxX = (widget.labels.length - 1).toDouble();
    if (maxX < 0) maxX = 0;
    // Ensure chart has width even without data
    if (maxX == 0 && widget.labels.isEmpty) maxX = 6;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false, // Clean look
        horizontalInterval: maxY / 5,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: isDark ? Colors.white10 : Colors.black12,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: maxY / 5,
            getTitlesWidget: _leftTitleWidgets,
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: maxY,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: const Color(0xFF1E222D), // Dark tooltip background
          getTooltipColor: (touchedSpot) => const Color(0xFF1E222D),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              // Check if it's income or expense based on bar index or color
              // barSpot.barIndex == 0 -> Income, 1 -> Expense
              final isIncome = barSpot.barIndex == 0;

              String label = isIncome ? "Ingresos" : "Gastos";
              Color textColor = isIncome
                  ? const Color(0xFF02d39a)
                  : const Color(0xFFFF5252);

              String dateLabel = "";
              if (flSpot.x.toInt() >= 0 &&
                  flSpot.x.toInt() < widget.labels.length) {
                dateLabel = widget.labels[flSpot.x.toInt()];
              }

              return LineTooltipItem(
                '${dateLabel.isNotEmpty ? "$dateLabel\n" : ""}\$${flSpot.y.toStringAsFixed(2)}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: label,
                    style: TextStyle(
                      color: textColor.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        // INCOME
        LineChartBarData(
          spots: flIncome,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColorsIncome),
          barWidth: 3, // Thinner, more elegant
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ), // Hide dots by default for cleaner line
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColorsIncome[0].withOpacity(0.2), // Softer fill
                gradientColorsIncome[1].withOpacity(0.0),
              ],
            ),
          ),
        ),
        // EXPENSE
        LineChartBarData(
          spots: flExpense,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColorsExpense),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColorsExpense[0].withOpacity(0.2),
                gradientColorsExpense[1].withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
