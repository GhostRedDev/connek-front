import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/providers/locale_provider.dart';

class SearchResultGoogleCard extends ConsumerWidget {
  const SearchResultGoogleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Container(
      width: double.infinity,
      height: 313,
      decoration: BoxDecoration(
        color: const Color(
          0xFF1A1D21,
        ).withOpacity(0.1), // secondaryAlpha10 approximation
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://images.unsplash.com/photo-1600607686527-6fb886090705?q=80&w=2727&auto=format&fit=crop', // Interior design placeholder
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF95A1AC).withOpacity(0.4), // secondaryAlpha40
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
                  // Rating Badge
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.6,
                      ), // Simpler, performant opacity
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFF59D),
                          size: 20,
                        ), // yellow200
                        const SizedBox(width: 5),
                        Text(
                          '5.0',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Website Badge
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.6,
                      ), // Simpler, performant opacity
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 20,
                        ), // workspaces replacement
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=2144&auto=format&fit=crop',
                            ), // Profile placeholder
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'AR Labs & Vision',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Contact Details
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 21,
                          ), // kcall replacement
                          const SizedBox(width: 5),
                          Text(
                            '+58 4242885054',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: Colors.white,
                            size: 21,
                          ), // kmail replacement
                          const SizedBox(width: 5),
                          Text(
                            'info@arlabs.agency',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                            print('Invite pressed');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF4F87C9,
                            ), // primary200 (Blue from older context)
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            t['search_invite_connek'] ?? 'Invitar a Connek',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFF9FC7FF),
                            size: 21,
                          ), // exclamationCircle
                          const SizedBox(width: 5),
                          Text(
                            t['search_not_available'] ??
                                'No esta disponible en Connek',
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
    );
  }
}
