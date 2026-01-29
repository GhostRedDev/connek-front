import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import 'business_shared_widgets.dart';
import 'lead_newx_widget.dart';
import '../../office/widgets/greg_card.dart';
import 'service_mini_card_widget.dart';
import 'event_card_widget.dart';
// import 'content_header_widget.dart'; // Unused in this file currently
import '../providers/business_provider.dart';
import '../../../../core/providers/locale_provider.dart';

class BusinessOverviewWidget extends ConsumerWidget {
  const BusinessOverviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessData = ref.watch(businessProvider);
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return businessData.when(
      data: (data) => LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                const EmptySpaceTopWidget(),

                // --- Metric Blocks (Top Requests & Earnings) ---
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricBlock(
                          context,
                          label: t['total_requests'] ?? 'TOTAL REQUESTS',
                          value: '${data.totalRequests}',
                          percentage: '12%',
                          iconAsset: 'assets/images/user_add_bg.png',
                          iconData: Icons.person_add_alt_1_rounded,
                          colorIconBg: Colors.blueAccent,
                          sinceText:
                              t['since_last_month'] ?? 'since last month',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildMetricBlock(
                          context,
                          label: t['earnings'] ?? 'EARNINGS',
                          value: '${data.monthEarnings}',
                          percentage: '12%',
                          iconAsset: 'assets/images/flash_bg.png',
                          iconData: Icons.flash_on_rounded,
                          colorIconBg: Colors.amber,
                          sinceText:
                              t['since_last_month'] ?? 'since last month',
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildMetricBlock(
                        context,
                        label: t['total_requests'] ?? 'TOTAL REQUESTS',
                        value: '${data.totalRequests}',
                        percentage: '12%',
                        iconAsset: 'assets/images/user_add_bg.png',
                        iconData: Icons.person_add_alt_1_rounded,
                        colorIconBg: Colors.blueAccent,
                        sinceText: t['since_last_month'] ?? 'since last month',
                      ),
                      const SizedBox(height: 12),
                      _buildMetricBlock(
                        context,
                        label: t['earnings'] ?? 'EARNINGS',
                        value: '${data.monthEarnings}',
                        percentage: '12%',
                        iconAsset: 'assets/images/flash_bg.png',
                        iconData: Icons.flash_on_rounded,
                        colorIconBg: Colors.amber,
                        sinceText: t['since_last_month'] ?? 'since last month',
                      ),
                    ],
                  ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),

                if (isDesktop) ...[
                  // Desktop Grid Layout
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Leads (60%)
                      Expanded(
                        flex: 3,
                        child: _buildSectionContainer(
                          context,
                          title: t['recent_leads'] ?? 'Leads recientes',
                          content: data.recentLeads.isEmpty
                              ? const _NoLeadsCard()
                              : Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ...data.recentLeads
                                        .take(4)
                                        .map((e) => LeadNewxWidget(lead: e)),
                                    if (data.recentLeads.length > 4)
                                      _SeeAllLeadsCard(
                                        excessCount:
                                            data.recentLeads.length - 4,
                                      ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(width: 20),
                      // Column 2: Events (40%)
                      Expanded(
                        flex: 2,
                        child: _buildSectionContainer(
                          context,
                          title: t['upcoming_events'] ?? 'Próximos Eventos',
                          action: _buildSeeAllButtons(
                            context,
                            t,
                            onAdd: () {
                              context.push('/business/create-portfolio');
                            },
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: EventCardWidget(
                              event: data.events.isNotEmpty
                                  ? data.events.first
                                  : const {
                                      'title': 'Promoción Especial',
                                      'description': 'Ejemplo de evento',
                                      'promo_text': 'PROXIMAMENTE',
                                    },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Employees
                      Expanded(
                        child: _buildSectionContainer(
                          context,
                          title: t['employees'] ?? 'Empleados',
                          content: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: data.employees
                            children: data.employees
                                .map(
                                  (e) {
                                  debugPrint('🧐 Employee Data (Desktop): $e');
                                  final rawActive = e['active'] ?? e['is_active'];
                                  final isActive = rawActive == true || rawActive == 1 || rawActive.toString().toLowerCase() == 'true';
                                  
                                  return GregCard(
                                    isActive: isActive,
                                  );
                                  },
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Column 2: Services
                      Expanded(
                        child: _buildSectionContainer(
                          context,
                          title: t['services'] ?? 'Servicios',
                          action: _buildSeeAllButtons(
                            context,
                            t,
                            onAdd: () {
                              context.push('/business/create-service');
                            },
                          ),
                          content: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: data.services
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      // Navigate to edit service
                                      context.push(
                                        '/business/create-service',
                                        extra: e,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: ServiceMiniCardWidget(service: e),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Mobile Vertical Layout
                  _buildSectionContainer(
                    context,
                    title: t['recent_leads'] ?? 'Leads recientes',
                    content: data.recentLeads.isEmpty
                        ? const _NoLeadsCard()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...data.recentLeads
                                    .take(4)
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: LeadNewxWidget(lead: e),
                                      ),
                                    ),
                                if (data.recentLeads.length > 4)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: _SeeAllLeadsCard(
                                      excessCount: data.recentLeads.length - 4,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  _buildSectionContainer(
                    context,
                    title: t['employees'] ?? 'Empleados',
                    content: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: data.employees
                        children: data.employees
                            .map(
                              (e) {
                                debugPrint('🧐 Employee Data (Mobile): $e');
                                final rawActive = e['active'] ?? e['is_active'];
                                final isActive = rawActive == true || rawActive == 1 || rawActive.toString().toLowerCase() == 'true';

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GregCard(
                                    isActive: isActive,
                                  ),
                                );
                              },
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildSectionContainer(
                    context,
                    title: t['services'] ?? 'Servicios',
                    action: _buildSeeAllButtons(
                      context,
                      t,
                      onAdd: () {
                        context.push('/business/create-service');
                      },
                    ),
                    content: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: data.services
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ServiceMiniCardWidget(service: e),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildSectionContainer(
                    context,
                    title: t['events'] ?? 'Eventos',
                    action: _buildSeeAllButtons(
                      context,
                      t,
                      onAdd: () {
                        context.push('/business/create-portfolio');
                      },
                    ),
                    content: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: EventCardWidget(
                        event: data.events.isNotEmpty
                            ? data.events.first
                            : const {
                                'title': 'Promoción Especial',
                                'description': 'Ejemplo de evento',
                                'promo_text': 'PROXIMAMENTE',
                              },
                      ),
                    ),
                  ),
                ],

                const EmptySpaceWidget(),
              ],
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) {
        debugPrint('Error in BusinessOverview: $e\n$st');
        return Center(child: SelectableText("Error loading business data: $e"));
      },
    );
  }

  // --- Helper: Metric Block (from user code structure) ---
  Widget _buildMetricBlock(
    BuildContext context, {
    required String label,
    required String value,
    required String percentage,
    required IconData iconData,
    required Color colorIconBg,
    required String sinceText,
    String? iconAsset,
  }) {
    // Approximating FlutterFlowTheme.of(context).bg2Sec
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg2Sec = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : Colors.grey.shade200;

    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: bg2Sec,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.outfit(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorIconBg.withOpacity(
                    0.2,
                  ), // Approximating secondaryBackground + image
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(iconData, color: colorIconBg, size: 24),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                percentage,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.green),
              ),
              const SizedBox(width: 5),
              Text(
                sinceText,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Helper: Section Container ---
  Widget _buildSectionContainer(
    BuildContext context, {
    required String title,
    required Widget content,
    Widget? action,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg2Sec = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : Colors.grey.shade200;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bg2Sec,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (action != null) action,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildSeeAllButtons(
    BuildContext context,
    Map<String, String> t, {
    VoidCallback? onAdd,
  }) {
    return Row(
      children: [
        InkWell(
          onTap: onAdd,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 34,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Icon(Icons.add, size: 20),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Text(
            t['see_all'] ?? 'Todos',
            style: GoogleFonts.outfit(fontSize: 13, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _SeeAllLeadsCard extends StatelessWidget {
  final int excessCount;
  const _SeeAllLeadsCard({this.excessCount = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to full leads list
        context.push('/business/leads');
      },
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF0F2027),
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0F2027), // Deep Blue/Black
              Color(0xFF203A43),
              Color(0xFF2C5364), // Blue-ish
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ver todos\nlos leads',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30),
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            // Fake avatars for visual effect (static colors or maybe dynamic if we wanted)
            SizedBox(
              width: 80,
              height: 30,
              child: Stack(
                children: [
                  _buildMiniAvatar(0, Colors.red),
                  _buildMiniAvatar(20, Colors.green),
                  _buildMiniAvatar(40, Colors.orange),
                ],
              ),
            ),
            if (excessCount > 0)
              Text(
                '+$excessCount',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniAvatar(double left, Color color) {
    return Positioned(
      left: left,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: color,
          child: const Icon(Icons.person, size: 12, color: Colors.white),
        ),
      ),
    );
  }
}

class _NoLeadsCard extends StatelessWidget {
  const _NoLeadsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 48,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'Sin leads por ahora',
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
