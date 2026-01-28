import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/business_provider.dart';
import '../../settings/providers/profile_provider.dart';

final businessPaymentMethodsProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
      final business = ref.watch(businessProvider).value;
      final profile = ref.watch(profileProvider).value;

      if (business == null ||
          business.businessProfile == null ||
          profile == null)
        return [];

      final repo = ref.read(businessRepositoryProvider);
      // Assuming profile.id is the client_id required.
      return repo.getPaymentMethodsForBusiness(
        business.businessProfile!['id'],
        profile.id,
      );
    });

class BusinessWalletWidget extends ConsumerWidget {
  const BusinessWalletWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodsAsync = ref.watch(businessPaymentMethodsProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Métodos de Pago',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          methodsAsync.when(
            data: (methods) {
              if (methods.isEmpty) {
                return _buildEmptyState(context);
              }
              // Show first card or list
              // User requested "si hay un tarjeta agregada se vea asi" (like the image)
              final card = methods.first;
              return Center(child: _GlassCreditCard(cardData: card));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err'),
          ),

          const SizedBox(height: 32),
          // Recent Transactions Header
          Text(
            'Movimientos Recientes',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTransactionsList(context),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.credit_card_off, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              "No hay tarjetas agregadas",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Mock
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.1),
              child: Icon(Icons.arrow_downward, color: Colors.green),
            ),
            title: Text('Pago de Factura #100${index + 1}'),
            subtitle: Text('25 Ene 2026'),
            trailing: Text(
              '+\$150.00',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GlassCreditCard extends StatelessWidget {
  final Map<String, dynamic> cardData;

  const _GlassCreditCard({required this.cardData});

  @override
  Widget build(BuildContext context) {
    // Parse Data
    final brand = (cardData['brand'] ?? 'mastercard').toString().toLowerCase();
    final last4 = cardData['last4'] ?? '0000';
    final expMonth = cardData['exp_month'] ?? '00';
    final expYear = cardData['exp_year'] ?? '00';
    // Format Expiry
    final expiry =
        '${expMonth.toString().padLeft(2, '0')}/${expYear.toString().substring(2)}';

    // Determine Brand Icon/Color
    IconData brandIcon = Icons.credit_card;
    if (brand.contains('visa')) {
      brandIcon = Icons.payment; // Placeholder for Visa Logo
    } else if (brand.contains('master')) {
      // Mastercard handled by specific UI below
    } else if (brand.contains('amex')) {
      // Amex handled by specific UI or default
    }

    return SizedBox(
      height: 220,
      width: 360, // Standard card ratio roughly
      child: Stack(
        children: [
          // Background Elements (Blobs) for transparency effect
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.5),
              ),
            ),
          ),

          // Glass Card
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.1,
                  ), // Glassy white/transparent
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Row: Brand & Chip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Chip Icon
                        Icon(
                          Icons.sim_card,
                          color: Colors.amberAccent.withOpacity(0.8),
                          size: 32,
                        ),

                        // Brand Logo (Simulated)
                        Row(
                          children: [
                            if (brand.contains('master')) ...[
                              // Mastercard Circles
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-10, 0),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ] else if (brand.contains('visa')) ...[
                              Text(
                                'VISA',
                                style: GoogleFonts.kanit(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ] else ...[
                              Icon(brandIcon, color: Colors.white, size: 32),
                            ],
                          ],
                        ),
                      ],
                    ),

                    // Card Number
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        "**** **** **** $last4",
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 22,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Bottom Row: Name & Expiry
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CARD HOLDER",
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "USER NAME",
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // We don't have Card Holder Name in DB usually, use static or fetch from profile if desired
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "VALID THRU",
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.white54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              expiry,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
