import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/mobile_app_bar_widget.dart';
import 'widgets/mobile_nav_bar_widget.dart'; // Contains MobileNavBar2Widget
import 'widgets/search_result_google_widget.dart';

class SearchPage extends StatefulWidget {
  final String? prompt;

  const SearchPage({super.key, this.prompt});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _currentPrompt = '';

  void _performSearch(String query) {
    setState(() {
      _currentPrompt = query;
    });
    // In a real app, this would trigger an API call or filter a list
    print('Searching for: $_currentPrompt');
  }

  @override
  void initState() {
    super.initState();
    if (widget.prompt != null) {
      _currentPrompt = widget.prompt!;
    }
    
    // Simulating "normalSearch" action block
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Logic to trigger initial search if prompt exists
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D21), // bg1Sec
        body: Stack(
          children: [
            // Main Content (Search Grid or Google Widget)
            // Using SearchResultGoogleWidget as the main view as requested by latest context
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1D21), // secondaryBackground
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 100, bottom: 80), // Space for headers/nav
                child: SearchResultGoogleWidget(
                  // We can pass the search callback down if we modify SearchResultGoogleWidget
                  // For now, it has its own internal search bar which we should likely lift up or sync
                ),
              ),
            ),
            
            // Bottom Nav Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 67,
                  child: const MobileNavBar2Widget(),
                ),
              ),
            ),

            // Top App Bar with Blur
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: double.infinity,
                    height: 90, // Adjusted height
                    color: const Color(0xFF1A1D21).withOpacity(0.8), // navBg with transparency
                    alignment: Alignment.center,
                    child: SafeArea(
                      bottom: false,
                      child: MobileAppBarWidget(
                        enableSearch: false, // Use body search bar instead
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
