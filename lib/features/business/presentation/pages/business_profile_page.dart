import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/admin/business_profile_widget.dart';

class BusinessProfilePage extends ConsumerWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If we want the full profile widget:
    return const BusinessProfileWidget();
  }
}
