import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BusinessBookingsWidget extends StatefulWidget {
  const BusinessBookingsWidget({super.key});

  @override
  State<BusinessBookingsWidget> createState() => _BusinessBookingsWidgetState();
}

class _BusinessBookingsWidgetState extends State<BusinessBookingsWidget> {
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  // Mock Data matching the image
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK001',
      'title': 'Consulta de Ventas',
      'type': 'Llamada',
      'status': 'Próxima',
      'date': '27 ene 2026',
      'time': '10:00 • 30 min',
      'location': null, // No location for calls usually
      'client': {
        'name': 'Mario',
        'role': 'Cliente',
        'image': 'https://i.pravatar.cc/150?u=mario',
      },
      'agent': {
        'name': 'Katherine',
        'role': 'Agente asignado',
        'image': 'https://i.pravatar.cc/150?u=kath',
      },
      'icon': Icons.calendar_today,
    },
    {
      'id': 'BK002',
      'title': 'Reunión de Soporte Técni...',
      'type': 'Cita',
      'status': 'Completada',
      'date': '27 ene 2026',
      'time': '14:30 • 45 min',
      'location': 'Montreal, CA',
      'client': {
        'name': 'Mario',
        'role': 'Cliente',
        'image': 'https://i.pravatar.cc/150?u=mario',
      },
      'agent': {
        'name': 'Katherine',
        'role': 'Agente asignado',
        'image': 'https://i.pravatar.cc/150?u=kath',
      },
      'icon': Icons.calendar_today,
    },
    {
      'id': 'BK003',
      'title': 'Consulta General',
      'type': 'Cita',
      'status': 'Cancelada',
      'date': '27 ene 2026',
      'time': '16:00 • 20 min',
      'location': 'Montreal, CA',
      'client': {
        'name': 'Mario',
        'role': 'Cliente',
        'image': 'https://i.pravatar.cc/150?u=mario',
      },
      'agent': {
        'name': 'Katherine',
        'role': 'Agente asignado',
        'image': 'https://i.pravatar.cc/150?u=kath',
      },
      'icon': Icons.calendar_today,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Reservas',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Encuentra a todos tus clientes activos.', // Placeholder
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar reservaciones',
                hintStyle: GoogleFonts.inter(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Todos'),
                const SizedBox(width: 8),
                _buildFilterChip('Próximas'),
                const SizedBox(width: 8),
                _buildFilterChip('Completada'),
                const SizedBox(width: 8),
                _buildFilterChip('Canceladas'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Invoice List
          ..._bookings
              .map((bk) => _buildBookingCard(bk, isDark, cardColor))
              .toList(),

          // Extra space
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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

  Widget _buildBookingCard(
    Map<String, dynamic> bk,
    bool isDark,
    Color cardColor,
  ) {
    Color statusColor;
    Color statusBgColor;

    switch (bk['status']) {
      case 'Próxima':
        statusColor = const Color(0xFFF9A825); // Yellow/Orange
        statusBgColor = const Color(0xFFFFF8E1);
        break;
      case 'Completada':
        statusColor = const Color(0xFF4285F4); // Blue
        statusBgColor = const Color(0xFFE3F2FD);
        break;
      case 'Cancelada':
        statusColor = const Color(0xFFEF5350); // Red
        statusBgColor = const Color(0xFFFFEBEE);
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey[200]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1A1A)
            : const Color(0xFFF5F5F7), // Light grey bg
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: const Color(0xFF4285F4),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bk['title'],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  bk['status'],
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.more_vert, color: Colors.grey, size: 18),
            ],
          ),
          const SizedBox(height: 8),

          // Subtitle Row (Type • ID) & Location
          Row(
            children: [
              Text(
                '${bk['type']} • ${bk['id']}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF4285F4),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (bk['location'] != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 2),
                Text(
                  bk['location'],
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Date & Time
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                bk['date'],
                style: GoogleFonts.inter(
                  color: Colors.grey[800],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                bk['time'],
                style: GoogleFonts.inter(
                  color: Colors.grey[800],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Participants Row
          Row(
            children: [
              // Client
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                        bk['client']['image'],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bk['client']['name'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          bk['client']['role'],
                          style: GoogleFonts.inter(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Agent
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                        bk['agent']['image'],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bk['agent']['name'],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          bk['agent']['role'],
                          style: GoogleFonts.inter(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
