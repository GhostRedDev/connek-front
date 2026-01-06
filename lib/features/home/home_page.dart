import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'widgets/home_search_widget.dart';
import 'widgets/mobile_app_bar_widget.dart';
import 'widgets/mobile_nav_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Background Image & Gradient
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2672&auto=format&fit=crop', // Tech/Globe background
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Theme.of(context).scaffoldBackgroundColor),
                errorWidget: (context, url, error) => Container(color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.2), // Adjust opacity as needed
                      Theme.of(context).primaryColor,
                    ],
                    stops: const [0, 1],
                    begin: const AlignmentDirectional(0, -1),
                    end: const AlignmentDirectional(0, 1),
                  ),
                ),
              ),
            ),
            
            // Content
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: HomeSearchWidget(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: const AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        height: 90, // Increased for floating dock
                        decoration: const BoxDecoration(),
                        child: const MobileNavBar2Widget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Top App Bar
            Align(
              alignment: Alignment.topCenter,
              child: MobileAppBarWidget(bgTrans: true),
            ),
          ],
        ),
      ),
    );
  }
}
