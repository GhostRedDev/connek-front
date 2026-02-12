import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../../core/providers/locale_provider.dart';
import '../../../../../system_ui/typography.dart';
import '../../../../../system_ui/form/inputs.dart';
import '../../../../../system_ui/layout/buttons.dart';
import '../../providers/business_provider.dart';
import 'business_invoice_sheet.dart';
import 'business_invoice_details_sheet.dart';
import '../../../../../core/widgets/glass_fab_button.dart';

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
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BusinessInvoiceSheet(initialData: initialData),
    );
  }

  Future<void> _deleteInvoice(int id) async {
    final t = ref.read(translationProvider).value ?? {};
    final confirm = await showShadDialog<bool>(
      context: context,
      builder: (ctx) => ShadDialog.alert(
        title: Text(t['business_invoices_delete_title'] ?? 'Eliminar Factura'),
        description: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            t['business_invoices_delete_content'] ??
                '¿Estás seguro de eliminar esta factura?',
          ),
        ),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t['business_invoices_cancel'] ?? 'Cancelar'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t['business_invoices_delete'] ?? 'Eliminar'),
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
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final businessDataAsync = ref.watch(businessProvider);
    // ignore: unused_local_variable
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = ShadTheme.of(context);

    return businessDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (data) {
        final quotes = data.quotes;

        final invoices = quotes
            .where((quote) {
              final status =
                  quote['status']?.toString().toLowerCase() ?? 'pending';
              return status != 'rejected' && status != 'rechazada';
            })
            .map((quote) {
              final statusRaw = quote['status'] ?? 'pending';
              String status;
              switch (statusRaw.toString().toLowerCase()) {
                case 'paid':
                case 'pagada':
                  status = t['business_status_paid'] ?? 'Pagada';
                  break;
                case 'accepted':
                case 'aceptada':
                  status = t['business_status_receivable'] ?? 'Por Cobrar';
                  break;
                case 'sent':
                case 'enviada':
                  status = t['business_status_sent'] ?? 'Enviada';
                  break;
                case 'draft':
                case 'borrador':
                  status = t['business_status_draft'] ?? 'Borrador';
                  break;
                case 'overdue':
                case 'vencida':
                case 'retrasada':
                  status = t['business_status_overdue'] ?? 'Vencida';
                  break;
                default:
                  status = statusRaw.toString();
                  if (status.isNotEmpty) {
                    status =
                        status[0].toUpperCase() +
                        status.substring(1).toLowerCase();
                  }
              }

              final leads = quote['leads'];
              final request = leads != null ? leads['requests'] : null;
              final client = request != null
                  ? request['client']
                  : (leads != null ? leads['client'] : null);

              final clientName = client != null
                  ? '${client['first_name'] ?? ''} ${client['last_name'] ?? ''}'
                        .trim()
                  : 'Cliente Desconocido';

              var clientImage = client != null
                  ? (client['photo_id'] ??
                        client['profile_url'] ??
                        client['profile_image'])
                  : null;

              if (clientImage != null &&
                  clientImage is String &&
                  !clientImage.startsWith('http') &&
                  client['id'] != null) {
                if (!clientImage.contains('/')) {
                  clientImage = '${client['id']}/$clientImage';
                }
                clientImage = Supabase.instance.client.storage
                    .from('client')
                    .getPublicUrl(clientImage);
              }

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
              final endRange = date != null
                  ? DateFormat(
                      'MMM dd, yyyy',
                    ).format(date.add(const Duration(days: 7)))
                  : '';

              return {
                'id': '#INV-${(quote['id'] ?? 0).toString().padLeft(6, '0')}',
                'raw_id': quote['id'],
                'lead_id': leads != null ? leads['id'] : null,
                'raw_status': statusRaw,
                'client': {
                  'name': clientName.isEmpty ? 'Cliente' : clientName,
                  'email': client != null ? (client['email'] ?? '') : '',
                  'image':
                      clientImage ??
                      'https://ui-avatars.com/api/?name=${Uri.encodeComponent(clientName)}&background=random',
                },
                'title': quote['description'] ?? 'Factura de Servicio',
                'serviceName': quote['services'] != null
                    ? quote['services']['name']
                    : (quote['title'] ?? 'Servicio General'),
                'status': status,
                'dateRange': '$startRange - $endRange',
                'fullDate': dateStr,
                'amount': amount,
                'subtotal': amount,
                'tax': '\$0.00',
                'paymentMethod': 'Tarjeta •••• 4242',
              };
            })
            .where((inv) {
              if (_selectedFilter != 'Todos') {
                if (inv['status'] != _selectedFilter) return false;
              }
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
                  AppText.h2(t['business_invoices_title'] ?? 'Facturas'),
                  const SizedBox(height: 4),
                  AppText.p(
                    t['business_invoices_subtitle'] ??
                        'Encuentra a todos tus clientes activos.',
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  AppInput.text(
                    controller: _searchController,
                    placeholder:
                        t['business_invoices_search_hint'] ?? 'Buscar facturas',
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search, size: 18, color: Colors.grey),
                    ),
                    onChanged: (val) => setState(() {}),
                  ),
                  const SizedBox(height: 20),

                  // Filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Todos'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Pagada'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Por Cobrar'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Vencida'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Borrador'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Invoice List
                  if (invoices.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: AppText.p(
                          "No hay facturas",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...invoices
                        .map((inv) => _buildInvoiceCard(inv, theme, t))
                        .toList(),

                  const SizedBox(height: 80),
                ],
              ),
            ),

            // Floating Action Button
            Positioned(
              left: 20,
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: GlassFabButton(
                  onPressed: () {
                    _showInvoiceSheet();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(String label) {
    final theme = ShadTheme.of(context);
    final isSelected = _selectedFilter == label;
    String uiLabel = label;
    if (label == 'Pagada') uiLabel = 'Pagadas';
    if (label == 'Pendiente') uiLabel = 'Pendientes';
    if (label == 'Rechazada') uiLabel = 'Rechazadas';

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.muted,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          uiLabel,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.primaryForeground
                : theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(
    Map<String, dynamic> inv,
    ShadThemeData theme,
    Map<String, dynamic> t,
  ) {
    Color statusColor;
    Color statusBgColor;

    switch (inv['status']) {
      case 'Pagada':
        statusColor = const Color(0xFF0F9D58);
        statusBgColor = const Color(0xFFE8F5E9);
        break;
      case 'Por Cobrar':
      case 'Enviada':
        statusColor = const Color(0xFF1976D2);
        statusBgColor = const Color(0xFFE3F2FD);
        break;
      case 'Pendiente':
      case 'Borrador':
        statusColor = const Color(0xFFF9A825);
        statusBgColor = const Color(0xFFFFF8E1);
        break;
      case 'Rechazada':
      case 'Vencida':
      case 'Retrasada':
        statusColor = const Color(0xFFEF5350);
        statusBgColor = const Color(0xFFFFEBEE);
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey[200]!;
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BusinessInvoiceDetailsSheet(invoice: inv),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: CachedNetworkImageProvider(
                    inv['client']['image'],
                  ),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: AppText.h4(
                    inv['client']['name'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    inv['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: theme.colorScheme.mutedForeground,
                    size: 18,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showInvoiceSheet(initialData: inv);
                    } else if (value == 'delete') {
                      final rawId = inv['raw_id'];
                      if (rawId != null) _deleteInvoice(rawId);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Text(
                            t['business_invoices_action_edit'] ?? 'Editar',
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text(
                            t['business_invoices_action_delete'] ?? 'Eliminar',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppText.small(
              inv['id'],
              color: theme.colorScheme.mutedForeground,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            AppText.p(
              inv['title'],
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.small(
                  inv['dateRange'],
                  color: theme.colorScheme.mutedForeground,
                ),
                AppText.h3(inv['amount'], color: theme.colorScheme.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
