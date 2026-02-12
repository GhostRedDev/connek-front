import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/core/widgets/glass_fab_button.dart';
import 'package:connek_frontend/features/business/presentation/views/shared/business_shared_widgets.dart';

import 'sections/business_leads_header.dart';
import 'sections/business_leads_filter.dart';
import 'sections/business_leads_list.dart';

class BusinessLeadsWidget extends ConsumerStatefulWidget {
  const BusinessLeadsWidget({super.key});

  @override
  ConsumerState<BusinessLeadsWidget> createState() =>
      _BusinessLeadsWidgetState();
}

class _BusinessLeadsWidgetState extends ConsumerState<BusinessLeadsWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  bool _isListMode = false;

  @override
  Widget build(BuildContext context) {
    final businessDataAsync = ref.watch(businessProvider);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return businessDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final allLeads = data.recentLeads;

        // --- Filter Logic ---
        List<Lead> filteredLeads = allLeads.where((lead) {
          // 1. Status Filter
          bool statusMatch = true;
          switch (_selectedFilter) {
            case 'pending':
              statusMatch = lead.status == 'pending';
              break;
            case 'converted':
              statusMatch =
                  lead.status == 'completed' || lead.status == 'converted';
              break;
            case 'rejected':
              statusMatch =
                  lead.status == 'cancelled' || lead.status == 'declined';
              break;
            case 'waitlist':
              statusMatch = lead.status == 'waitlist';
              break;
            case 'all':
            default:
              statusMatch = true;
          }

          // 2. Search Filter
          bool searchMatch = true;
          if (_searchController.text.isNotEmpty) {
            final query = _searchController.text.toLowerCase();
            final fullName = '${lead.clientFirstName} ${lead.clientLastName}'
                .toLowerCase();
            searchMatch = fullName.contains(query);
          }

          return statusMatch && searchMatch;
        }).toList();

        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 900;

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const EmptySpaceTopWidget(),

                        // --- Recent Leads Header ---
                        BusinessLeadsHeader(recentLeads: allLeads, t: t),
                        const SizedBox(height: 20),

                        // --- Search & Filters ---
                        BusinessLeadsFilter(
                          searchController: _searchController,
                          selectedFilter: _selectedFilter,
                          onFilterChanged: (val) =>
                              setState(() => _selectedFilter = val),
                          t: t,
                          isDesktop: isDesktop,
                        ),
                        const SizedBox(height: 16),

                        // --- Filtered Leads List ---
                        BusinessLeadsList(
                          leads: filteredLeads,
                          isListMode: _isListMode,
                          onToggleMode: (val) =>
                              setState(() => _isListMode = val),
                          t: t,
                        ),

                        const SizedBox(height: 100), // Space for FAB
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: GlassFabButton(
                      icon: Icons.add,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Crear Lead - Coming Soon'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
