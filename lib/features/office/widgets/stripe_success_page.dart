import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/greg_provider.dart';
import '../../settings/providers/profile_provider.dart';

class StripeSuccessPage extends ConsumerStatefulWidget {
  const StripeSuccessPage({super.key});

  @override
  ConsumerState<StripeSuccessPage> createState() => _StripeSuccessPageState();
}

class _StripeSuccessPageState extends ConsumerState<StripeSuccessPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshGregStatus();
  }

  Future<void> _refreshGregStatus() async {
    // 1. Get current business ID from profile/supabase
    final userProfile = ref.read(profileProvider).value;
    int? businessId;

    if (userProfile != null) {
      final client = Supabase.instance.client;
      final businessData = await client
          .from('business')
          .select('id')
          .eq('owner_client_id', userProfile.id)
          .maybeSingle();

      if (businessData != null) {
        businessId = businessData['id'] as int;
      }
    }

    if (businessId != null) {
      debugPrint(
        '🔄 StripeSuccess: Refreshing Greg data for business $businessId',
      );
      // Force reload to get latest status (active=true)
      await ref.read(gregProvider.notifier).loadGreg(businessId);
    } else {
      debugPrint('⚠️ StripeSuccess: Could not identify business ID to refresh');
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131619),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _isLoading
              ? const CircularProgressIndicator(color: Color(0xFF249689))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Success Icon
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF249689).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: Color(0xFF249689),
                      ),
                    ),
                    const SizedBox(height: 32),

                    Text(
                      '¡Suscripción Activada!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'El pago se ha procesado correctamente. Greg ahora está activo y listo para trabajar.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to Greg Setting or Office
                          context.go('/office/settings-greg');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B39EF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Volver a Configuración',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
