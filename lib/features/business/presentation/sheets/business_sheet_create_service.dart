import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'business_service_sheet.dart';

class BusinessSheetCreateService extends StatelessWidget {
  const BusinessSheetCreateService({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    final Map<String, dynamic>? serviceToEdit = (extra is Map<String, dynamic>?)
        ? extra
        : null;

    return Scaffold(
      backgroundColor: Colors.transparent, // Or handle in widget
      body: BusinessServiceSheet(
        serviceToEdit: serviceToEdit,
      ), // Pass edit data
    );
  }
}
