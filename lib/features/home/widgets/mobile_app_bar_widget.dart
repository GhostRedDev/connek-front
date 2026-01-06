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
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              width: double.infinity,
              height: 80, // Fixed height as per user request
              decoration: BoxDecoration(
                color: (bgTrans ? Colors.transparent : Theme.of(context).primaryColor)
                    .withOpacity(0.8), // Apply opacity for blur effect
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
                        height: 30,
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
                                print('Search for: $val');
                              },
                            ),
                          ),
                        ),

                      // RIGHT ICONS (Chat, Bell, Profile)
                      if (!enableSearch) ...[
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 26),
                          onPressed: () {
                             // Context push to chats
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                          onPressed: () {
                             // Show notifications
                          },
                        ),
                        const SizedBox(width: 8),
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
      ),
    );
  }
}
