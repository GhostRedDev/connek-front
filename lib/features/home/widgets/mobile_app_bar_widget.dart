import 'dart:ui';
import 'package:flutter/material.dart';
import 'search_bar_widget.dart';
import 'login_dropdown_button.dart';

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
    return Align(
      alignment: const AlignmentDirectional(0, -1),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 16,
              sigmaY: 16,
            ),
            child: Container(
              width: double.infinity,
              height: 80, 
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7), // Pure Black, semi-transparent
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.1), // Subtle separator
                    width: 0.5,
                  )
                )
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // LOGO (Left Side)
                      Image.asset(
                        'assets/images/conneck_logo_white.png',
                        height: 28,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Text(
                          'connek',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
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
                                debugPrint('Search for: $val');
                              },
                            ),
                          ),
                        ),

                      // RIGHT ICONS (Simple, minimal)
                      if (!enableSearch) ...[
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 26),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                      ],
                      
                       // User/Profile Button
                       const LoginDropdownButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
