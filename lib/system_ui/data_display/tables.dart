import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppTable
/// Props: headers, rows (List<List<Widget>>)
class AppTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final Map<int, TableColumnWidth>? columnWidths;

  const AppTable({
    super.key,
    required this.headers,
    required this.rows,
    this.columnWidths,
  });

  @override
  Widget build(BuildContext context) {
    return ShadTable(
      columnWidths: columnWidths,
      list: [
        // Headers
        headers
            .map(
              (h) =>
                  Text(h, style: const TextStyle(fontWeight: FontWeight.bold)),
            )
            .toList(),
        // Rows
        ...rows,
      ],
    );
  }
}
