import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/office_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/greg_provider.dart';
import '../settings/providers/profile_provider.dart';
import 'widgets/office_menu_widget.dart';
import 'widgets/office_my_bots_widget.dart';
import 'widgets/office_marketplace_widget.dart';

class OfficePage extends ConsumerStatefulWidget {
  const OfficePage({super.key});

  @override
  ConsumerState<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends ConsumerState<OfficePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final userProfile = await ref.read(profileProvider.future);
      if (userProfile == null) return;

      final client = Supabase.instance.client;
      final businessData = await client
          .from('business')
          .select('id')
          .eq('owner_client_id', userProfile.id)
          .maybeSingle();

      if (businessData != null) {
        final bId = businessData['id'] as int;
        if (mounted) {
          // Use try/catch to avoid errors if provider is disposed
          try {
            await ref.read(gregProvider.notifier).loadGreg(bId);
          } catch (e) {
            debugPrint('Error loading Greg: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('Error in OfficePage _loadData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF131619);
    final selectedIndex = ref.watch(officeSelectedIndexProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 115,
              ), // Increased to clear the taller Glass Header (125px)
              // TOP MENU
              OfficeMenuWidget(
                selectedIndex: selectedIndex,
                onTabSelected: (index) {
                  ref
                      .read(officeSelectedIndexProvider.notifier)
                      .updateIndex(index);
                },
              ),

              // CONTENT AREA
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    // Index 0: My Bots
                    const OfficeMyBotsWidget(),

                    // Index 1: Marketplace
                    const OfficeMarketplaceWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
