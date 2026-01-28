import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/providers/locale_provider.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['client_requests_title'] ?? 'Solicitudes',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
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

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildFilterChip(t['filter_all'] ?? 'Todos', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip(t['filter_pending'] ?? 'Pendiente', 'pending'),
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
                // Filter logic
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) =>
                  Center(child: Text("Error loading requests: $e")),
            ),
          ),
        ],
      ),
    );
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
