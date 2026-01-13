import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/providers/locale_provider.dart';
import '../settings/providers/profile_provider.dart';

// Dashboard Views
import 'client_dashboard_orders.dart';
import '../office/widgets/office_marketplace_widget.dart'; // Reusing marketplace
import 'client_dashboard_bookmarks.dart'; // Treating bookmarks as "Resumen" or part of it for now

class ClientPage extends ConsumerWidget {
  const ClientPage({super.key});

  Widget _buildTab(BuildContext context, {required String text}) {
    return Tab(
      height: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(profileProvider);

    return DefaultTabController(
      length: 3, // Resumen, Mercado, Ordenes
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          leadingWidth: 0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              height: 32,
              child: isDark
                  ? Image.asset(
                      'assets/images/conneck_logo_white.png',
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      'assets/images/conneck_logo_dark.png',
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          actions: [
            // Chat Icon
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, size: 24),
              onPressed: () {}, // Chat navigation
            ),
            // Notification Icon with Badge
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, size: 24),
                  onPressed: () {}, // Notifications navigation
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '37', // Mock badge count
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            // User Avatar
            profileAsync.when(
              loading: () =>
                  const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
              error: (_, __) =>
                  const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
              data: (profile) => CircleAvatar(
                radius: 18,
                backgroundImage: profile?.photoId != null
                    ? CachedNetworkImageProvider(profile!.photoId!)
                    : null,
                child: profile?.photoId == null
                    ? const Icon(Icons.person, size: 20)
                    : null,
              ),
            ),
            const SizedBox(width: 16),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: TabBar(
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorWeight: 0,
                indicator: BoxDecoration(
                  color: const Color(0xFF4B39EF), // Primary Color
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
                dividerColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                tabs: [
                  _buildTab(
                    context,
                    text: t['client_tab_summary'] ?? 'Resumen',
                  ),
                  _buildTab(context, text: t['client_tab_market'] ?? 'Mercado'),
                  _buildTab(context, text: t['client_tab_orders'] ?? 'Ordenes'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            // Resumen (Using Bookmarks + Wallet placeholder for now)
            ClientDashboardBookmarks(),

            // Mercado
            OfficeMarketplaceWidget(),

            // Ordenes (Solicitudes + Reservas)
            ClientDashboardOrders(),
          ],
        ),
      ),
    );
  }
}
