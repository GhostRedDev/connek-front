import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'business_shared_widgets.dart';
import 'lead_newx_widget.dart';
import 'my_bots_greg_widget.dart';
import 'service_mini_card_widget.dart';
import 'event_card_widget.dart';
// import 'content_header_widget.dart'; // Unused in this file currently
import '../providers/business_provider.dart';

class BusinessOverviewWidget extends ConsumerWidget {
  const BusinessOverviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessData = ref.watch(businessProvider);

    return businessData.when(
      data: (data) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 210, 16, 16),
        child: Column(
          children: [
            const EmptySpaceTopWidget(),

            // Note: Header is handled in ClientPage sliver, but user requested ContentHeaderWidget here.
            // If I put it here, it will be double header unless I remove it from ClientPage.
            // User code: "child: ContentHeaderWidget(...)".
            // Since ClientPage already has a dynamic header, I will COMMENT OUT this specific header
            // or render it IF the parent doesn't show one.
            // Better: Render it here and SIMPLIFY ClientPage later if needed.
            // For now, let's stick to the EXACT structure requested by the user.
            // const ContentHeaderWidget(title: '¡Hi, Gabriel!', subtitle: 'See how your business is moving from the overview.'),

            // --- Metric Blocks (Top Requests & Earnings) ---
            Column(
              children: [
                _buildMetricBlock(
                  context,
                  label: 'TOTAL REQUESTS',
                  value: '${data.totalRequests}',
                  percentage: '12%',
                  iconAsset:
                      'assets/images/user_add_bg.png', // Placeholder or use Icon
                  iconData: Icons.person_add_alt_1_rounded,
                  colorIconBg: Colors.blueAccent,
                ),
                const SizedBox(height: 12),
                _buildMetricBlock(
                  context,
                  label: 'EARNINGS',
                  value: '${data.monthEarnings}',
                  percentage: '12%',
                  iconAsset: 'assets/images/flash_bg.png', // Placeholder
                  iconData: Icons.flash_on_rounded,
                  colorIconBg: Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Leads Recientes ---
            _buildSectionContainer(
              context,
              title: 'Leads recientes',
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.recentLeads
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: LeadNewxWidget(lead: e),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Empleados ---
            _buildSectionContainer(
              context,
              title: 'Empleados',
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.employees
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: MyBotsGregWidget(employee: e),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Servicios ---
            _buildSectionContainer(
              context,
              title: 'Servicios',
              action: _buildSeeAllButtons(context),
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

            // --- Eventos ---
            _buildSectionContainer(
              context,
              title: 'Eventos',
              action: _buildSeeAllButtons(context),
              content: const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: EventCardWidget(),
              ),
            ),

            const EmptySpaceWidget(),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text("Error: $e")),
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
                'desde el mes pasado',
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

  Widget _buildSeeAllButtons(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: const Icon(Icons.add, size: 20),
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Text(
            'Todos',
            style: GoogleFonts.outfit(fontSize: 13, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
