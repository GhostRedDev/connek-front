import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/locale_provider.dart';

import '../models/business_model.dart';

class SearchResultGoogleCard extends ConsumerWidget {
  final Business business;

  const SearchResultGoogleCard({super.key, required this.business});

  bool get isGoogleResult => business.id < 0;

  Future<void> _launchMap(BuildContext context, String address) async {
    final query = Uri.encodeComponent(address);
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch map: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return GestureDetector(
      onTap: () {
        if (isGoogleResult) {
           _launchMap(context, business.description); // Description often contains address for Google results
        } else {
           context.push('/business/${business.id}');
        }
      },
      child: Container(
        width: double.infinity,
        height: 313,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D21).withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              business.bannerImage ?? 'https://images.unsplash.com/photo-1600607686527-6fb886090705?q=80&w=2727&auto=format&fit=crop', 
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFF95A1AC).withOpacity(0.4),
              width: 7,
            ),
            gradient: const LinearGradient(
              colors: [Colors.transparent, Color(0xFF212121)],
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
                    if (!isGoogleResult || business.category != null) // Conditional check
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
                             // Google G Icon (approximated with text/icon here)
                             const Icon(Icons.g_mobiledata, color: Colors.blue, size: 24),
                             const SizedBox(width: 4),
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                business.profileImage ??
                                    'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=2144&auto=format&fit=crop',
                              ),
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
                         business.description, // Often contains address for Google
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
                                   context.push('/business/${business.id}');
                                }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isGoogleResult 
                                  ? Colors.white 
                                  : const Color(0xFF4F87C9), // White for Google, Blue for Connek
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isGoogleResult 
                                  ? (t['search_view_map'] ?? 'Ver en Mapa')
                                  : (t['search_invite_connek'] ?? 'Ver Perfil'), // Changed to 'Ver Perfil' as we are navigating to it
                              style: GoogleFonts.outfit(
                                color: isGoogleResult ? Colors.black : Colors.white,
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
                                t['search_google_source'] ?? 'Resultado de Google Places',
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
                                Icons.verified, // Changed to verified icon for Connek
                                color: Color(0xFF4F87C9),
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                t['search_verified_connek'] ?? 'Verificado por Connek', // Positive msg
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
    );
  }
}
