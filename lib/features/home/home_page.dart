import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../search/widgets/home_search_widget.dart';
import '../auth/widgets/home_page_bottom_information_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animation for the Guest Background
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session = snapshot.data?.session;
          final bool isLoggedIn = session != null;

          return Scaffold(
            backgroundColor:
                Colors.transparent, // Shell handles background color if needed
            body: Stack(
              children: [
                // 1. Background (Varies by state)
                if (isLoggedIn)
                  _buildAuthBackground(context)
                else
                  _buildGuestBackground(),

                // 2. Content
                SafeArea(
                  child: isLoggedIn
                      ? _buildAuthContent()
                      : _buildGuestContent(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- Backgrounds ---

  // --- Backgrounds ---

  Widget _buildAuthBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!isDark) {
      // Light Mode Background: Clean White/Grey with subtle gradient
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          gradient: LinearGradient(
            colors: [Colors.white, Theme.of(context).scaffoldBackgroundColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
    }

    // Dark Mode Background: Space Image
    return Stack(
      children: [
        SizedBox.expand(
          child: CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2672&auto=format&fit=crop',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: const Color(0xFF131619)),
            errorWidget: (context, url, error) =>
                Container(color: const Color(0xFF131619)),
          ),
        ),
        // Static Overlay for Auth
        SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).primaryColor,
                ],
                stops: const [0, 1],
                begin: const AlignmentDirectional(0, -1),
                end: const AlignmentDirectional(0, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestBackground() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Light Mode Guest Background
    if (!isDark) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F7FA),
          gradient: LinearGradient(
            colors: [Color(0xFFE0E0E0), Color(0xFFF5F7FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    }

    return Stack(
      children: [
        SizedBox.expand(
          child: CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2672&auto=format&fit=crop',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: const Color(0xFF1A2342)),
            errorWidget: (context, url, error) =>
                Container(color: const Color(0xFF1A2342)),
          ),
        ),
        // Animated Overlay for Guest
        SizedBox.expand(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1A2342).withOpacity(0.9), // Dark Blue
                      const Color(0xFF4285F4).withOpacity(0.9), // Lighter Blue
                    ],
                    stops: const [0, 1],
                    // Animate alignment
                    begin: Alignment.topLeft.add(
                      Alignment(0.5 * sin(_controller.value * 2 * pi), 0),
                    ),
                    end: Alignment.bottomRight.add(
                      Alignment(0.5 * cos(_controller.value * 2 * pi), 0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Content ---

  Widget _buildAuthContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 120), // Spacer to clear Top App Bar
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const HomeSearchWidget(),
            ),
          ),
        ),
        const SizedBox(height: 80), // Spacer for Bottom Nav Bar balance
      ],
    );
  }

  Widget _buildGuestContent() {
    final session = Supabase.instance.client.auth.currentSession;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 80), // Spacer for AppBar

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: const HomeSearchWidget()),
          ),
        ),
        const HomePageBottomInformationWidget(),
      ],
    );
  }
}
