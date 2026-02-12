import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connek_frontend/features/leads/models/lead_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/business/presentation/pages/lead_details_page.dart';

class LeadNewxWidget extends ConsumerWidget {
  final Lead lead;
  const LeadNewxWidget({super.key, required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('DEBUG: LeadNewxWidget build. Lead: ${lead.id}');
    // Find service
    final businessData = ref.watch(businessProvider).asData?.value;
    Map<String, dynamic>? service;
    if (businessData != null) {
      try {
        service = businessData.services.firstWhere(
          (s) => s['id'] == lead.serviceId,
          orElse: () => {},
        );
        if (service.isEmpty) service = null;
      } catch (_) {}
    }

    final name = '${lead.clientFirstName} ${lead.clientLastName}'.trim();
    // Use requestBudgetMax if available, else 0
    final amount = (lead.requestBudgetMax ?? 0) / 100.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadDetailsPage(lead: lead, service: service),
          ),
        );
      },
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            // Background Image with Error Handling
            Positioned.fill(
              child: ClipRRect(
                // Clip the image to the container's border radius
                borderRadius: BorderRadius.circular(20),
                child:
                    (lead.clientImageUrl != null &&
                        lead.clientImageUrl!.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: (lead.clientImageUrl!.startsWith('http')
                            ? lead.clientImageUrl!
                            : 'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/client/${lead.clientImageUrl!}'),
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                        errorWidget: (context, url, error) =>
                            _buildFallback(name),
                        placeholder: (context, url) => Container(
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    : _buildFallback(name),
              ),
            ),
            // Tag
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Cliente',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
            // Price
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '\$$amount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Name
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Financial',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ), // Static tag for now
                  Text(
                    name,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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

  Widget _buildFallback(String name) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F2027), // Deep Blue/Black
            Color(0xFF203A43),
            Color(0xFF2C5364), // Blue-ish
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
