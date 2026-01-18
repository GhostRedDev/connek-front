import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultReelCard extends StatelessWidget {
  final String title; // Usually Price or Name
  final String subtitle; // Category or additional info
  final String rating;
  final String imageUrl;
  final String profileImageUrl;

  const SearchResultReelCard({
    super.key,
    this.title = '\$40/H',
    this.subtitle = 'PRECIO',
    this.rating = '5.0',
    this.imageUrl =
        'https://images.unsplash.com/photo-1581578731117-104f2a41272c?q=80&w=2546&auto=format&fit=crop', // Interior design placeholder
    this.profileImageUrl =
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=2864&auto=format&fit=crop', // Profile placeholder
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D21), // generic dark bg
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: imageUrl.startsWith('http')
              ? NetworkImage(imageUrl)
              : const AssetImage('assets/images/placeholder_service.png')
                    as ImageProvider, // Fallback for dev
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Colors.transparent, Color(0xFF212121)],
            stops: [0.5, 1], // Adjusted stops for better visibility
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
              // Rating Badge
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1D21).withOpacity(
                            0.5,
                          ), // Validated neutralAlpha50 approximation
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10,
                            5,
                            10,
                            5,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFFFF59D), // yellow200
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                rating,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom Details
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Text Info
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9F9F9F),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              color: const Color(0xFF9FC7FF),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // Profile Image
                      Container(
                        width: 30,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          profileImageUrl,
                          fit: BoxFit.cover,
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
    );
  }
}
