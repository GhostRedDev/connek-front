import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../providers/business_provider.dart';
import 'business_proposal_sheet.dart';
import 'business_proposal_details_sheet.dart';
import '../../../core/widgets/glass_fab_button.dart';

class BusinessProposalsWidget extends ConsumerStatefulWidget {
  const BusinessProposalsWidget({super.key});

  @override
  ConsumerState<BusinessProposalsWidget> createState() =>
      _BusinessProposalsWidgetState();
}

class _BusinessProposalsWidgetState
    extends ConsumerState<BusinessProposalsWidget> {
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final businessDataAsync = ref.watch(businessProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return businessDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final allQuotes = data.quotes;

        // Filter Logic
        final filteredQuotes = allQuotes.where((quote) {
          final status = quote['status'] ?? 'pending';

          // EXCLUDE INVOICES (Accepted quotes are considered invoices)
          // User request: "load proposals, not invoices"
          if (status == 'accepted') return false;

          // Status Filter
          bool statusMatch = true;
          switch (_selectedFilter) {
            case 'Enviadas':
              statusMatch = status == 'pending' || status == 'sent';
              break;
            case 'Rechazadas':
              statusMatch = status == 'declined' || status == 'rejected';
              break;
            case 'Todos':
            default:
              // statusMatch is already true, and 'accepted' is excluded above.
              statusMatch = true;
          }

          // Search Filter
          bool searchMatch = true;
          if (_searchController.text.isNotEmpty) {
            final query = _searchController.text.toLowerCase();
            final description = (quote['description'] ?? '')
                .toString()
                .toLowerCase();
            // Client Name from nested leads->client
            final leads = quote['leads'];
            final client = leads != null ? leads['client'] : null;
            final clientName = client != null
                ? '${client['first_name'] ?? ''} ${client['last_name'] ?? ''}'
                      .toLowerCase()
                : '';

            searchMatch =
                description.contains(query) || clientName.contains(query);
          }

          return statusMatch && searchMatch;
        }).toList();

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    children: [
                      Text(
                        'Propuestas',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () => _showCreateProposalSheet(context),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Nueva'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4285F4),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Verifica el estado de las propuesta enviadas.',
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Buscar propuestas',
                        hintStyle: GoogleFonts.inter(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Todos'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Enviadas'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Rechazadas'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Proposal List
                  if (filteredQuotes.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          'No hay propuestas encontradas',
                          style: GoogleFonts.inter(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...filteredQuotes.map(
                      (prop) => _buildProposalCard(prop, isDark, cardColor),
                    ),

                  // Extra space for bottom nav
                  const SizedBox(height: 80),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: GlassFabButton(
                  icon: Icons.add,
                  onPressed: () => _showCreateProposalSheet(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildProposalCard(
    Map<String, dynamic> prop,
    bool isDark,
    Color cardColor,
  ) {
    // Data Extraction & Formatting
    final status = prop['status'] ?? 'pending';
    final amountCents = prop['amountCents'] ?? 0;
    final amount = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    ).format(amountCents / 100);

    final dateStr = prop['created_at'];
    final date = dateStr != null ? DateTime.tryParse(dateStr) : null;
    final formattedDate = date != null
        ? DateFormat('dd MMM yyyy').format(date)
        : '';
    final formattedTime = date != null
        ? DateFormat('hh:mm a').format(date)
        : '';

    final id = 'PRO-${(prop['id'] ?? 0).toString().padLeft(4, '0')}';
    final title = prop['description'] ?? 'Propuesta de Servicio';

    // Client Info
    final leads = prop['leads'];
    final client = leads != null ? leads['client'] : null;
    final clientName = client != null
        ? '${client['first_name'] ?? ''} ${client['last_name'] ?? ''}'.trim()
        : 'Cliente Desconocido';
    final clientRole = 'Cliente';
    // Handle Client Image - Check multiple possible fields as seen in Lead model
    String? clientImage = client != null
        ? (client['photo_id'] ??
              client['profile_url'] ??
              client['profile_image'])
        : null;

    // Fallback if image is generic or null
    // if (clientImage == null || clientImage.isEmpty) {
    //   Use a local asset or simply let CircleAvatar show a background color/icon
    // }

    // Agent Info (Defaults for now as we don't have agent specific field in quote)
    final agentName = 'Sistema';
    final agentRole = 'Automático';
    // final agentImage = 'https://ui-avatars.com/api/?name=AI&background=0D8ABC&color=fff'; // Removed stable

    Color statusColor;
    Color statusBgColor;
    String statusLabel;

    switch (status) {
      case 'pending':
      case 'sent':
        statusColor = const Color(0xFFF9A825); // Yellow/Orange
        statusBgColor = const Color(0xFFFFF8E1);
        statusLabel = 'Enviada';
        break;
      case 'accepted':
        statusColor = const Color(0xFF4285F4); // Blue
        statusBgColor = const Color(0xFFE3F2FD);
        statusLabel = 'Aceptada';
        break;
      case 'declined':
      case 'rejected':
        statusColor = const Color(0xFFEF5350); // Red
        statusBgColor = const Color(0xFFFFEBEE);
        statusLabel = 'Rechazada';
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey[200]!;
        statusLabel = status;
    }

    return GestureDetector(
      onTap: () => _showDetailsSheet(context, prop),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1A1A1A)
              : Colors.grey[50], // Slightly darker bg for card
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4285F4),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.attach_money,
                    color: Color(0xFF4285F4),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusBgColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              statusLabel,
                              style: GoogleFonts.inter(
                                color: statusColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        id,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4285F4),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditProposalSheet(context, prop);
                    } else if (value == 'delete') {
                      _deleteProposal(context, prop['id'], ref);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Editar'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text('Eliminar', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date & Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      formattedDate,
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text(
                      formattedTime,
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Text(
                  amount,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFF4285F4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Participants Row
            Row(
              children: [
                // Client
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            (clientImage != null && clientImage.isNotEmpty)
                            ? CachedNetworkImageProvider(clientImage)
                            : null,
                        child: (clientImage == null || clientImage.isEmpty)
                            ? const Icon(
                                Icons.person,
                                size: 18,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clientName,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              clientRole,
                              style: GoogleFonts.inter(
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Agent
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                agentName,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                agentRole,
                                style: GoogleFonts.inter(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateProposalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BusinessProposalSheet(),
    );
  }

  void _showEditProposalSheet(
    BuildContext context,
    Map<String, dynamic> quote,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BusinessProposalSheet(quoteToEdit: quote),
    );
  }

  void _showDetailsSheet(BuildContext context, Map<String, dynamic> quote) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BusinessProposalDetailsSheet(quote: quote),
    );
  }

  Future<void> _deleteProposal(
    BuildContext context,
    int id,
    WidgetRef ref,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Propuesta'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar esta propuesta?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await ref.read(businessProvider.notifier).deleteQuote(id);
      if (!context.mounted) return;
      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Propuesta eliminada')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar propuesta')),
        );
      }
    }
  }
}
