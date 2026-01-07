import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/widgets/mobile_app_bar_widget.dart';
import '../../features/home/widgets/mobile_nav_bar_widget.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we are on the Home screen to determine transparency (bgTrans)
    // GoRouterState is accessible via context if needed, but for simplicity we rely on the logic 
    // passed to MobileAppBarWidget later or just default behavior.
    
    // Actually, MobileAppBarWidget needs to know if it should be transparent.
    // We can infer this from the current location.
    final String location = GoRouterState.of(context).uri.toString();
    final bool isHome = location == '/home';

    return Scaffold(
      backgroundColor: const Color(0xFF131619), // Dark layout background
      extendBodyBehindAppBar: true, // Allow body to go behind transparent AppBar
      extendBody: true, // Allow body to go behind transparent NavBar
      body: Stack(
        children: [
          // 1. The Main Content (Child)
          child,
          
          // 2. The AppBar (Top)
          MobileAppBarWidget(
            bgTrans: isHome, // Only transparent on Home
            enableSearch: false, // Default false, SearchPage handles its own or we can toggle
          ),

          // 3. The NavBar (Bottom)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MobileNavBar2Widget(),
          ),
        ],
      ),
    );
  }
}
