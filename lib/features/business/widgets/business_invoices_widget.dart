import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../providers/business_provider.dart';
import 'business_invoice_sheet.dart';

class BusinessInvoicesWidget extends ConsumerStatefulWidget {
  const BusinessInvoicesWidget({super.key});

  @override
  ConsumerState<BusinessInvoicesWidget> createState() =>
      _BusinessInvoicesWidgetState();
}

class _BusinessInvoicesWidgetState
    extends ConsumerState<BusinessInvoicesWidget> {
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  void _showInvoiceSheet({Map<String, dynamic>? initialData}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BusinessInvoiceSheet(initialData: initialData),
    );
  }

  Future<void> _deleteInvoice(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Factura'),
        content: const Text('¿Estás seguro de eliminar esta factura?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(businessRepositoryProvider).deleteQuote(id);
      ref.invalidate(businessProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final businessDataAsync = ref.watch(businessProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return businessDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final quotes = data.quotes;

        // Filter & Map Logic
        final invoices = quotes
            .map((quote) {
              final statusRaw = quote['status'] ?? 'pending';
              String status = 'Pendiente';
              if (statusRaw == 'accepted')
                status = 'Pagada';
              else if (statusRaw == 'declined' || statusRaw == 'rejected')
                status = 'Rechazada';
              else if (statusRaw == 'sent')
                status = 'Pendiente';

              // Fallback for mock/older data
              if (statusRaw == 'Retrasada') status = 'Retrasada';

              final leads = quote['leads'];
              // Handle nested structure: leads -> requests -> client
              final request = leads != null ? leads['requests'] : null;
              final client = request != null
                  ? request['client']
                  : (leads != null ? leads['client'] : null);

              final clientName = client != null
                  ? '${client['first_name'] ?? ''} ${client['last_name'] ?? ''}'
                        .trim()
                  : 'Cliente Desconocido';

              final clientImage = client != null
                  ? (client['photo_id'] ??
                        client['profile_url'] ??
                        client['profile_image'])
                  : null;

              final amountCents = quote['amountCents'] ?? 0;
              final amount = NumberFormat.currency(
                symbol: '\$',
                decimalDigits: 2,
              ).format(amountCents / 100);

              final dateStr = quote['created_at'];
              final date = dateStr != null
                  ? DateTime.tryParse(dateStr)
                  : DateTime.now();
              final startRange = date != null
                  ? DateFormat('MMM dd').format(date)
                  : '';
              // Mocking end range as +7 days for now since quotes usually have expiries not ranges
              final endRange = date != null
                  ? DateFormat(
                      'MMM dd, yyyy',
                    ).format(date.add(const Duration(days: 7)))
                  : '';

              return {
                'id': '#INV-${(quote['id'] ?? 0).toString().padLeft(6, '0')}',
                'raw_id': quote['id'],
                'lead_id': leads != null ? leads['id'] : null,
                'raw_status': statusRaw, // For logic
                'client': {
                  'name': clientName.isEmpty ? 'Cliente' : clientName,
                  'image':
                      clientImage ??
                      'https://ui-avatars.com/api/?name=${Uri.encodeComponent(clientName)}&background=random',
                },
                'title': quote['description'] ?? 'Factura de Servicio',
                'status': status,
                'dateRange': '$startRange - $endRange',
                'amount': amount,
              };
            })
            .where((inv) {
              // Filter Logic
              if (_selectedFilter != 'Todos') {
                // Exact match on mapped status
                if (inv['status'] != _selectedFilter) return false;
              }

              // Search Logic
              if (_searchController.text.isNotEmpty) {
                final query = _searchController.text.toLowerCase();
                final title = inv['title'].toString().toLowerCase();
                final client = inv['client']['name'].toString().toLowerCase();
                final id = inv['id'].toString().toLowerCase();
                return title.contains(query) ||
                    client.contains(query) ||
                    id.contains(query);
              }

              return true;
            })
            .toList();

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Facturas',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Encuentra a todos tus clientes activos.',
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
                        hintText: 'Buscar facturas',
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
                        _buildFilterChip('Pagada'), // Singular matches logic
                        const SizedBox(width: 8),
                        _buildFilterChip('Pendiente'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Rechazada'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Invoice List
                  if (invoices.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          "No hay facturas",
                          style: GoogleFonts.inter(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...invoices
                        .map((inv) => _buildInvoiceCard(inv, isDark, cardColor))
                        .toList(),

                  // Extra space
                  const SizedBox(height: 80),
                ],
              ),
            ),

            // Floating Action Button
            Positioned(
              left: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  _showInvoiceSheet();
                },
                backgroundColor: isDark
                    ? Colors.white
                    : const Color(0xFFF5F5F7),
                foregroundColor: Colors.black,
                elevation: 2,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, size: 28),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    // UI Label might differ from logic val if needed, but here simple
    String uiLabel = label;
    if (label == 'Pagada') uiLabel = 'Pagadas';
    if (label == 'Pendiente') uiLabel = 'Pendientes';
    if (label == 'Rechazada') uiLabel = 'Rechazadas';

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
          uiLabel,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(
    Map<String, dynamic> inv,
    bool isDark,
    Color cardColor,
  ) {
    Color statusColor;
    Color statusBgColor;

    switch (inv['status']) {
      case 'Pagada':
        statusColor = const Color(0xFF0F9D58); // Green
        statusBgColor = const Color(0xFFE8F5E9);
        break;
      case 'Pendiente':
        statusColor = const Color(0xFFF9A825); // Yellow/Orange
        statusBgColor = const Color(0xFFFFF8E1);
        break;
      case 'Rechazada':
        statusColor = const Color(0xFFEF5350); // Red
        statusBgColor = const Color(0xFFFFEBEE);
        break;
      case 'Retrasada':
        statusColor = const Color(0xFFEF5350); // Red
        statusBgColor = const Color(0xFFFFEBEE);
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey[200]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1A1A)
            : const Color(0xFFF5F5F7), // Light grey bg
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Icon + Avatar + Name + Badge
          Row(
            children: [
              // Document Icon
              const Icon(
                Icons.receipt_long_outlined,
                color: Color(0xFF4285F4),
                size: 20,
              ),
              const SizedBox(width: 8),

              // Avatar
              CircleAvatar(
                radius: 12,
                backgroundImage: CachedNetworkImageProvider(
                  inv['client']['image'],
                ),
                onBackgroundImageError: (_, __) {},
              ),
              const SizedBox(width: 8),

              // Name
              Expanded(
                child: Text(
                  inv['client']['name'],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Status Badge
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
                  inv['status'],
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              // Context Menu
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.grey, size: 18),
                onSelected: (value) {
                  if (value == 'edit') {
                    _showInvoiceSheet(initialData: inv);
                  } else if (value == 'delete') {
                    final rawId = inv['raw_id'];
                    if (rawId != null) _deleteInvoice(rawId);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Text('Editar'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ID
          Text(
            inv['id'],
            style: GoogleFonts.inter(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          // Project Title
          Text(
            inv['title'],
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isDark
                  ? Colors.white.withOpacity(0.9)
                  : const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),

          // Date & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inv['dateRange'],
                style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13),
              ),
              Text(
                inv['amount'],
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color(0xFF4285F4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
