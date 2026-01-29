import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../client/services/client_requests_service.dart';

import '../models/business_model.dart';

class SearchResultGoogleCard extends ConsumerWidget {
  final Business business;

  const SearchResultGoogleCard({super.key, required this.business});

  bool get isGoogleResult => business.id < 0;

  String _getImageUrl(String? path, String defaultUrl) {
    if (path == null || path.isEmpty) {
      return defaultUrl;
    }
    if (path.startsWith('http')) {
      return path;
    }
    // Assume it's a Supabase storage path for 'business' bucket
    return Supabase.instance.client.storage.from('business').getPublicUrl(path);
  }

  Future<void> _launchMap(BuildContext context, String address) async {
    final query = Uri.encodeComponent(address);
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch map: $e')));
      }
    }
  }

  Future<void> _launchUrlDirect(BuildContext context, String urlString) async {
    final url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch URL: $e')));
      }
    }
  }

  Future<void> _showInviteDialog(BuildContext context, WidgetRef ref) async {
    final messageController = TextEditingController(
      text: 'Hola, me interesa saber más sobre sus servicios.',
    );
    final isLoading = ValueNotifier<bool>(false);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Contactar a ${business.name}',
          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Envía un mensaje para conectar con este negocio.',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              return ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        isLoading.value = true;
                        try {
                          final user = ref.read(currentUserProvider);

                          if (user == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Debes iniciar sesión para conectar.',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                            return;
                          }

                          // Fetch client ID manually since we don't have a global client provider exposed here
                          // Optimally this should be cached, but for this action it's acceptable.
                          int? clientId;
                          try {
                            final clientRes = await Supabase.instance.client
                                .from('clients')
                                .select('id')
                                .eq('user_id', user.id)
                                .maybeSingle(); // Use maybeSingle to avoid crash if not found

                            if (clientRes != null) {
                              clientId = clientRes['id'];
                            }
                          } catch (e) {
                            print('Error fetching client: $e');
                          }

                          if (clientId == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error: No se encontró perfil de cliente.',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                            return;
                          }

                          final success = await ref
                              .read(clientRequestsServiceProvider)
                              .createRequest({
                                'client_id': clientId,
                                'business_id': business.id,
                                'description':
                                    messageController.text.trim().isNotEmpty
                                    ? messageController.text.trim()
                                    : 'Solicitud de contacto',
                                'is_direct': true,
                              });

                          if (context.mounted) {
                            Navigator.pop(context);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    '¡Solicitud enviada con éxito!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // We could navigate to requests tab or chat here
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error al enviar solicitud. Intenta de nuevo.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        } finally {
                          isLoading.value = false;
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F87C9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (isGoogleResult) {
          if (business.url != null && business.url!.isNotEmpty) {
            _launchUrlDirect(context, business.url!);
          } else {
            _launchMap(context, business.description);
          }
        } else {
          context.push('/business/${business.id}');
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                _getImageUrl(
                  business.bannerImage,
                  'https://images.unsplash.com/photo-1600607686527-6fb886090705?q=80&w=2727&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://images.unsplash.com/photo-1600607686527-6fb886090705?q=80&w=2727&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 313,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF95A1AC).withOpacity(0.4)
                      : Colors.grey.shade300, // Adapting border color
                  width: 7,
                ),
                gradient: const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFF212121),
                  ], // Keep dark for text legibility
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Badges
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating Badge (Hide for Google results if data missing, but let's assume we want consistency)
                        if (!isGoogleResult ||
                            business.category != null) // Conditional check
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFF59D),
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '5.0', // Placeholder, API doesn't seem to have rating yet
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Spacer(),
                        // Google Badge or Website Badge
                        if (isGoogleResult)
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                // UPDATED: Replaced Icon with Google SVG Logo
                                SvgPicture.asset(
                                  'assets/images/google-logo-icon.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Google',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (business.website != null)
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Website',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    // Bottom Info
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Profile Row
                        Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  _getImageUrl(
                                    business.profileImage,
                                    'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=2144&auto=format&fit=crop',
                                  ),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=2144&auto=format&fit=crop',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                business.name,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Description / Address
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            business
                                .description, // Often contains address for Google
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF95A1AC),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Action Button & Warning
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 47,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (isGoogleResult) {
                                    _launchMap(context, business.description);
                                  } else {
                                    // Use new dialog logic
                                    _showInviteDialog(context, ref);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isGoogleResult
                                      ? Colors.white
                                      : const Color(
                                          0xFF4F87C9,
                                        ), // White for Google, Blue for Connek
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  isGoogleResult
                                      ? (t['search_view_map'] ?? 'Ver en Mapa')
                                      : (t['search_invite_connek'] ??
                                            'Solicitar / Invitar'), // Changed to 'Ver Perfil' as we are navigating to it
                                  style: GoogleFonts.outfit(
                                    color: isGoogleResult
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (isGoogleResult)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.info_outline,
                                    color: Color(0xFF9FC7FF),
                                    size: 21,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    t['search_google_source'] ??
                                        'Resultado de Google Places',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF9F9F9F),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons
                                        .verified, // Changed to verified icon for Connek
                                    color: Color(0xFF4F87C9),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    t['search_verified_connek'] ??
                                        'Verificado por Connek', // Positive msg
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF9F9F9F),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
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
