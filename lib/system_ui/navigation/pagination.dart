import 'package:flutter/material.dart';

/// React-style Component: AppPagination
/// Props: currentPage, totalPages, onPageChange
class AppPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChange;

  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    final canPrev = currentPage > 1;
    final canNext = currentPage < totalPages;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: canPrev ? () => onPageChange(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Previous',
        ),
        Text('$currentPage / $totalPages'),
        IconButton(
          onPressed: canNext ? () => onPageChange(currentPage + 1) : null,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Next',
        ),
      ],
    );
  }
}
