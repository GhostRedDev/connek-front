import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/system_ui/core/constants.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart' as shad;

import '../views/leads/business_leads_widget.dart';
import '../views/dashboard/business_overview_widget.dart';
import '../views/clients/business_clients_widget.dart';
import '../providers/business_provider.dart';
import '../views/services/business_services_widget.dart';
import '../views/admin/business_employees_widget.dart';
import '../views/admin/business_profile_widget.dart';
import '../views/sales/business_proposals_widget.dart';
import '../views/finances/business_invoices_widget.dart';
import '../views/sales/business_bookings_widget.dart';
import '../views/admin/business_settings_widget.dart';
import '../views/finances/business_accounting_widget.dart';
import '../widgets/business_menu_widget.dart';

class BusinessPageSorted extends ConsumerStatefulWidget {
  const BusinessPageSorted({super.key});

  @override
  ConsumerState<BusinessPageSorted> createState() => _BusinessPageSortedState();
}

class _BusinessPageSortedState extends ConsumerState<BusinessPageSorted> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialIndex = ref.read(businessLocalIndexProvider);
    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(businessLocalIndexProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.ultraWide),
          child: Column(
            children: [
              const SizedBox(height: 125), // Clear global header height
              BusinessMenuWidget(
                selectedIndex: selectedIndex,
                onTabSelected: (index) {
                  ref.read(businessLocalIndexProvider.notifier).state = index;
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutQuad,
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const PageScrollPhysics(),
                  itemCount: 11,
                  onPageChanged: (index) {
                    ref.read(businessLocalIndexProvider.notifier).state = index;
                  },
                  itemBuilder: (context, index) => _buildBusinessView(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Local State Provider for Business Page Index
final businessLocalIndexProvider = StateProvider<int>((ref) => 0);

// Redefine BusinessPage to redirect to BusinessPageSorted for consistency everywhere
class BusinessPage extends ConsumerWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BusinessPageSorted();
  }
}

// Helper to build the current view for AnimatedSwitcher
Widget _buildBusinessView(int index) {
  switch (index) {
    case 0:
      return BusinessOverviewWidget(key: const ValueKey('business-0'));
    case 1:
      return const BusinessLeadsWidget(key: ValueKey('business-1'));
    case 2:
      return const BusinessClientsWidget(key: ValueKey('business-2'));
    case 3:
      return const BusinessSalesTab(key: ValueKey('business-3'));
    case 4:
      return const BusinessProposalsWidget(key: ValueKey('business-4'));
    case 5:
      return const BusinessBookingsWidget(key: ValueKey('business-5'));
    case 6:
      return const BusinessServicesWidget(key: ValueKey('business-6'));
    case 7:
      return const BusinessEmployeesWidget(key: ValueKey('business-7'));
    case 8:
      return const BusinessProfileWidget(key: ValueKey('business-8'));
    case 9:
      return const BusinessSettingsWidget(key: ValueKey('business-9'));
    case 10:
      return const BusinessAccountingWidget(key: ValueKey('business-10'));
    default:
      return const SizedBox.shrink(key: ValueKey('business-default'));
  }
}

class BusinessSalesTab extends ConsumerWidget {
  const BusinessSalesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(selectedSalesViewProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Sub-navigation for Sales
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border(
              bottom: BorderSide(color: theme.dividerColor.withOpacity(0.5)),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  ref,
                  id: 'invoices',
                  label: 'Facturas',
                  isSelected: view == 'invoices',
                  isDark: isDark,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  ref,
                  id: 'proposals',
                  label: 'Propuestas',
                  isSelected: view == 'proposals',
                  isDark: isDark,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  ref,
                  id: 'bookings',
                  label: 'Reservas',
                  isSelected: view == 'bookings',
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
        // Content
        Expanded(
          child: Builder(
            builder: (context) {
              switch (view) {
                case 'invoices':
                  return const BusinessInvoicesWidget();
                case 'proposals':
                  return const BusinessProposalsWidget();
                case 'bookings':
                  return const BusinessBookingsWidget();
                default:
                  return const _BusinessPlaceholder(title: 'Ventas - General');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref, {
    required String id,
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedSalesViewProvider.notifier).state = id;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4285F4)
              : (isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.grey[700]),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _BusinessPlaceholder extends StatelessWidget {
  final String title;
  const _BusinessPlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = shad.ShadTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 48,
            color: theme.colorScheme.mutedForeground.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          AppText.h3(
            '$title - Coming Soon',
            style: TextStyle(color: theme.colorScheme.mutedForeground),
          ),
        ],
      ),
    );
  }
}
