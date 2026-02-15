import 'package:flutter/material.dart';

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
    final headerRow = TableRow(
      children: headers
          .map(
            (h) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Text(
                h,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
    );

    final dataRows = rows
        .map(
          (row) => TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: cell,
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    return Table(
      columnWidths: columnWidths,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [headerRow, ...dataRows],
    );
  }
}
