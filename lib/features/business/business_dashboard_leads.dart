import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessDashboardLeads extends ConsumerWidget {
  const BusinessDashboardLeads({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text(
        'Business Leads - Coming Soon',
        style: GoogleFonts.inter(fontSize: 18),
      ),
    );
  }
}
