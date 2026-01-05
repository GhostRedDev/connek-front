import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../home/widgets/home_search_widget.dart';
import 'widgets/home_page_bottom_information_widget.dart';
import 'widgets/no_auth_bar_widget.dart';
import 'dart:math';

class HomePageNoAuth extends StatefulWidget {
  const HomePageNoAuth({super.key});

  @override
  State<HomePageNoAuth> createState() => _HomePageNoAuthState();
}

class _HomePageNoAuthState extends State<HomePageNoAuth> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
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
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2672&auto=format&fit=crop', // Tech/Globe background
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: const Color(0xFF1A2342)),
                errorWidget: (context, url, error) => Container(color: const Color(0xFF1A2342)),
              ),
            ),
            // Gradient Overlay
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
                        // Animate alignment to create movement
                        begin: Alignment.topLeft.add(Alignment(
                          0.5 * sin(_controller.value * 2 * pi),
                          0,
                        )),
                        end: Alignment.bottomRight.add(Alignment(
                          0.5 * cos(_controller.value * 2 * pi),
                          0,
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Content
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NoAuthBarWidget(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Center(child: HomeSearchWidget()),
                    ),
                  ),
                  HomePageBottomInformationWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
