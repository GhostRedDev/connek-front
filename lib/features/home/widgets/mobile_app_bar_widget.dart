import 'dart:ui';
import 'package:flutter/material.dart';
import 'search_bar_widget.dart';
import 'login_dropdown_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MobileAppBarWidget extends StatelessWidget {
  final bool bgTrans;
  final bool enableSearch;

  const MobileAppBarWidget({
    super.key,
    this.bgTrans = false,
    this.enableSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    // Theme Data
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Premium Gradient (Dynamic)
    final premiumGradient = LinearGradient(
       colors: isDark ? [
         const Color(0xFF1A1D21).withOpacity(0.95), 
         const Color(0xFF252A34).withOpacity(0.90), 
       ] : [
         Colors.white.withOpacity(0.95),
         const Color(0xFFF5F7FA).withOpacity(0.90),
       ],
       begin: Alignment.topCenter,
       end: Alignment.bottomCenter,
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: bgTrans ? 0 : 30, 
            sigmaY: bgTrans ? 0 : 30,
          ),
          child: Container(
            width: double.infinity,
            height: 120, // Increased height
            decoration: BoxDecoration(
              // If bgTrans (Home), use transparent. Else, use premium gradient.
              gradient: bgTrans ? null : premiumGradient,
              color: bgTrans ? Colors.transparent : null,
              border: bgTrans ? null : Border(
                bottom: BorderSide(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // LOGO (Left Side) - Switch based on Theme
                    Image.asset(
                      isDark ? 'assets/images/conneck_logo_white.png' : 'assets/images/conneck_logo_dark.png',
                      height: 32, 
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Text(
                        'connek',
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF1A1D21),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    
                    const Spacer(),

                    // Middle Search (Only if enabled)
                    if (enableSearch)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SearchBarWidget(
                            onSubmitted: (val) {
                              print('Search for: $val');
                            },
                          ),
                        ),
                      ),

                    // RIGHT ICONS (Chat, Bell, Profile)
                    // Encapsulated in glass bubbles for premium feel
                    if (!enableSearch) ...[
                      // ICONS ROW (Chat, Notifications) - Only if Logged In
                      if (Supabase.instance.client.auth.currentSession != null) ...[
                        // Chat Icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 48, 
                              height: 48,
                              decoration: BoxDecoration(
                                color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05), 
                                  width: 1
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.chat_bubble_outline_rounded, 
                                  color: isDark ? Colors.white : const Color(0xFF1A1D21), 
                                  size: 24),
                                onPressed: () => print('Go to chats'), 
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Notification Icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 48, 
                              height: 48,
                              decoration: BoxDecoration(
                                 color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                                 shape: BoxShape.circle,
                                 border: Border.all(
                                   color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05), 
                                   width: 1
                                  ),
                              ),
                               child: IconButton(
                                icon: Icon(Icons.notifications_none_rounded, 
                                  color: isDark ? Colors.white : const Color(0xFF1A1D21), 
                                  size: 24),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ],
                    
                     // User/Profile Button (Circular)
                     const LoginDropdownButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
