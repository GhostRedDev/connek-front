import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/office_menu_widget.dart';
import 'widgets/office_my_bots_widget.dart';
import 'widgets/office_marketplace_widget.dart';

class OfficePage extends ConsumerStatefulWidget {
  const OfficePage({super.key});

  @override
  ConsumerState<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends ConsumerState<OfficePage> {
  int _selectedIndex = 0; // 0: My Bots, 1: Marketplace

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF131619);

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
                selectedIndex: _selectedIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),

              // CONTENT AREA
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
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
