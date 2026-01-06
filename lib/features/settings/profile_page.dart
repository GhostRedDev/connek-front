import 'package:flutter/material.dart';
import '../home/widgets/mobile_app_bar_widget.dart';
import '../home/widgets/mobile_nav_bar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    // Standard layout structure
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D21), // Standard dark background
      body: Stack(
        children: [
          // Main Content
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 100, bottom: 80),
            child: const Center(
              child: Text(
                'User Profile Details',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Bottom Nav Bar
          Align(
            alignment: const AlignmentDirectional(0, 1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: const BoxDecoration(),
                child: const MobileNavBar2Widget(),
              ),
            ),
          ),

          // Top App Bar
          Align(
            alignment: Alignment.topCenter,
            child: MobileAppBarWidget(bgTrans: true),
          ),
        ],
      ),
    );
  }
}
