import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../leads/business_leads_widget.dart';

class BusinessDashboardLeads extends ConsumerWidget {
  const BusinessDashboardLeads({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Colors.transparent, // Let parent background show
      body: BusinessLeadsWidget(),
    );
  }
}
