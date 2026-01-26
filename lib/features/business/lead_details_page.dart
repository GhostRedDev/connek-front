import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../leads/models/lead_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'providers/business_provider.dart';
import 'widgets/business_proposal_sheet.dart';

class LeadDetailsPage extends ConsumerWidget {
  final Lead lead;
  final Map<String, dynamic>? service;

  const LeadDetailsPage({super.key, required this.lead, this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('DEBUG: LeadDetailsPage build. Lead ID: ${lead.id}');
    final businessData = ref.watch(businessProvider).value;
    // Try to find updated lead in provider, otherwise use passed lead
    final currentLead =
        businessData?.recentLeads.firstWhere(
          (l) => l.id == lead.id,
          orElse: () => lead,
        ) ??
        lead;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;

    final name = '${currentLead.clientFirstName} ${currentLead.clientLastName}'
        .trim();
    final leadImage = currentLead.clientImageUrl;
    final dateStr =
        '${currentLead.createdAt.day}/${currentLead.createdAt.month}/${currentLead.createdAt.year} ${currentLead.createdAt.hour}:${currentLead.createdAt.minute.toString().padLeft(2, '0')}';
    final amount = (currentLead.requestBudgetMax ?? 0) / 100.0;

    // Status Logic
    String statusText = 'Pendiente';
    Color statusColor = const Color(0xFFFB8C00);
    Color statusBgColor = const Color(0xFFFFF3E0);

    if (currentLead.status == 'completed' ||
        currentLead.status == 'converted') {
      statusText = 'Completado';
      statusColor = const Color(0xFF4285F4);
      statusBgColor = const Color(0xFFE3F2FD);
    } else if (currentLead.status == 'cancelled' ||
        currentLead.status == 'declined') {
      statusText = 'Cancelado';
      statusColor = const Color(0xFFFF5252);
      statusBgColor = const Color(0xFFFFEBEE);
    }

    // Service Info
    Map<String, dynamic>? resolvedService = service;

    if (resolvedService == null) {
      final businessData = ref.watch(businessProvider).value;
      if (businessData != null) {
        try {
          resolvedService = businessData.services.firstWhere(
            (s) => s['id'] == lead.serviceId,
            orElse: () => {},
          );
          if (resolvedService.isEmpty) resolvedService = null;
        } catch (_) {}
      }
    }

    final serviceName = resolvedService != null
        ? resolvedService['name'] ?? 'Servicio'
        : 'Servicio';

    String servicePrice = '\$--';
    if (resolvedService != null && resolvedService['price_cents'] != null) {
      final price = (resolvedService['price_cents'] as int) / 100.0;
      servicePrice = '\$${price.toStringAsFixed(2)}';
    }

    String? serviceImageView = resolvedService != null
        ? (resolvedService['profile_image'] as String?)
        : null;

    // Fix Service Image URL
    if (serviceImageView != null && !serviceImageView.startsWith('http')) {
      serviceImageView =
          'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/business/$serviceImageView';
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
            bottom: 8,
            right: 16,
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 36,
                width: 80,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      size: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Volver",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: Text(
          'Detalles del cliente potencial',
          style: GoogleFonts.outfit(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          final leadImageUrl = (leadImage != null && leadImage.isNotEmpty)
              ? (leadImage.startsWith('http')
                    ? leadImage
                    : 'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/client/$leadImage')
              : '';

          if (isDesktop) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- LEFT COLUMN ---
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        // Client Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: leadImageUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) => Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Financial',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          name,
                                          style: GoogleFonts.outfit(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "5.0",
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        dateStr,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1B5E20),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          '\$${amount.toStringAsFixed(0)}',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusBgColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          statusText,
                                          style: GoogleFonts.inter(
                                            color: statusColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () =>
                                          context.push('/chats/${lead.id}'),
                                      icon: const Icon(
                                        Icons.message_outlined,
                                        size: 16,
                                      ),
                                      label: const Text('Mensaje'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: cardColor,
                                        foregroundColor: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        elevation: 0,
                                        side: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        final uri = Uri.parse(
                                          'tel:${lead.clientPhone ?? ""}',
                                        );
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "No se pudo iniciar la llamada",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.phone, size: 16),
                                      label: const Text('Llamar'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        elevation: 0,
                                        side: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          context.push('/chats/${lead.id}'),
                                      child: const Text('Enviar mensaje'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF111418,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      child: const Text('Ver perfil'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        backgroundColor: isDark
                                            ? Colors.white10
                                            : Colors.grey[200],
                                        side: BorderSide.none,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // About Request Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About request',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Service Widget
                              if (resolvedService != null)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white10
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          image: serviceImageView != null
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    serviceImageView!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                          color: Colors.grey[300],
                                        ),
                                        child: serviceImageView == null
                                            ? Center(
                                                child: Icon(
                                                  Icons.spa,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : null,
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "Service",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              serviceName,
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              servicePrice,
                                              style: GoogleFonts.inter(
                                                color: Colors.green,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.push(
                                            '/business/create-service',
                                            extra: resolvedService,
                                          );
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey[200],
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Ver servicio",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (resolvedService == null)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Text("No service info available"),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 16),
                              Text(
                                "Mensaje:",
                                style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lead.requestDescription.isNotEmpty
                                    ? lead.requestDescription
                                    : "Sin descripción.",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Presupuesto: ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: "\$${amount.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) =>
                                          BusinessProposalSheet(
                                            prefilledLead: currentLead,
                                          ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF111418),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: const Text("Cotizar"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),

                  // --- RIGHT COLUMN ---
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Timeline
                        _buildDynamicTimeline(context, currentLead),
                        const SizedBox(height: 20),

                        _buildFinancialActivity(
                          context,
                          ref,
                          cardColor,
                          currentLead,
                        ),
                        const SizedBox(height: 20),

                        _buildManageLeadTile(context, ref, currentLead),
                        const SizedBox(height: 20),

                        // Delete Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            label: const Text(
                              "Eliminar Lead",
                              style: TextStyle(color: Colors.red),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: Colors.red,
                                width: 0.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // --- MOBILE LAYOUT (Existing) ---
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ), // Standard padding
            child: Column(
              children: [
                // --- Client Card ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    // Shadow / Border if needed
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: leadImageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Financial', // Hardcoded role/tag based on image? Or just "Lead"
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "5.0",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                dateStr,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B5E20),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '\$${amount.toStringAsFixed(0)}',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusBgColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  statusText,
                                  style: GoogleFonts.inter(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  context.push('/chats/${lead.id}'),
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 16,
                              ),
                              label: const Text('Enviar mensaje'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF111418,
                                ), // Dark button
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Ver perfil'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: isDark
                                    ? Colors.white10
                                    : Colors.grey[200],
                                side: BorderSide.none,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- About Request Card ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About request',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Service Widget
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: serviceImageView != null
                                    ? DecorationImage(
                                        image: NetworkImage(serviceImageView!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                color: Colors.grey[300],
                              ),
                              child: serviceImageView == null
                                  ? Center(
                                      child: Icon(
                                        Icons.spa,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "Service",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    serviceName,
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    servicePrice,
                                    style: GoogleFonts.inter(
                                      color: Colors.green,
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (resolvedService?['description'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        resolvedService!['description']
                                            .toString(),
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Ver servicio",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Mensaje:",
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lead.requestDescription.isNotEmpty
                            ? lead.requestDescription
                            : "Sin descripción.",
                        style: GoogleFonts.inter(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Presupuesto: ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: "\$${amount.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF111418),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Enviar propuesta"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- Timeline ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111418),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Timeline",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            // Status badge
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.blue[900],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "En progreso",
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTimelineStep(
                        context,
                        "Nuevo lead",
                        lead.createdAt,
                        true,
                        false,
                      ), // Step 1
                      _buildTimelineStep(
                        context,
                        "En revisión",
                        lead.createdAt.add(Duration(minutes: 5)),
                        lead.seen,
                        false,
                      ), // Step 2 (Mock time)
                      _buildTimelineStep(
                        context,
                        "Por agendar",
                        null,
                        lead.clientContacted,
                        true,
                      ), // Step 3
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildManageLeadTile(context, ref, currentLead),
                const SizedBox(height: 20),

                _buildFinancialActivity(context, ref, cardColor, currentLead),
                const SizedBox(height: 20),

                // --- Delete Button ---
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text(
                      "Eliminar Lead",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.red, width: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildManageLeadTile(BuildContext context, WidgetRef ref, Lead lead) {
    // Checks
    final businessData = ref.watch(businessProvider).value;
    final hasMissingDate = lead.bookingMade && lead.proposedBookingDate == null;
    final hasDraftProposals =
        businessData?.quotes.any(
          (q) => q['status'] == 'draft' && q['lead_id'] == lead.id,
        ) ??
        false;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          title: Row(
            children: [
              Icon(Icons.manage_accounts, color: Colors.blue[900]),
              const SizedBox(width: 12),
              Text(
                "Gestionar Cliente Potencial",
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Validation / Missing items
                  if (hasMissingDate || hasDraftProposals) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          if (hasDraftProposals)
                            Row(
                              children: [
                                const Icon(
                                  Icons.warning_amber,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Propuestas en borrador",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ],
                            ),
                          if (hasMissingDate)
                            Row(
                              children: [
                                const Icon(
                                  Icons.event_busy,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Falta definir fecha",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Toggles
                  const Divider(),
                  _buildToggle(
                    context,
                    ref,
                    lead,
                    "Visto por mí",
                    lead.seen,
                    'seen',
                  ),
                  _buildToggle(
                    context,
                    ref,
                    lead,
                    "Cliente Contactado",
                    lead.clientContacted,
                    'client_contacted',
                  ),
                  _buildToggle(
                    context,
                    ref,
                    lead,
                    "Propuesta Enviada",
                    lead.proposalSent,
                    'proposal_sent',
                  ),
                  _buildToggle(
                    context,
                    ref,
                    lead,
                    "Booking Agendado",
                    lead.bookingMade,
                    'booking_made',
                  ),
                  _buildToggle(
                    context,
                    ref,
                    lead,
                    "Pago Realizado",
                    lead.paymentMade,
                    'payment_made',
                  ),

                  const Divider(height: 24),

                  // Propose Appointment
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        // Show Date Picker
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null && context.mounted) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null && context.mounted) {
                            // Call backend to update 'proposed_booking_date'
                            final dateTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );

                            await ref
                                .read(businessProvider.notifier)
                                .updateLeadField(lead.id, {
                                  'proposed_booking_date': dateTime
                                      .toIso8601String(),
                                });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Cita propuesta para ${DateFormat('dd/MM').format(date)} a las ${time.format(context)}",
                                ),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: const Text("Proponer Cita"),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Status Dropdown
                  Text(
                    "Estado del Lead",
                    style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value:
                            [
                              'open',
                              'completed',
                              'cancelled',
                            ].contains(lead.status)
                            ? lead.status
                            : 'open',
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'open',
                            child: Text("Abierto / En Progreso"),
                          ),
                          DropdownMenuItem(
                            value: 'completed',
                            child: Text("Completado"),
                          ),
                          DropdownMenuItem(
                            value: 'cancelled',
                            child: Text("Cancelado"),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            ref.read(businessProvider.notifier).updateLeadField(
                              lead.id,
                              {'status': val},
                            );
                          }
                        },
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
  }

  Widget _buildToggle(
    BuildContext context,
    WidgetRef ref,
    Lead lead,
    String title,
    bool value,
    String field,
  ) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.inter(fontSize: 14)),
      value: value,
      contentPadding: EdgeInsets.zero,
      dense: true,
      activeColor: Colors.blue[900],
      onChanged: (val) {
        ref.read(businessProvider.notifier).updateLeadField(lead.id, {
          field: val,
        });
      },
    );
  }

  Widget _buildFinancialActivity(
    BuildContext context,
    WidgetRef ref,
    Color cardColor,
    Lead lead,
  ) {
    final businessData = ref.watch(businessProvider).value;
    final quotes =
        businessData?.quotes.where((q) {
          final qLeadId = q['lead_id'];
          final qLeads = q['leads'];
          final nestedLeadId = qLeads is Map ? qLeads['id'] : null;
          return qLeadId == lead.id || nestedLeadId == lead.id;
        }).toList() ??
        [];

    // Sort by date descending if created_at exists
    quotes.sort((a, b) {
      final dateA =
          DateTime.tryParse(a['created_at']?.toString() ?? '') ??
          DateTime(2000);
      final dateB =
          DateTime.tryParse(b['created_at']?.toString() ?? '') ??
          DateTime(2000);
      return dateB.compareTo(dateA);
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Actividad Comercial",
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatusRow(
            "Booking",
            lead.bookingMade ? "Agendado" : "Pendiente",
            lead.bookingMade ? Colors.green : Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildStatusRow(
            "Pago",
            lead.paymentMade ? "Pagado" : "Pendiente",
            lead.paymentMade ? Colors.green : Colors.orange,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1),
          ),
          if (!lead.paymentMade)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showPaymentDialog(context, ref, lead),
                  icon: const Icon(Icons.attach_money, size: 18),
                  label: const Text("Registrar Pago"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          Text(
            "Propuestas",
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 12),
          if (quotes.isEmpty)
            Text(
              "No se han enviado propuestas.",
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 13),
            )
          else
            ...quotes.map((q) {
              final status = q['status'] ?? 'Draft';
              final isAccepted = status == 'accepted' || status == 'paid';
              final isCounterOffer = status == 'counter_offer';

              Color statusColor = Colors.blue;
              Color statusBg = Colors.blue.withOpacity(0.1);

              if (isAccepted) {
                statusColor = Colors.green;
                statusBg = Colors.green.withOpacity(0.1);
              } else if (isCounterOffer) {
                statusColor = Colors.deepPurple;
                statusBg = Colors.deepPurple.withOpacity(0.1);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Propuesta #${q['id']}",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${((q['amount_cents'] ?? q['amountCents'] ?? 0) / 100).toStringAsFixed(2)}",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isCounterOffer
                            ? "CONTRA OFERTA"
                            : status.toString().toUpperCase(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildDynamicTimeline(BuildContext context, Lead lead) {
    // Define steps based on Lead status
    final steps = <Map<String, dynamic>>[
      {
        'title': 'Nuevo lead',
        'time': lead.createdAt,
        'isActive': true,
        'isCompleted': true,
      },
      {
        'title': lead.seen ? 'Visto' : 'Por revisar',
        'time': lead.seen
            ? lead.createdAt.add(const Duration(minutes: 5))
            : null, // Mock time or real if available
        'isActive': lead.seen,
        'isCompleted': lead.seen,
      },
      {
        'title': lead.clientContacted ? 'Contactado' : 'Por contactar',
        'time': null,
        'isActive': lead.clientContacted,
        'isCompleted': lead.clientContacted,
      },
      {
        'title': lead.proposalSent ? 'Propuesta Enviada' : 'Enviar Propuesta',
        'time': null,
        'isActive': lead.proposalSent,
        'isCompleted': lead.proposalSent,
      },
      {
        'title': lead.bookingMade ? 'Agendado' : 'Por Agendar',
        'time': null,
        'isActive': lead.bookingMade,
        'isCompleted': lead.bookingMade,
      },
      {
        'title': lead.paymentMade ? 'Pagado' : 'Pendiente de Pago',
        'time': null,
        'isActive': lead.paymentMade,
        'isCompleted': lead.paymentMade,
      },
      if (lead.status == 'completed')
        {
          'title': 'Completado',
          'time': null,
          'isActive': true,
          'isCompleted': true,
        },
      if (lead.status == 'cancelled')
        {
          'title': 'Cancelado',
          'time': null,
          'isActive': true,
          'isCompleted': true,
          'isError': true,
        },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      // ... same decoration logic ...
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, size: 16, color: Colors.blue[900]),
              const SizedBox(width: 8),
              Text(
                "Línea de tiempo",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;
            return _buildTimelineStep(
              context,
              step['title'] as String,
              step['time'] as DateTime?,
              step['isActive'] as bool,
              isLast,
              isError: step['isError'] == true,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    BuildContext context,
    String title,
    DateTime? time,
    bool isActive,
    bool isLast, {
    bool isError = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isError ? Colors.red : Colors.blue;
    final activeBg = isError
        ? Colors.red.withOpacity(0.1)
        : (isDark ? Colors.blue.withOpacity(0.1) : Colors.blue[50]);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                isActive ? Icons.check_circle : Icons.circle_outlined,
                color: isActive ? activeColor : Colors.grey[300],
                size: 20,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isActive ? activeColor : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? activeBg : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isActive ? activeColor : Colors.grey,
                    ),
                  ),
                  if (time != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                color == Colors.green
                    ? Icons.check_circle
                    : Icons.hourglass_empty,
                size: 12,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showPaymentDialog(BuildContext context, WidgetRef ref, Lead lead) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Registrar Pago"),
          content: const Text(
            "¿Confirmas que has recibido el pago por este servicio? Esta acción marcará el lead como PAGADO.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                final success = await ref
                    .read(businessProvider.notifier)
                    .updateLeadField(lead.id, {'payment_made': true});

                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pago registrado exitosamente"),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Confirmar Pago"),
            ),
          ],
        );
      },
    );
  }
}
