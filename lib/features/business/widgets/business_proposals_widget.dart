import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../providers/business_provider.dart';

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
          // Status Filter
          bool statusMatch = true;
          final status = quote['status'] ?? 'pending';
          switch (_selectedFilter) {
            case 'Enviadas':
              statusMatch = status == 'pending' || status == 'sent';
              break;
            case 'Aceptadas':
              statusMatch = status == 'accepted';
              break;
            case 'Rechazadas':
              statusMatch = status == 'declined' || status == 'rejected';
              break;
            case 'Todos':
            default:
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

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Propuestas',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
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
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                    _buildFilterChip('Aceptadas'),
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
                ...filteredQuotes
                    .map((prop) => _buildProposalCard(prop, isDark, cardColor))
                    .toList(),

              // Extra space for bottom nav
              const SizedBox(height: 80),
            ],
          ),
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
    if (clientImage == null || clientImage.isEmpty) {
      clientImage =
          'https://ui-avatars.com/api/?name=${Uri.encodeComponent(clientName)}&background=random';
    }

    // Agent Info (Defaults for now as we don't have agent specific field in quote)
    final agentName = 'Sistema';
    final agentRole = 'Automático';
    final agentImage =
        'https://ui-avatars.com/api/?name=AI&background=0D8ABC&color=fff';

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

    return Container(
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
                  border: Border.all(color: const Color(0xFF4285F4), width: 1),
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
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),

          // Date & Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
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
                      backgroundImage: CachedNetworkImageProvider(clientImage),
                      onBackgroundImageError:
                          (_, __) {}, // Handle errors silently
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clientName,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          clientRole,
                          style: GoogleFonts.inter(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Agent
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(agentImage),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          agentName,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          agentRole,
                          style: GoogleFonts.inter(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
