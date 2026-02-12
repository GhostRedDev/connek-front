import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Using fl_chart as Recharts equivalent
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppLineChart
/// Props: spots (points), color
class AppLineChart extends StatelessWidget {
  final List<FlSpot> spots;
  final Color? color;

  const AppLineChart({super.key, required this.spots, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final chartColor = color ?? theme.colorScheme.primary;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: chartColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

/// React-style Component: AppBarChart
/// Props: data (Map x-index -> value)
class AppBarChart extends StatelessWidget {
  final List<double> values;
  final Color? color;

  const AppBarChart({super.key, required this.values, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final chartColor = color ?? theme.colorScheme.primary;

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: values.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value,
                color: chartColor,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
