import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/settings/providers/profile_provider.dart';

class BusinessInvoiceDetailsSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic> invoice;

  const BusinessInvoiceDetailsSheet({super.key, required this.invoice});

  @override
  ConsumerState<BusinessInvoiceDetailsSheet> createState() =>
      _BusinessInvoiceDetailsSheetState();
}

class _BusinessInvoiceDetailsSheetState
    extends ConsumerState<BusinessInvoiceDetailsSheet> {
  Uint8List? _pdfBytes;
  bool _isLoadingPdf = true;

  @override
  void initState() {
    super.initState();
    _fetchPdfBytes();
  }

  Future<void> _fetchPdfBytes() async {
    final rawId = widget.invoice['raw_id'] ?? widget.invoice['id'];

    if (rawId == null) {
      if (mounted) setState(() => _isLoadingPdf = false);
      return;
    }

    try {
      final repo = ref.read(businessRepositoryProvider);
      final bytes = await repo.getQuotePdfBytes(int.parse(rawId.toString()));

      bool isValid = false;
      if (bytes != null && bytes.length > 50) {
        final header = String.fromCharCodes(bytes.take(5));
        if (header.contains('%PDF')) {
          isValid = true;
        }
      }

      if (mounted) {
        if (isValid) {
          setState(() {
            _pdfBytes = bytes;
            _isLoadingPdf = false;
          });
        } else {
          // Fallback
          final localBytes = await _generateLocalPdf();
          setState(() {
            _pdfBytes = localBytes;
            _isLoadingPdf = false;
          });
        }
      }
    } catch (e) {
      try {
        final localBytes = await _generateLocalPdf();
        if (mounted) {
          setState(() {
            _pdfBytes = localBytes;
            _isLoadingPdf = false;
          });
        }
      } catch (e2) {
        if (mounted) setState(() => _isLoadingPdf = false);
      }
    }
  }

  Future<Uint8List> _generateLocalPdf() async {
    final pdf = pw.Document();
    final inv = widget.invoice;
    final business =
        ref.read(businessProvider).value?.businessProfile ?? inv['business'];

    final invNumber =
        inv['number']?.toString() ?? inv['id'].toString().padLeft(6, '0');

    // Resolve Images
    pw.ImageProvider? businessLogo;
    pw.ImageProvider? clientAvatar;

    try {
      if (business != null) {
        final url = _resolveBusinessImage(business);
        if (url.isNotEmpty) businessLogo = await networkImage(url);
      }
    } catch (_) {}

    try {
      final clientUrl = _resolveClientImage(inv['client']);
      if (clientUrl.isNotEmpty) clientAvatar = await networkImage(clientUrl);
    } catch (_) {}

    final List<dynamic> items =
        inv['line_items'] ??
        [
          {
            'description': inv['title'] ?? 'Service',
            'quantity': 1,
            'unit_price': inv['amount'] ?? '0.00',
            'total_price': inv['amount'] ?? '0.00',
          },
        ];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "INVOICE #$invNumber",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Total Amount: \$${inv['amount']}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (businessLogo != null)
                pw.Container(height: 50, child: pw.Image(businessLogo)),
              if (clientAvatar != null)
                pw.Container(height: 50, child: pw.Image(clientAvatar)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Description', 'Qty', 'Price', 'Total'],
                data: items
                    .map(
                      (i) => [
                        i['description'] ?? '',
                        i['quantity']?.toString() ?? '1',
                        '\$${i['unit_price']}',
                        '\$${i['total_price']}',
                      ],
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> _printPdf() async {
    if (_pdfBytes != null) {
      await Printing.layoutPdf(
        onLayout: (_) => _pdfBytes!,
        name: 'Factura ${widget.invoice['number'] ?? ''}',
      );
    }
  }

  String _resolveClientImage(dynamic clientData) {
    if (clientData == null) return '';
    if (clientData is String) {
      if (clientData.startsWith('http')) return clientData;
      return Supabase.instance.client.storage
          .from('client')
          .getPublicUrl(clientData);
    }

    if (clientData is Map) {
      String? path =
          clientData['image'] ??
          clientData['photo_id'] ??
          clientData['profile_url'];
      if (path == null || path.isEmpty) return '';
      if (path.startsWith('http')) return path;

      if (!path.contains('/') && clientData['id'] != null) {
        path = '${clientData['id']}/$path';
      }
      return Supabase.instance.client.storage.from('client').getPublicUrl(path);
    }
    return '';
  }

  String _resolveBusinessImage(dynamic businessData) {
    if (businessData == null) return '';
    if (businessData is Map) {
      String? path = businessData['profile_image'] ?? businessData['image'];
      if (path == null || path.isEmpty) return '';
      if (path.startsWith('http')) return path;

      if (!path.contains('/') && businessData['id'] != null) {
        path = '${businessData['id']}/$path';
      }
      return Supabase.instance.client.storage
          .from('business_profile')
          .getPublicUrl(path);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E2126) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final secondaryTextColor = isDark
        ? const Color(0xFF9AA0A6)
        : const Color(0xFF6B7280);
    final primaryBlue = const Color(0xFF4285F4);

    // Data
    final invoice = widget.invoice;
    final invoiceNumber =
        invoice['id']?.toString().replaceAll('#INV-', '') ?? '000000';
    final amount = invoice['amount'].toString();

    // Dates
    DateTime? createdDate;
    if (invoice['fullDate'] != null) {
      createdDate = DateTime.tryParse(invoice['fullDate']);
    }

    final issuedDate = createdDate != null
        ? DateFormat('MMMM dd, yyyy').format(createdDate)
        : 'Unknown Date';

    // Mock Due Date logic: +30 days from issued or use 'expiring' if available
    // invoice map from widget doesn't strictly have expiring, but the quote object might have.
    // For now, we fallback to issued + 30 days.
    final dueDateObj = createdDate?.add(const Duration(days: 30));
    final dueDate = dueDateObj != null
        ? DateFormat('MMMM dd, yyyy').format(dueDateObj)
        : 'Unknown Date';

    final clientName = invoice['client']['name'].toString();
    // Resolving Client Email
    final clientEmail =
        invoice['client']['email']?.toString().isNotEmpty == true
        ? invoice['client']['email']
        : 'info@client.com'; // Fallback if empty in map

    // Fallback for phone/address if not in map (likely not currently mapped in parent widget)
    // Parent widget only maps: name, email, image.
    final clientPhone = '(555) 123-4567';
    final clientAddress = '456 Client Ave, City, State 90210';

    final businessState = ref.watch(businessProvider);
    final businessProfile = businessState.value?.businessProfile;

    final businessName =
        businessProfile?['name'] ??
        invoice['business_name'] ??
        'AR Design & Commerce';

    final businessEmail = businessProfile?['email'] ?? 'contact@business.com';
    final businessPhone =
        businessProfile?['phone']?.toString() ?? '+58 02125555555';
    final businessAddress =
        businessProfile?['address']?.toString() ??
        'Chuao/Lave, Miranda, 1010, Republica de Venezuela\n1210';

    // Get profile for direct image access
    final profile = ref.watch(profileProvider).value;

    // Images
    String businessImage = '';
    // Priority to profile provider as requested
    if (profile?.businessProfileImage != null) {
      businessImage = _resolveBusinessImage({
        'profile_image': profile?.businessProfileImage,
        'id': profile?.businessId,
      });
    } else if (businessProfile != null) {
      businessImage = _resolveBusinessImage(businessProfile);
    } else {
      businessImage = _resolveBusinessImage(invoice['business']);
    }

    final clientImage = _resolveClientImage(invoice['client']);

    final List<dynamic> items =
        invoice['line_items'] ??
        [
          {
            'description': invoice['serviceName'] ?? 'Service',
            'quantity': 1,
            'unit_price': invoice['subtotal'] ?? amount,
            'total_price': invoice['subtotal'] ?? amount,
          },
        ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            // Top Bar
            const SizedBox(
              height: 60,
            ), // Added significant top spacing as requested (~80px total with padding)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button (Left)
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C313C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: Text(
                      'Back',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  // Title (Right)
                  Text(
                    'Invoice details: #$invoiceNumber',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Top Cards Row
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Card: Logo
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF282C31)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: businessImage.isNotEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: CachedNetworkImage(
                                              imageUrl: businessImage,
                                              fit: BoxFit.contain,
                                              errorWidget: (_, __, ___) =>
                                                  const Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            businessName,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.outfit(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: textColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    : Text(
                                        businessName,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: textColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Right Card: Client & Total
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF282C31)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage: clientImage.isNotEmpty
                                            ? CachedNetworkImageProvider(
                                                clientImage,
                                              )
                                            : null,
                                        backgroundColor: Colors.grey[200],
                                        child: clientImage.isEmpty
                                            ? Icon(
                                                Icons.person,
                                                size: 12,
                                                color: Colors.grey,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          clientName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Total amount:",
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    amount.replaceAll('\$', ''),
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    "\$ USD",
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pills Row
                    // Invoice Number Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF282C31)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(50), // Pill shape
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Invoice Number",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: secondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "#$invoiceNumber",
                            style: GoogleFonts.outfit(
                              fontSize: 24, // Large
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Dates Card (Issued / Due)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF282C31)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Issued
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Issued:",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryTextColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  issuedDate,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Due
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Due date:",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryTextColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dueDate,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const SizedBox(height: 24),

                    // Addresses Cards
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Client Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF282C31)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clientName,
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "$clientPhone\n$clientEmail\n$clientAddress",
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: secondaryTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Business Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF282C31)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  businessName,
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "$businessPhone\n$businessEmail\n$businessAddress",
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: secondaryTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Table
                    // Header
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Description",
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Qty",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Price",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Total",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    const SizedBox(height: 12),

                    // Items
                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                item['description'] ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${item['quantity'] ?? 1}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: secondaryTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\$${item['unit_price']}",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: secondaryTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\$${item['total_price']}",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    const SizedBox(height: 16),

                    // Total
                    // Tax Breakdown & Total
                    Builder(
                      builder: (ctx) {
                        // Parse amount string to double
                        final cleanAmount = amount.replaceAll(
                          RegExp(r'[^0-9.]'),
                          '',
                        );
                        final subTotalVal = double.tryParse(cleanAmount) ?? 0.0;

                        // Calculate taxes
                        final tps = subTotalVal * 0.05;
                        final tvq = subTotalVal * 0.09975;
                        final totalVal = subTotalVal + tps + tvq;

                        final currencyFormat = NumberFormat.currency(
                          symbol: '\$',
                          decimalDigits: 2,
                          locale: 'en_US',
                        );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Sub-Total:",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryTextColor,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    currencyFormat.format(subTotalVal),
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.inter(
                                      fontSize: 14, // Slightly larger
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "TPS (5,00%):",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryTextColor,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    currencyFormat.format(tps),
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "TVQ (9,975%):",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryTextColor,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    currencyFormat.format(tvq),
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Total
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Total amount:",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 120, // More width for total
                                  child: Text(
                                    currencyFormat.format(totalVal),
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.outfit(
                                      fontSize:
                                          20, // Bold and blue similar to screenshot
                                      fontWeight: FontWeight.bold,
                                      color: primaryBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Terms & QR
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terms & Conditions:",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Fees and payment terms will be established in the contract or agreement prior to the commencement of the project.",
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: secondaryTextColor,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              QrImageView(
                                data: 'invoice-$invoiceNumber',
                                size: 40,
                                padding: EdgeInsets.zero,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "connek",
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Ad Buttons (Requested)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100, // Boxy
                            decoration: BoxDecoration(
                              color: const Color(0xFF8AB4F8), // Light Blue
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                "AD IMAGE 1",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8AB4F8), // Light Blue
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                "AD IMAGE 2",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // PDF Preview
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: _isLoadingPdf
                            ? const Center(child: CircularProgressIndicator())
                            : _pdfBytes != null
                            ? PdfPreview(
                                build: (format) => _pdfBytes!,
                                useActions: false,
                                scrollViewDecoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                allowPrinting: false,
                                allowSharing: false,
                                canChangeOrientation: false,
                                canChangePageFormat: false,
                              )
                            : const Center(child: Text("Preview unavailable")),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Download Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _printPdf,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C313C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.add), // Plus icon in design
                        label: Text(
                          'Download PDF Invoice',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
