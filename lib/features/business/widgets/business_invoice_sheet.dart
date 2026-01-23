import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  void _addItem() {
    setState(() {
      _items.add(BusinessInvoiceItem());
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
        const SnackBar(content: Text('Por favor selecciona un cliente')),
      );
      return;
    }

    // Validate items
    if (_items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Agrega al menos un ítem')));
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
              widget.initialData != null ? 'Guardado' : 'Factura creada',
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
    final businessData = ref.watch(businessProvider).value;
    final leads = businessData?.recentLeads ?? [];

    // Find selected lead
    final selectedLead = _selectedLeadId != null
        ? leads.firstWhere(
            (l) => l.id == _selectedLeadId,
            orElse: () => leads.first,
          )
        : null; // Safe fallback logic needed or just handling null

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''), // Custom header below
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Save Draft placeholder
          TextButton(
            onPressed: _saveInvoice,
            child: Text(
              'Guardar',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Header Card (Business Info)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          // Logo Placeholder
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            backgroundImage:
                                (businessLogo != null &&
                                    businessLogo.isNotEmpty)
                                ? CachedNetworkImageProvider(businessLogo)
                                : null,
                            child:
                                (businessLogo == null || businessLogo.isEmpty)
                                ? const Icon(Icons.store, color: Colors.black)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  businessName,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Venezuela', // Location mock
                                  style: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                invoiceId,
                                style: GoogleFonts.inter(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    dateStr,
                                    style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 2. Cliente Section
                    Text(
                      'Cliente',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (_selectedLeadId == null)
                      // Search Bar / Dropdown
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          hintText: 'Buscar clientes',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                        ),
                        items: leads.map((l) {
                          return DropdownMenuItem(
                            value: l.id,
                            child: Text(
                              '${l.clientFirstName} ${l.clientLastName}',
                            ),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _selectedLeadId = val),
                      )
                    else
                      // Selected Client Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB), // Grey bg
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  (selectedLead?.clientImageUrl != null &&
                                      selectedLead!.clientImageUrl!.isNotEmpty)
                                  ? CachedNetworkImageProvider(
                                      selectedLead.clientImageUrl!,
                                    )
                                  : null,
                              radius: 20,
                              child:
                                  (selectedLead?.clientImageUrl == null ||
                                      selectedLead!.clientImageUrl!.isEmpty)
                                  ? Text(
                                      selectedLead?.clientFirstName.substring(
                                            0,
                                            1,
                                          ) ??
                                          'C',
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${selectedLead?.clientFirstName} ${selectedLead?.clientLastName}',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'cliente@email.com', // Mock email
                                    style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 12,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        selectedLead?.clientPhone ?? 'No phone',
                                        style: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Caracas, Vzla',
                                        style: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ), // Red X
                              onPressed: () =>
                                  setState(() => _selectedLeadId = null),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),

                    // 3. Agregar Items
                    Text(
                      'Agregar items',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: _addItem,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(4), // Inner padding
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Icon(Icons.search, color: Colors.grey),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Buscar o escribir un item...',
                                style: GoogleFonts.inter(color: Colors.grey),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A), // Dark Button
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Agregar item',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 4. Items List
                    ..._items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return _buildItemCard(index, item);
                    }),

                    const SizedBox(height: 32),

                    // 5. Totals
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildTotalRow(
                            'Sub-Total:',
                            NumberFormat.currency(
                              symbol: '\$',
                            ).format(_subTotal),
                          ),
                          const SizedBox(height: 8),
                          _buildTotalRow(
                            'TPS (5.00%):',
                            NumberFormat.currency(symbol: '\$').format(_taxTPS),
                          ),
                          const SizedBox(height: 8),
                          _buildTotalRow(
                            'TVQ (9.975%):',
                            NumberFormat.currency(symbol: '\$').format(_taxTVQ),
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total amount:',
                                style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                  symbol: '\$',
                                ).format(_total),
                                style: GoogleFonts.outfit(
                                  color: const Color(0xFF2563EB),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100), // Space for footer
                  ],
                ),
              ),
            ),

            // Footer Layout
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveInvoice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFE5E7EB,
                    ), // Grey bg as per image "Guardar borrador"
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Guardar borrador',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(int index, BusinessInvoiceItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: item.title,
                  decoration: const InputDecoration(
                    hintText: 'Nombre del ítem',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
          const Divider(),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        initialValue: item.qty.toString(),
                        keyboardType: TextInputType.number,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        initialValue: item.price.toStringAsFixed(2),
                        keyboardType: TextInputType.number,
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

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey[700])),
        Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ],
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
