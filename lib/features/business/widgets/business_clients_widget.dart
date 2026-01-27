import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../providers/business_provider.dart';
import '../../call/services/call_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/providers/locale_provider.dart';

class BusinessClientsWidget extends ConsumerStatefulWidget {
  const BusinessClientsWidget({super.key});

  @override
  ConsumerState<BusinessClientsWidget> createState() =>
      _BusinessClientsWidgetState();
}

class _BusinessClientsWidgetState extends ConsumerState<BusinessClientsWidget> {
  // Call Service logic duplicated from ChatPage or reusable?
  // Ideally, use a shared method or direct call if possible.
  // For now, we will perform the navigate-and-notify dance directly here or extract it.
  final _supabase = Supabase.instance.client;

  Future<void> _initiateCall(Map<String, dynamic> client) async {
    final receiverId = client['id'];
    if (receiverId == null) return;

    // 1. My Info
    // We are the business. Need fetch? Or use Auth metadata.
    // Auth metadata might be user name, not business name.
    // Ideally we pass Business Name but Auth Metadata is safest quickway.
    final user = _supabase.auth.currentUser;
    final myName = user?.userMetadata?['full_name'] ?? 'Business';
    final myImage = user?.userMetadata?['avatar_url'];

    // 2. Call ID
    final callId = DateTime.now().millisecondsSinceEpoch.toString();

    // 3. Navigate
    context.push('/call/$callId?isCaller=true');

    // 4. Notify
    try {
      final callService = CallService(
        _supabase,
        onOffer: (_) {},
        onAnswer: (_) {},
        onIceCandidate: (_) {},
      );

      // We know client ID is int.
      // But wait, clients table uses int ID.
      // receiverId is int.
      await callService.startCallNotification(receiverId, {
        'name': myName,
        'image': myImage,
      }, callId);
    } catch (e) {
      print('Error calling: $e');
    }
  }

  Future<void> _startChat(Map<String, dynamic> client) async {
    // Find or Create conversation logic?
    // For now, let's assume we navigate to /chats and let the user find them
    // OR better, checking if a conversation exists.
    // Since this is "My Clients" derived from conversations, a conversation MUST exist!

    // We need to Find the conversation ID for this client.
    // Since 'getClients' was derived from 'conversations', we actually had the ID there but threw it away.
    // Optimization: Update provider to return List<ClientWithConvoId> or similar.
    // For now, easy route: Navigate to Chats List, or just Open Chat if we can find it.

    // Let's Push to /chats with extra data to filter?
    // Or just push to '/chats' main page for now.
    context.push('/chats');
  }

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessProvider).value;
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Safety check
    if (businessData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final clients = businessData.clients;

    if (clients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              t['no_active_clients'] ?? 'Aún no tienes clientes activos',
              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 24),
            _AddClientButton(isDark: isDark, t: t),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 210, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Text(
            t['clients_title'] ?? 'Clientes',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF131619),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t['clients_subtitle'] ?? 'Encuentra a todos tus clientes activos.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // List
          ...clients.map(
            (client) => _ClientCard(
              client: client,
              isDark: isDark,
              onCall: () => _initiateCall(client),
              onChat: () => _startChat(client),
              t: t,
            ),
          ),

          const SizedBox(height: 24),
          // Add Button at bottom too
          Center(
            child: _AddClientButton(isDark: isDark, t: t),
          ),
        ],
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  final Map<String, dynamic> client;
  final bool isDark;
  final VoidCallback onCall;
  final VoidCallback onChat;
  final Map<String, String> t;

  const _ClientCard({
    required this.client,
    required this.isDark,
    required this.onCall,
    required this.onChat,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final name = '${client['first_name']} ${client['last_name']}';
    // Use 'city' or 'country' if available, else 'Unknown'
    final location =
        client['city'] ??
        client['country'] ??
        (t['unknown_location'] ?? 'Ubicación desconocida');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(50), // Pill shape
      ),
      child: Row(
        children: [
          // Use standard text styling
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFF4285F4)
                        : const Color(
                            0xFF1565C0,
                          ), // Blueish tint like mockup? Mockup text is blue.
                  ),
                ),
                // const SizedBox(height: 2),
                Text(
                  location,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: isDark ? Colors.white60 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Actions
          // Call
          _ActionButton(
            icon: Icons.phone_outlined,
            isDark: isDark,
            onTap: onCall,
            isPrimary: false,
          ),
          const SizedBox(width: 12),
          // Chat
          _ActionButton(
            icon: Icons.chat_bubble_outline,
            isDark: isDark,
            onTap: onChat,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    // Primary = Blue Circle, White Icon
    // Secondary = Grey/Trans Circle, Icon Color

    if (isPrimary) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Color(0xFF4285F4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isDark ? Colors.white70 : Colors.grey[800],
            size: 22,
          ),
        ),
      );
    }
  }
}

class _AddClientButton extends StatelessWidget {
  final bool isDark;
  final Map<String, String> t;
  const _AddClientButton({required this.isDark, required this.t});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // TODO: Open Add Client Modal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t['add_client_coming_soon'] ?? 'Add Client Coming Soon',
            ),
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: Text(t['add_client_manual'] ?? "Agregar Cliente Manualmente"),
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF4285F4)),
    );
  }
}
