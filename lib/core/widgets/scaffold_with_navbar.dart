import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    // Determine if we are on the home screen to control transparency
    final String location = GoRouterState.of(context).uri.toString();
    // Default to handling transparency based on location, but MobileAppBarWidget checks this too via bgTrans?
    // MobileAppBarWidget has 'bgTrans' property. logic was "gradient: bgTrans ? null : premiumGradient".
    // We should pass true if we are on the unified Home.
    // Since we are unifying routes, let's assume '/' is Home.
    final bool isHome = location == '/';
    // Fallback: Check current synchronous session if stream hasn't emitted
    final initialSession = Supabase.instance.client.auth.currentSession;

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      initialData: initialSession != null 
          ? AuthState(AuthChangeEvent.signedIn, initialSession) 
          : null, // Initial null if no session
      builder: (context, snapshot) {
        // Prioritize stream data, fallback to sync session (logic handled by initialData usually, but let's be safe)
        final session = snapshot.data?.session;
        final bool isLoggedIn = session != null;
        debugPrint('ScaffoldWithNavBar: snapshot.hasData=${snapshot.hasData}, session=$session, isLoggedIn=$isLoggedIn');

        return Scaffold(
          backgroundColor: const Color(0xFF131619),
          extendBodyBehindAppBar: true, 
          extendBody: true, 
          body: Stack(
            children: [
              // 1. Main Content 
              child,
              
              // 2. AppBar (Always visible, handles its own Auth/NoAuth presentation internally if needed, 
              // but physically it's always there. MobileAppBarWidget uses LoginDropdownButton which is reactive.)
              MobileAppBarWidget(
                bgTrans: isHome, 
                enableSearch: false,
              ),

              // 3. NavBar (ONLY if Logged In)
              if (isLoggedIn)
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
    );
  }
}
