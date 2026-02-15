import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/providers/locale_provider.dart';
import '../../system_ui/core/constants.dart';

import 'providers/client_requests_provider.dart';
import 'widgets/client_request_card.dart';
import 'models/service_request_model.dart';

class ClientDashboardRequests extends ConsumerStatefulWidget {
  const ClientDashboardRequests({super.key});

  @override
  ConsumerState<ClientDashboardRequests> createState() =>
      _ClientDashboardRequestsState();
}

class _ClientDashboardRequestsState
    extends ConsumerState<ClientDashboardRequests> {
  String _selectedFilter =
      'all'; // Internal ID: all, pending, completed, cancelled

  String _selectedTab = 'requests'; // requests | offers

  @override
  Widget build(BuildContext context) {
    // 1. Fetch Requests
    final requestsAsync = ref.watch(clientRequestsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    // Translations
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.ultraWide),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            t['client_requests_title'] ?? 'Solicitudes',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => context.push('/client/request'),
                          icon: const Icon(Icons.add),
                          label: Text(
                            t['client_publish_job'] ?? 'Publicar trabajo',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t['client_requests_subtitle'] ??
                          'Consulta las solicitudes a distintas empresas.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Tabs: Solicitudes | Ofertas
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    _buildMainTabChip(
                      t['client_tab_requests'] ?? 'Solicitudes',
                      'requests',
                    ),
                    const SizedBox(width: 8),
                    _buildMainTabChip(
                      t['client_tab_offers'] ?? 'Ofertas',
                      'offers',
                    ),
                  ],
                ),
              ),

              // Filters (only for Solicitudes tab)
              if (_selectedTab == 'requests')
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      _buildFilterChip(t['filter_all'] ?? 'Todos', 'all'),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        t['filter_pending'] ?? 'Pendiente',
                        'pending',
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        t['filter_completed'] ?? 'Completado',
                        'completed',
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        t['filter_cancelled'] ?? 'Cancelado',
                        'cancelled',
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              // Content List
              Expanded(
                child: requestsAsync.when(
                  data: (allRequests) {
                    if (_selectedTab == 'offers') {
                      final offers = _flattenOffers(allRequests);
                      if (offers.isEmpty) {
                        return _buildEmptyState(
                          t['no_offers'] ?? 'Aún no tienes ofertas.',
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: offers.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final offer = offers[index];
                          return _OfferCard(
                            request: offer.request,
                            quote: offer.quote,
                            onTap: () => context.push(
                              '/client/request-details',
                              extra: offer.request,
                            ),
                          );
                        },
                      );
                    }

                    // Requests tab
                    final requests = _filterRequests(allRequests);
                    if (requests.isEmpty) {
                      return _buildEmptyState(
                        t['no_requests'] ?? 'No requests found',
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final req = requests[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildRequestCard(context, req),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) =>
                      Center(child: Text("Error loading requests: $e")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainTabChip(String label, String value) {
    final isSelected = _selectedTab == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  List<_OfferRow> _flattenOffers(List<ServiceRequest> requests) {
    final rows = <_OfferRow>[];
    for (final r in requests) {
      for (final q in r.proposals) {
        rows.add(_OfferRow(request: r, quote: q));
      }
    }
    rows.sort((a, b) => a.quote.amount.compareTo(b.quote.amount));
    return rows;
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4285F4) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  List<ServiceRequest> _filterRequests(List<ServiceRequest> requests) {
    if (_selectedFilter == 'all') return requests;

    return requests.where((r) {
      final s = r.status.toLowerCase();
      if (_selectedFilter == 'pending') {
        return s == 'pending' || s == 'pendiente';
      }
      if (_selectedFilter == 'completed') {
        return s == 'completed' || s == 'completado' || s == 'completada';
      }
      if (_selectedFilter == 'cancelled') {
        return s == 'cancelled' || s == 'cancelado' || s == 'cancelada';
      }
      return s == _selectedFilter;
    }).toList();
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(message, style: GoogleFonts.inter(color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, ServiceRequest req) {
    // Format Date and Time
    final dateStr =
        "${req.createdAt.day} ${_getMonthName(req.createdAt.month)} ${req.createdAt.year}";
    final timeStr =
        "${req.createdAt.hour > 12 ? req.createdAt.hour - 12 : req.createdAt.hour}:${req.createdAt.minute.toString().padLeft(2, '0')} ${req.createdAt.hour >= 12 ? 'PM' : 'AM'}";

    return GestureDetector(
      onTap: () => context.push('/client/request-details', extra: req),
      child: ClientRequestCard(
        title: req.title.isNotEmpty ? req.title : 'Solicitud',
        status: req.status,
        description: req.message.isNotEmpty
            ? req.message
            : "Quiero cotizar un servicio...",
        date: dateStr,
        time: timeStr,
        businessName: 'AR Labs & Vision', // Placeholder or fetch logic
        avatarUrl: req.imageUrl,
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic',
    ];
    return months[month - 1];
  }
}

class _OfferRow {
  final ServiceRequest request;
  final Quote quote;

  _OfferRow({required this.request, required this.quote});
}

class _OfferCard extends StatelessWidget {
  final ServiceRequest request;
  final Quote quote;
  final VoidCallback onTap;

  const _OfferCard({
    required this.request,
    required this.quote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    quote.businessName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '\$${quote.amount.toStringAsFixed(0)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              request.title.isNotEmpty ? request.title : 'Trabajo',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            if (quote.description.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                quote.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Ver detalles',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4285F4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
