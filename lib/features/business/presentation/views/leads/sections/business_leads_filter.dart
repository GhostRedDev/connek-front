import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/system_ui/form/inputs.dart'; // AppInput
import 'package:shadcn_ui/shadcn_ui.dart';

class BusinessLeadsFilter extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final Map<String, dynamic> t;
  final bool isDesktop;

  const BusinessLeadsFilter({
    super.key,
    required this.searchController,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.t,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    // Search Bar
    final searchBar = AppInput.text(
      controller: searchController,
      placeholder: t['search_leads'] ?? 'Buscar Leads',
      leading: const Icon(Icons.search, color: Colors.grey),
    );

    // Filter Buttons
    final filterButtons = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _buildFilterButtons(context)),
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: searchBar),
          const SizedBox(width: 16),
          Expanded(flex: 3, child: filterButtons),
        ],
      );
    }

    return Column(
      children: [searchBar, const SizedBox(height: 12), filterButtons],
    );
  }

  List<Widget> _buildFilterButtons(BuildContext context) {
    final filters = [
      {'id': 'all', 'label': t['filter_all'] ?? 'Todos'},
      {'id': 'pending', 'label': t['filter_pending'] ?? 'Pendientes'},
      {'id': 'converted', 'label': t['filter_converted'] ?? 'Convertidos'},
      {'id': 'waitlist', 'label': 'Lista de espera'},
      {'id': 'rejected', 'label': t['filter_rejected'] ?? 'Rechazados'},
    ];

    return filters.map((filter) {
      final id = filter['id']!;
      final label = filter['label']!;
      final isSelected = selectedFilter == id;

      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: _FilterButton(
          label: label,
          isSelected: isSelected,
          onTap: () => onFilterChanged(id),
        ),
      );
    }).toList();
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.primaryForeground
                : theme.colorScheme.foreground,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
