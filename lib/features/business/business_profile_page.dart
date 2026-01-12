import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/locale_provider.dart';

class BusinessProfilePage extends ConsumerWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(t['business_profile_title'] ?? 'Business Profile'),
      ),
      body: Center(
        child: Text(t['business_profile_title'] ?? 'Business Content'),
      ),
    );
  }
}
