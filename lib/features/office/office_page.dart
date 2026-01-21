import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/office_provider.dart';
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
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
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
