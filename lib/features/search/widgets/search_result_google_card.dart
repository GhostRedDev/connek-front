import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<void> _copyInviteToConnek(BuildContext context) async {
    final inviteText =
        'Hola ${business.name}, te invito a unirte a Connek para que más clientes puedan encontrarte y contactarte. '
        'Si quieres registrarte, busca "Connek" en tu tienda de apps o contáctanos en support@connek.com.';

    await Clipboard.setData(ClipboardData(text: inviteText));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invitación copiada al portapapeles')),
      );
    }
  }

  Future<void> _showInviteDialog(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> t,
  ) async {
    final messageController = TextEditingController(
      text:
          t['contact_interest_message'] ??
          'Hola, me interesa saber más sobre sus servicios.',
    );
    final isLoading = ValueNotifier<bool>(false);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          (t['contact_business_title'] ?? 'Contactar a {businessName}')
              .replaceAll('{businessName}', business.name),
          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t['contact_business_subtitle'] ??
                  'Envía un mensaje para conectar con este negocio.',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: t['contact_message_hint'] ?? 'Escribe tu mensaje...',
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
            child: Text(t['cancel'] ?? 'Cancelar'),
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
                                SnackBar(
                                  content: Text(
                                    t['contact_login_required'] ??
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
                            debugPrint('Error fetching client: $e');
                          }

                          if (clientId == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    t['contact_error_no_profile'] ??
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
                                    : (t['contact_default_description'] ??
                                          'Solicitud de contacto'),
                                'is_direct': true,
                              });

                          if (context.mounted) {
                            Navigator.pop(context);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    t['contact_success'] ??
                                        '¡Solicitud enviada con éxito!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // We could navigate to requests tab or chat here
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    t['contact_error_send'] ??
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
                    : Text(
                        t['send'] ?? 'Enviar',
                        style: const TextStyle(color: Colors.white),
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
          context.push('/client/business/${business.id}');
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                _getImageUrl(
                  (business.services.isNotEmpty &&
                          business.services.first.image != null &&
                          business.services.first.image!.isNotEmpty)
                      ? business.services.first.image
                      : business.bannerImage,
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
                      ? const Color(0xFF95A1AC).withAlpha(102)
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
                    // Service Badge (NEW)
                    if (business.category == 'Service Result') ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF6C63FF,
                          ), // Indigo/Purple for Services
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withAlpha(102),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.spa, // Service/Wellness icon
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              t['search_badge_service'] ?? 'Servicio',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8), // Spacing if next badge exists
                    ],

                    // Top Badges Row
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating Badge (Hide if it's a Service Result to avoid clutter)
                        if ((!isGoogleResult || business.category != null) &&
                            business.category != 'Service Result')
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(153),
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
                                  '5.0', // Placeholder
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          const Spacer(), // Spacer to push right badges if left badge is missing
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
                              color: Colors.black.withAlpha(153),
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

                    const Spacer(),

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
                            if (isGoogleResult)
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 47,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _launchMap(
                                          context,
                                          business.description,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                          color: Color(0xFFE0E3E7),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        t['search_view_map'] ?? 'Ver en Mapa',
                                        style: GoogleFonts.outfit(
                                          color: const Color(0xFF14181B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 47,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _copyInviteToConnek(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF4F87C9,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: Text(
                                        t['search_invite_connek'] ??
                                            'Invitar a Connek',
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  // Conversar Button
                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _showInviteDialog(context, ref, t);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF4F87C9,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                          ),
                                          elevation: 2,
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Text(
                                          'Conversar',
                                          style: GoogleFonts.outfit(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Ver Perfil Button
                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          context.push(
                                            '/client/business/${business.id}',
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: const Color(
                                              0xFF4F87C9,
                                            ).withAlpha(128),
                                            width: 1.5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Text(
                                          'Ver Perfil',
                                          style: GoogleFonts.outfit(
                                            color: const Color(0xFF4F87C9),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (isGoogleResult) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 14,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    t['search_google_source'] ??
                                        'Resultado de Google Places',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: Colors.grey[400],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    size: 14,
                                    color: Color(0xFF4F87C9),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    t['search_verified_connek'] ??
                                        'Verificado por Connek',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: const Color(0xFF4F87C9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
