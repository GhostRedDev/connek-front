import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/form/inputs.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BusinessServicesTabsFilter extends StatefulWidget {
  final TextEditingController searchController;
  final int selectedTabIndex;
  final Function(int) onTabChanged;
  final Map<String, dynamic> t;
  final Function(String) onSearchChanged;

  const BusinessServicesTabsFilter({
    super.key,
    required this.searchController,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.t,
    required this.onSearchChanged,
  });

  @override
  State<BusinessServicesTabsFilter> createState() =>
      _BusinessServicesTabsFilterState();
}

class _BusinessServicesTabsFilterState
    extends State<BusinessServicesTabsFilter> {
  bool _isSearchActive = false;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      if (_isSearchActive) {
        _searchFocusNode.requestFocus();
      } else {
        widget.searchController.clear();
        widget.onSearchChanged('');
        _searchFocusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Column(
      children: [
        // Tabs & Search Button Row
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _TabButton(
                        label: widget.t['services_tab'] ?? 'Servicios',
                        isSelected: widget.selectedTabIndex == 0,
                        onTap: () => widget.onTabChanged(0),
                      ),
                    ),
                    Expanded(
                      child: _TabButton(
                        label: widget.t['items_tab'] ?? 'Items',
                        isSelected: widget.selectedTabIndex == 1,
                        onTap: () => widget.onTabChanged(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Search Toggle Button
            InkWell(
              onTap: _toggleSearch,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isSearchActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.muted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _isSearchActive ? Icons.close : Icons.search,
                  color: _isSearchActive
                      ? theme.colorScheme.primaryForeground
                      : theme.colorScheme.mutedForeground,
                ),
              ),
            ),
          ],
        ),

        // Expandable Search Input
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AppInput.text(
              controller: widget.searchController,
              focusNode: _searchFocusNode,
              placeholder: widget.t['search_services'] ?? 'Buscar servicios...',
              leading: const Icon(Icons.search, color: Colors.grey),
              onChanged: widget.onSearchChanged,
            ),
          ),
          crossFadeState: _isSearchActive
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.background : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.foreground
                : theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
