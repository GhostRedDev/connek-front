import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'business_invoice_sheet.dart';
import '../providers/business_provider.dart';

class BusinessInvoiceDetailsSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic> invoice;

  const BusinessInvoiceDetailsSheet({super.key, required this.invoice});

  @override
  ConsumerState<BusinessInvoiceDetailsSheet> createState() =>
      _BusinessInvoiceDetailsSheetState();
}

class _BusinessInvoiceDetailsSheetState
    extends ConsumerState<BusinessInvoiceDetailsSheet> {
  bool _isDownloading = false;

  Future<void> _downloadPdf() async {
    final rawId = widget.invoice['raw_id'];
    if (rawId == null) return;

    setState(() => _isDownloading = true);

    try {
      final repo = ref.read(businessRepositoryProvider);
      final url = await repo.getQuotePdfUrl(int.parse(rawId.toString()));
      if (url != null) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('No se puede abrir el PDF');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al descargar PDF: $e')));
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1A1D21) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    final invoice = widget.invoice;
    final id = invoice['id'].toString();
    final status = invoice['status'].toString();
    final amount = invoice['amount'].toString();
    final dateRange = invoice['dateRange'].toString();
    final clientName = invoice['client']['name'].toString();
    final clientImage = invoice['client']['image'];

    // Determine status colors
    Color statusColor;
    Color statusBg;
    if (status == 'Pagada') {
      statusColor = const Color(0xFF0F9D58);
      statusBg = const Color(0xFFE8F5E9);
    } else {
      statusColor = Colors.grey;
      statusBg = Colors.grey[200]!;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 8,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header with Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 20, color: textColor),
                  ),
                ),
                Text(
                  'Detalle de Factura',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // Close details
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          BusinessInvoiceSheet(initialData: widget.invoice),
                    );
                  },
                  icon: Icon(Icons.edit, size: 20, color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Invoice Status & Amount Hero Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF2C3E50), const Color(0xFF000000)]
                      : [const Color(0xFFF8FAFC), const Color(0xFFF1F5F9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    amount,
                    style: GoogleFonts.outfit(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    id,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Client Info
            Text(
              'Cliente',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(clientImage),
                    radius: 24,
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'Cliente Verificado',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Details List
            Text(
              'Detalles de Facturación',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              'Servicio',
              invoice['serviceName'] ?? 'General',
              textColor,
            ),
            const Divider(height: 24),
            // Dates
            if (invoice['fullDate'] != null) ...[
              _buildDetailRow(
                'Fecha Emisión',
                // Format fullDate more nicely if possible, or just use it
                invoice['fullDate'].toString().split(' ')[0],
                textColor,
              ),
              const Divider(height: 24),
            ],
            _buildDetailRow(
              'Vencimiento',
              dateRange.contains('-')
                  ? dateRange.split('-')[1].trim()
                  : 'A la vista',
              textColor,
            ),
            const Divider(height: 24),
            _buildDetailRow(
              'Método de Pago',
              invoice['paymentMethod'] ?? 'N/A',
              textColor,
            ),

            const SizedBox(height: 24),
            Text(
              'Desglose',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              'Subtotal',
              invoice['subtotal'] ?? amount,
              textColor,
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Impuestos', invoice['tax'] ?? '\$0.00', textColor),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  amount,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4285F4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isDownloading ? null : _downloadPdf,
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColor, // Inverted for contrast
                  foregroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: _isDownloading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download_rounded),
                label: Text(
                  _isDownloading ? 'Descargando...' : 'Descargar Factura PDF',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
