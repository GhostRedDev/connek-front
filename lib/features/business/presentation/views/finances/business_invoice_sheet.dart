import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../../core/providers/locale_provider.dart';
import '../../../../../system_ui/form/inputs.dart'; // AppInput
import '../../../../../system_ui/form/selects.dart'; // AppSelect
import '../../../../../system_ui/layout/buttons.dart'; // AppButton
import '../../../../../system_ui/data_display/cards.dart'; // AppCard
import '../../../../../system_ui/typography.dart'; // AppText

import '../../providers/business_provider.dart';

class BusinessInvoiceSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic>? initialData;

  const BusinessInvoiceSheet({super.key, this.initialData});

  @override
  ConsumerState<BusinessInvoiceSheet> createState() =>
      _BusinessInvoiceSheetState();
}

class _BusinessInvoiceSheetState extends ConsumerState<BusinessInvoiceSheet> {
  // State
  int? _selectedLeadId;
  final List<BusinessInvoiceItem> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _initFormData();
    } else {
      _items.add(BusinessInvoiceItem());
    }
  }

  void _initFormData() {
    final data = widget.initialData!;
    if (data.containsKey('lead_id')) {
      _selectedLeadId = data['lead_id'];
    }
    final amountCents = data['amountCents'] ?? 0;
    final amount = amountCents / 100.0;

    _items.add(
      BusinessInvoiceItem(
        title: data['description'] ?? 'Servicio',
        price: amount,
        qty: 1,
      ),
    );
  }

  // --- Logic ---

  void _addItem([BusinessInvoiceItem? item]) {
    setState(() {
      _items.add(item ?? BusinessInvoiceItem());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  double get _subTotal => _items.fold(0, (sum, item) => sum + item.total);
  // Using Quebec taxes as per image: TPS 5%, TVQ 9.975%
  double get _taxTPS => _subTotal * 0.05;
  double get _taxTVQ => _subTotal * 0.09975;
  double get _total => _subTotal + _taxTPS + _taxTVQ;

  Future<void> _saveInvoice() async {
    if (_selectedLeadId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ref
                    .read(translationProvider)
                    .value?['business_invoice_select_client_error'] ??
                'Por favor selecciona un cliente',
          ),
        ),
      );
      return;
    }

    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ref
                    .read(translationProvider)
                    .value?['business_invoice_add_item_error'] ??
                'Agrega al menos un ítem',
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final businessData = ref.read(businessProvider).value;
      if (businessData?.businessProfile == null) return;

      final amountCents = (_total * 100).toInt();

      // Construct Description from Items
      final description = _items
          .map((e) => '${e.title} (x${e.qty})')
          .join(', ');

      final repo = ref.read(businessRepositoryProvider);

      if (widget.initialData != null) {
        final rawId = widget.initialData!['raw_id'];
        if (rawId != null) {
          await repo.updateQuote(int.parse(rawId.toString()), {
            'amountCents': amountCents,
            'description': description,
          });
        }
      } else {
        final leadId = _selectedLeadId!;
        int serviceId = 0;
        if (businessData!.services.isNotEmpty) {
          serviceId = businessData.services.first['id'];
        }

        await repo.createQuote({
          'lead_id': leadId,
          'service_id': serviceId,
          'amountCents': amountCents,
          'description': description,
        });
      }

      ref.invalidate(businessProvider);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.initialData != null
                  ? (ref.read(translationProvider).value?['generic_saved'] ??
                        'Guardado')
                  : (ref
                            .read(translationProvider)
                            .value?['business_invoice_created_success'] ??
                        'Factura creada'),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    final businessData = ref.watch(businessProvider).value;
    final leads = businessData?.recentLeads ?? [];

    final theme = ShadTheme.of(context);
    final bgColor = theme.colorScheme.background;
    final cardColor = theme.colorScheme.card;

    final selectedLead = _selectedLeadId != null
        ? leads.firstWhere(
            (l) => l.id == _selectedLeadId,
            orElse: () => leads.first,
          )
        : null;

    final invoiceId = widget.initialData != null
        ? '#INV-${widget.initialData!['raw_id']}'
        : 'NUEVA';

    final dateStr = DateFormat('dd MMM yyyy', 'es').format(DateTime.now());

    final businessProfile = businessData?.businessProfile;
    final String? businessLogo = businessProfile?['profile_image'];
    final String businessName = businessProfile?['name'] ?? 'Mi Negocio';

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.colorScheme.foreground),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        actions: [
          AppButton.ghost(
            text: t['business_invoices_save_changes'] ?? 'Guardar',
            onPressed: _saveInvoice,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Header Card (Business Info + Date)
                          AppCard(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Logo
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    shape: BoxShape.circle,
                                    image:
                                        (businessLogo != null &&
                                            businessLogo.isNotEmpty)
                                        ? DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              businessLogo,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child:
                                      (businessLogo == null ||
                                          businessLogo.isEmpty)
                                      ? Icon(
                                          Icons.store,
                                          color:
                                              theme.colorScheme.mutedForeground,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.h4(businessName),
                                      const SizedBox(height: 4),
                                      AppText.small(
                                        '${t['business_invoice_title_prefix'] ?? 'Factura'} $invoiceId',
                                        color: theme.colorScheme.primary,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Date Picker
                                InkWell(
                                  onTap: () async {
                                    await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: theme.colorScheme.border,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_rounded,
                                          size: 16,
                                          color:
                                              theme.colorScheme.mutedForeground,
                                        ),
                                        const SizedBox(width: 8),
                                        AppText.small(
                                          dateStr,
                                          color:
                                              theme.colorScheme.mutedForeground,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // 2. Cliente Section
                          AppText.h4(
                            t['business_invoice_sheet_client_label'] ??
                                'Cliente',
                          ),
                          const SizedBox(height: 12),
                          if (_selectedLeadId == null)
                            AppSelect<int>(
                              value: _selectedLeadId,
                              onChanged: (val) =>
                                  setState(() => _selectedLeadId = val),
                              options: {
                                for (var l in leads)
                                  l.id:
                                      '${l.clientFirstName} ${l.clientLastName}',
                              },
                              placeholder:
                                  t['business_invoice_sheet_client_hint'] ??
                                  'Seleccionar cliente...',
                            )
                          else
                            AppCard(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor:
                                        theme.colorScheme.secondary,
                                    backgroundImage:
                                        (selectedLead
                                                ?.clientImageUrl
                                                ?.isNotEmpty ==
                                            true)
                                        ? CachedNetworkImageProvider(
                                            selectedLead!.clientImageUrl!,
                                          )
                                        : null,
                                    child:
                                        (selectedLead
                                                ?.clientImageUrl
                                                ?.isEmpty ??
                                            true)
                                        ? AppText.h4(
                                            selectedLead?.clientFirstName
                                                    .substring(0, 1) ??
                                                'C',
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.large(
                                          '${selectedLead?.clientFirstName} ${selectedLead?.clientLastName}',
                                        ),
                                        if (selectedLead?.clientPhone != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                            ),
                                            child: AppText.small(
                                              selectedLead!.clientPhone!,
                                              color: theme
                                                  .colorScheme
                                                  .mutedForeground,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        setState(() => _selectedLeadId = null),
                                    icon: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.background,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: theme.colorScheme.border,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color:
                                            theme.colorScheme.mutedForeground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 32),

                          // 3. Items Title + Add Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.h4(
                                t['business_invoice_sheet_concepts_title'] ??
                                    'Conceptos',
                              ),
                              AppButton.ghost(
                                text:
                                    t['business_invoice_sheet_add_item'] ??
                                    'Agregar ítem',
                                icon: Icons.add_circle_outline,
                                onPressed: _addItem,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // New Item Input Button
                          InkWell(
                            onTap: () => _showItemSearchSheet(context),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: theme.colorScheme.border,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: theme.colorScheme.mutedForeground,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  AppText.p(
                                    t['business_invoice_sheet_item_hint'] ??
                                        'Buscar o crear nuevo concepto...',
                                    color: theme.colorScheme.mutedForeground,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 4. Items List
                          if (_items.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: AppText.p(
                                  t['business_invoice_sheet_no_items'] ??
                                      "No hay ítems en la factura",
                                  color: theme.colorScheme.mutedForeground,
                                ),
                              ),
                            )
                          else
                            ..._items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              return _buildItemCard(index, item, t);
                            }),

                          const SizedBox(height: 32),

                          // 5. Totals Section
                          AppCard(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                _buildTotalRow(
                                  t['business_invoice_subtotal'] ?? 'Subtotal',
                                  _subTotal,
                                ),
                                const SizedBox(height: 12),
                                _buildTotalRow('TPS (5%)', _taxTPS),
                                const SizedBox(height: 12),
                                _buildTotalRow('TVQ (9.975%)', _taxTVQ),
                                const Divider(height: 32),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText.p(
                                      t['business_invoice_sheet_total_pay'] ??
                                          'Total a Pagar',
                                      color: theme.colorScheme.mutedForeground,
                                    ),
                                    AppText.h3(
                                      NumberFormat.currency(
                                        symbol: '\$',
                                      ).format(_total),
                                      color: theme.colorScheme.foreground,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),

                  // Footer Actions
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      border: Border(
                        top: BorderSide(color: theme.colorScheme.border),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton.outline(
                            text: t['business_invoices_cancel'] ?? 'Cancelar',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: AppButton.primary(
                            text: widget.initialData != null
                                ? t['business_invoices_save_changes'] ??
                                      'Guardar Cambios'
                                : t['business_invoice_create_button'] ??
                                      'Crear Factura',
                            onPressed: _isLoading ? null : _saveInvoice,
                            isLoading: _isLoading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemCard(
    int index,
    BusinessInvoiceItem item,
    Map<String, dynamic> t,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ShadInput(
                    initialValue: item.title,
                    placeholder: Text(
                      t['business_invoice_item_name_hint'] ?? 'Nombre del ítem',
                    ),
                    onChanged: (val) => item.title = val,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.small('Cantidad', color: Colors.grey),
                      const SizedBox(height: 4),
                      ShadInput(
                        initialValue: item.qty.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            item.qty = int.tryParse(val) ?? 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.small('Precio', color: Colors.grey),
                      const SizedBox(height: 4),
                      ShadInput(
                        initialValue: item.price.toStringAsFixed(2),
                        keyboardType: TextInputType.number,
                        leading: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text('\$'),
                        ),
                        onChanged: (val) {
                          setState(() {
                            item.price = double.tryParse(val) ?? 0.0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.small('Total', color: Colors.grey),
                      const SizedBox(height: 4),
                      Container(
                        height: 48,
                        alignment: Alignment.centerLeft,
                        child: AppText.large(
                          NumberFormat.currency(
                            symbol: '\$',
                          ).format(item.total),
                          color: Colors.blue,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, dynamic value) {
    final displayValue = value is String
        ? value
        : NumberFormat.currency(symbol: '\$').format(value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.p(
          label,
          color: ShadTheme.of(context).colorScheme.mutedForeground,
        ),
        AppText.large(
          displayValue,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void _showItemSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ItemSearchSheet(
        onSelected: (item) {
          _addItem(item);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _ItemSearchSheet extends ConsumerStatefulWidget {
  final Function(BusinessInvoiceItem) onSelected;

  const _ItemSearchSheet({required this.onSelected});

  @override
  ConsumerState<_ItemSearchSheet> createState() => __ItemSearchSheetState();
}

class __ItemSearchSheetState extends ConsumerState<_ItemSearchSheet> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedTab = 0; // 0: Services, 1: Events

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider).value;
    final services = businessData?.services ?? [];
    final events = businessData?.events ?? [];

    final theme = ShadTheme.of(context);
    final bgColor = theme.colorScheme.background;
    final textColor = theme.colorScheme.foreground;

    final filteredServices = services.where((s) {
      final name = (s['name'] ?? '').toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    final filteredEvents = events.where((e) {
      final name = (e['name'] ?? e['title'] ?? '').toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.h3('Agregar Concepto'),
                AppButton.ghost(
                  text: 'Crear Manual',
                  onPressed: () {
                    widget.onSelected(BusinessInvoiceItem());
                  },
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: AppInput.text(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              placeholder: 'Buscar servicios o eventos...',
              leading: const Icon(Icons.search, color: Colors.grey),
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTabButton('Servicios', 0),
                const SizedBox(width: 12),
                _buildTabButton('Eventos', 1),
              ],
            ),
          ),
          const Divider(),

          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildServiceList(filteredServices)
                : _buildEventList(filteredEvents),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final theme = ShadTheme.of(context);
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AppText.small(
          label,
          color: isSelected
              ? theme.colorScheme.primaryForeground
              : theme.colorScheme.foreground,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildServiceList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Center(
        child: AppText.p('No hay servicios encontrados', color: Colors.grey),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final name = item['name'] ?? 'Servicio';
        final priceCents = item['price_cents'] ?? 0;
        final price = priceCents / 100.0;
        final description = item['description'] ?? '';

        return ListTile(
          onTap: () {
            widget.onSelected(
              BusinessInvoiceItem(title: name, price: price, qty: 1),
            );
          },
          contentPadding: const EdgeInsets.only(bottom: 16),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ShadTheme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.design_services_outlined,
              color: ShadTheme.of(context).colorScheme.primary,
            ),
          ),
          title: AppText.p(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: AppText(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: AppText.p(
            NumberFormat.currency(symbol: '\$').format(price),
            color: Colors.green,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget _buildEventList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Center(
        child: AppText.p('No hay eventos encontrados', color: Colors.grey),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final name = item['name'] ?? item['title'] ?? 'Evento';
        dynamic rawPrice =
            item['ticket_price'] ?? item['price'] ?? item['price_cents'] ?? 0;
        double price = 0.0;
        if (rawPrice is int) price = rawPrice / 100.0;
        if (rawPrice is double) price = rawPrice;

        return ListTile(
          onTap: () {
            widget.onSelected(
              BusinessInvoiceItem(title: name, price: price, qty: 1),
            );
          },
          contentPadding: const EdgeInsets.only(bottom: 16),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ShadTheme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event,
              color: ShadTheme.of(context).colorScheme.primary,
            ),
          ),
          title: AppText.p(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: AppText(
            item['location'] ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: AppText.p(
            NumberFormat.currency(symbol: '\$').format(price),
            color: Colors.green,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}

class BusinessInvoiceItem {
  String title;
  int qty;
  double price;

  BusinessInvoiceItem({this.title = '', this.qty = 1, this.price = 0.0});

  double get total => qty * price;
}
