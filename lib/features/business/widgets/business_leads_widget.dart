import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/business_provider.dart';
import 'business_shared_widgets.dart';
import 'lead_newx_widget.dart';
import 'lead_card_info_widget.dart';
import '../../leads/models/lead_model.dart';
import '../../../../core/providers/locale_provider.dart';

class BusinessLeadsWidget extends ConsumerStatefulWidget {
  const BusinessLeadsWidget({super.key});

  @override
  ConsumerState<BusinessLeadsWidget> createState() =>
      _BusinessLeadsWidgetState();
}

class _BusinessLeadsWidgetState extends ConsumerState<BusinessLeadsWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all'; // Changed to internal ID

  @override
  Widget build(BuildContext context) {
    final businessDataAsync = ref.watch(businessProvider);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return businessDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final allLeads = data.recentLeads;

        // --- Filter Logic (Leads) ---
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
            final isDesktop = constraints.maxWidth > 800;

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmptySpaceTopWidget(),

                    // --- Recent Leads Section ---
                    if (allLeads.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1A1F24)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                t['received_last_week'] ?? 'Received last week',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Row(
                                children: allLeads.take(5).map((lead) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: LeadNewxWidget(lead: lead),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // --- Search & Filters ---
                    SizedBox(
                      width: double.infinity,
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildSearchBar(isDark, t),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: _buildFilterButtons(isDark, t),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildSearchBar(isDark, t),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: _buildFilterButtons(isDark, t),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 16),

                    // --- Filtered Leads List ---
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1A1F24) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              t['all_leads'] ?? 'Todos los leads',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          filteredLeads.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                                      t['no_leads_found'] ??
                                          'No se encontraron leads',
                                      style: GoogleFonts.inter(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    16,
                                    16,
                                  ),
                                  child: isDesktop
                                      ? Wrap(
                                          // Desktop Grid
                                          spacing: 16,
                                          runSpacing: 16,
                                          children: filteredLeads.map((lead) {
                                            return SizedBox(
                                              width:
                                                  (constraints.maxWidth -
                                                          32 - // padding (16*2)
                                                          32 - // container padding (16*2)
                                                          16) / // spacing
                                                      2 -
                                                  1, // Approx half width
                                              child: LeadCardInfoWidget(
                                                lead: lead,
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : Column(
                                          // Mobile List
                                          children: filteredLeads.map((lead) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              child: LeadCardInfoWidget(
                                                lead: lead,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                ),
                        ],
                      ),
                    ),
                    const EmptySpaceWidget(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchBar(bool isDark, Map<String, String> t) {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() {}),
      decoration: InputDecoration(
        hintText: t['search_leads'] ?? 'Buscar Leads',
        hintStyle: GoogleFonts.inter(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: isDark ? const Color(0xFF111418) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
          borderSide: const BorderSide(color: Color(0xFF4285F4), width: 1),
        ),
      ),
    );
  }

  Widget _buildFilterButtons(bool isDark, Map<String, String> t) {
    final filters = [
      {'id': 'all', 'label': t['filter_all'] ?? 'Todos'},
      {'id': 'pending', 'label': t['filter_pending'] ?? 'Pendientes'},
      {'id': 'converted', 'label': t['filter_converted'] ?? 'Convertidos'},
      {'id': 'rejected', 'label': t['filter_rejected'] ?? 'Rechazados'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filters.map((filter) {
        final id = filter['id']!;
        final label = filter['label']!;
        final isSelected = _selectedFilter == id;

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () => setState(() => _selectedFilter = id),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4285F4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4285F4)
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
