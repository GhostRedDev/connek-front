import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/providers/locale_provider.dart';

import '../providers/business_provider.dart';

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

  // Controllers (we might need a list of controllers, but for simplicity we rely on state updates)
  // Actually, using controllers for list items is best for performance, but requires management.
  // We'll use a simple state-bound approach for now.

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _initFormData();
    } else {
      // Add one empty item by default
      _items.add(BusinessInvoiceItem());
    }
  }

  void _initFormData() {
    final data = widget.initialData!;
    if (data.containsKey('lead_id')) {
      _selectedLeadId = data['lead_id'];
    }
    // Parse items from data if available, otherwise mock or parse text
    // Since backend stores flat description/amount, we might just try to reconstruct or reset.
    // For now we assume new structure or reset to single item with full amount if complex.
    final amountCents = data['amountCents'] ?? 0;
    final amount = amountCents / 100.0;

    // Attempt to parse description? No, just set one item with the total.
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
        ), // Access ref.read since it's a callback
      );
      return;
    }

    // Validate items
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
            // 'items': _items.map((e) => e.toMap()).toList(), // If backend supported better
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Theme Colors
    final bgColor = isDark ? const Color(0xFF111418) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1F2937) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final subTextColor = isDark ? Colors.grey[400] : const Color(0xFF64748B);
    final borderColor = isDark
        ? Colors.grey[800]!
        : Colors.grey.withOpacity(0.1);
    final inputFillColor = isDark
        ? const Color(0xFF374151)
        : Colors.grey.shade50;

    // Find selected lead
    final selectedLead = _selectedLeadId != null
        ? leads.firstWhere(
            (l) => l.id == _selectedLeadId,
            orElse: () => leads.first,
          )
        : null;

    // Invoice ID Mock
    final invoiceId = widget.initialData != null
        ? '#INV-${widget.initialData!['raw_id']}'
        : 'NUEVA';

    final dateStr = DateFormat('dd MMM yyyy', 'es').format(DateTime.now());

    // Safe Access for Business Profile Map
    final businessProfile = businessData?.businessProfile;
    final String? businessLogo = businessProfile?['profile_image'];
    final String businessName = businessProfile?['name'] ?? 'Mi Negocio';

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: bgColor,
        elevation: 0,
        actions: [
          // Save Draft placeholder
          TextButton(
            onPressed: _saveInvoice,
            child: Text(
              t['business_invoices_save_changes'] ?? 'Guardar',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // final isDesktop = constraints.maxWidth > 800; // Unused
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
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: borderColor),
                              boxShadow: isDark
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Logo
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.grey[800]
                                        : Colors.grey.shade50,
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
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.blueGrey,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        businessName,
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${t['business_invoice_title_prefix'] ?? 'Factura'} $invoiceId',
                                        style: GoogleFonts.inter(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
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
                                      border: Border.all(color: borderColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_rounded,
                                          size: 16,
                                          color: subTextColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          dateStr,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            color: subTextColor,
                                          ),
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
                          Text(
                            t['business_invoice_sheet_client_label'] ??
                                'Cliente',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: subTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (_selectedLeadId == null)
                            Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: isDark
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.02),
                                          blurRadius: 8,
                                        ),
                                      ],
                              ),
                              child: DropdownButtonFormField<int>(
                                icon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: subTextColor,
                                ),
                                dropdownColor: cardColor,
                                decoration: InputDecoration(
                                  hintText:
                                      t['business_invoice_sheet_client_hint'] ??
                                      'Seleccionar cliente...',
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.grey.shade400,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? const Color(0xFF282C34)
                                      : Colors.grey.shade50,
                                ),
                                items: leads.map((l) {
                                  return DropdownMenuItem(
                                    value: l.id,
                                    child: Text(
                                      '${l.clientFirstName} ${l.clientLastName}',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        color: textColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedLeadId = val),
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: borderColor),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: isDark
                                        ? Colors.grey[700]
                                        : Colors.grey[200],
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
                                        ? Text(
                                            selectedLead?.clientFirstName
                                                    .substring(0, 1) ??
                                                'C',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: textColor,
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${selectedLead?.clientFirstName} ${selectedLead?.clientLastName}',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: textColor,
                                          ),
                                        ),
                                        if (selectedLead?.clientPhone != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                            ),
                                            child: Text(
                                              selectedLead!.clientPhone!,
                                              style: GoogleFonts.inter(
                                                color: subTextColor,
                                                fontSize: 12,
                                              ),
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
                                        color: isDark
                                            ? Colors.grey[800]
                                            : Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: borderColor),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.blueGrey,
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
                              Text(
                                t['business_invoice_sheet_concepts_title'] ??
                                    'Conceptos',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: subTextColor,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: _addItem,
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 18,
                                ),
                                label: Text(
                                  t['business_invoice_sheet_add_item'] ??
                                      'Agregar ítem',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blueAccent,
                                ),
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
                                border: Border.all(color: borderColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey.shade400,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    t['business_invoice_sheet_item_hint'] ??
                                        'Buscar o crear nuevo concepto...',
                                    style: GoogleFonts.inter(
                                      color: Colors.grey.shade500,
                                    ),
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
                                child: Text(
                                  t['business_invoice_sheet_no_items'] ??
                                      "No hay ítems en la factura",
                                  style: GoogleFonts.inter(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            )
                          else
                            ..._items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              return _buildItemCard(
                                index,
                                item,
                                isDark,
                                cardColor,
                                textColor,
                                borderColor,
                                inputFillColor,
                                t,
                              );
                            }),

                          const SizedBox(height: 32),

                          // 5. Totals Section
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFF0F172A),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildTotalRow(
                                  t['business_invoice_subtotal'] ?? 'Subtotal',
                                  _subTotal,
                                  isDark: true,
                                ),
                                const SizedBox(height: 12),
                                _buildTotalRow(
                                  'TPS (5%)',
                                  _taxTPS,
                                  isDark: true,
                                ),
                                const SizedBox(height: 12),
                                _buildTotalRow(
                                  'TVQ (9.975%)',
                                  _taxTVQ,
                                  isDark: true,
                                ),
                                const Divider(
                                  color: Colors.white24,
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      t['business_invoice_sheet_total_pay'] ??
                                          'Total a Pagar',
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      NumberFormat.currency(
                                        symbol: '\$',
                                      ).format(_total),
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                        top: BorderSide(
                          color: isDark ? Colors.white10 : Colors.grey.shade100,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              side: BorderSide(
                                color: isDark
                                    ? Colors.white24
                                    : Colors.grey.shade300,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              t['business_invoices_cancel'] ?? 'Cancelar',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _saveInvoice,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    widget.initialData != null
                                        ? t['business_invoices_save_changes'] ??
                                              'Guardar Cambios'
                                        : t['business_invoice_create_button'] ??
                                              'Crear Factura',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
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
    bool isDark,
    Color cardColor,
    Color textColor,
    Color borderColor,
    Color inputFillColor,
    Map<String, dynamic> t,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: item.title,
                  decoration: InputDecoration(
                    hintText:
                        t['business_invoice_item_name_hint'] ??
                        'Nombre del ítem',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textColor,
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
          Divider(color: isDark ? Colors.white10 : Colors.grey.shade200),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cantidad',
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: inputFillColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        initialValue: item.qty.toString(),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          setState(() {
                            item.qty = int.tryParse(val) ?? 1;
                          });
                        },
                      ),
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
                    Text(
                      'Precio',
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: inputFillColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        initialValue: item.price.toStringAsFixed(2),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixText: '\$',
                        ),
                        onChanged: (val) {
                          setState(() {
                            item.price = double.tryParse(val) ?? 0.0;
                          });
                        },
                      ),
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
                    Text(
                      'Total',
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 48,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        NumberFormat.currency(symbol: '\$').format(item.total),
                        style: GoogleFonts.inter(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
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

  Widget _buildTotalRow(String label, dynamic value, {bool isDark = false}) {
    // Value can be string or double, handle implicit formatting if needed, but here usage passes formatted string?
    // Wait, in usage I passed `_subTotal` (double)! I need to format it or change usage.
    // Actually in the previous code: `_buildTotalRow('Sub-Total:', NumberFormat...)`.
    // In my NEW code: `_buildTotalRow('Subtotal', _subTotal, isDark: true)`
    // So I need to handle formatting here or change usage.
    // Let's accept double and format it inside to be safe with my previous edit.

    final displayValue = value is String
        ? value
        : NumberFormat.currency(symbol: '\$').format(value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isDark ? Colors.white70 : Colors.grey[700],
            fontSize: 14,
          ),
        ),
        Text(
          displayValue,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
            fontSize: 14,
          ),
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

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    // Filter Logic
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
                Text(
                  'Agregar Concepto',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add manual empty item
                    widget.onSelected(BusinessInvoiceItem());
                  },
                  child: const Text('Crear Manual'),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: TextStyle(color: textColor),
                decoration: const InputDecoration(
                  hintText: 'Buscar servicios o eventos...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTab('Servicios', 0, isDark),
                const SizedBox(width: 12),
                _buildTab('Eventos', 1, isDark),
              ],
            ),
          ),
          const Divider(),

          // List
          Expanded(
            child: _selectedTab == 0
                ? _buildServiceList(filteredServices, isDark, textColor)
                : _buildEventList(filteredEvents, isDark, textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, bool isDark) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : (isDark ? Colors.white10 : Colors.grey[200]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.black87),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceList(
    List<Map<String, dynamic>> items,
    bool isDark,
    Color textColor,
  ) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No hay servicios encontrados',
          style: TextStyle(color: Colors.grey),
        ),
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
              color: isDark ? Colors.white10 : Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.design_services_outlined,
              color: Colors.blue,
            ),
          ),
          title: Text(
            name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          subtitle: Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            NumberFormat.currency(symbol: '\$').format(price),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventList(
    List<Map<String, dynamic>> items,
    bool isDark,
    Color textColor,
  ) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No hay eventos encontrados',
          style: TextStyle(color: Colors.grey),
        ),
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
              color: isDark ? Colors.white10 : Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event, color: Colors.orange),
          ),
          title: Text(
            name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          subtitle: Text(
            item['location'] ?? '',
            maxLines: 1,
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            NumberFormat.currency(symbol: '\$').format(price),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
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
